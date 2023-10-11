open Ast


type s_exp = [%import: Exp.t]

val show : s_exp -> Ppx_deriving_runtime.string
(** [show e] returns a string representation of [e] *)

val parse : string -> s_exp
(** [parse s] parses [s] into an s-expression *)

val parse_file : string -> s_exp
(** [parse_file f] parses the contents of file [f] into a s-expression *)

val string_of_s_exp : s_exp -> string
(** [string_of_s_exp e] returns a string representation of [e] *)

val lex_and_parse : string -> expr