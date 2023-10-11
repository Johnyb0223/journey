open Core
open Ast

type s_exp = [%import: Exp.t]
let show = Exp.show

exception ParseError of s_exp

let string_to_urnary = function
  | "add1" -> Some Add1
  | "sub1" -> Some Sub1
  | _ -> None

let rec s_exp_to_expr : s_exp -> expr = function
  | Num n -> Num n
  | Sym "true" -> True
  | Sym "false" -> False
  | Lst [ Sym unary; arg1 ] -> (
      match string_to_urnary unary with
      | Some op -> Urnary (op, s_exp_to_expr arg1)
      | None -> raise (ParseError (Sym unary)))
  | e -> raise (ParseError e)

let rec (string_of_s_exp : s_exp -> string) = function
  | Sym x -> x
  | Num n -> string_of_int n
  | Lst exps ->
      let exps = exps |> List.map ~f:string_of_s_exp in
      "(" ^ String.concat ~sep:" " exps ^ ")"
  | Chr c -> (
      "#\\"
      ^ match c with '\n' -> "newline" | ' ' -> "space" | _ -> String.make 1 c)
  | Str s -> "\"" ^ String.escaped s ^ "\""
  | Dots -> "..."

(* [parse string] is an s_exp representation of the parsed string *)
let parse (s : string) =
  let buf = Lexing.from_string s in
  Parse.main Lex.token buf

let parse_file file =
  let inx = In_channel.create file in
  let lexbuf = Lexing.from_channel inx in
  let ast = Parse.main Lex.token lexbuf in
  In_channel.close inx;
  ast

let lex_and_parse s = s |> parse |> s_exp_to_expr

