# Compiler Development Journey

## Welcome to My Compiler Journey

In this space, I will provide a informal account of my compiler development journey. I hope you will find this journey interesting and informative.

## The Significance of Compilers and Interpreters

Compilers and interpreters, often seen as mere tools, play a significant role in the world of programming. They serve as the bridge between human-readable code and the machine's language. They translate our **intentions** into machine instructions, enabling us to execute code. It's easy to take them for granted. As I venture into the world of compilers and interpreters, I'm met with complexity and beauty that could enable a lifetime of exploration.

The next time you sit down to write code in any programming language, consider these questions:

- What would you do if you couldn't simply click the "run" button in your integrated development environment (IDE)?
- How would you obtain the result of 7 from a text file containing the simple expression (+ 3 4)?

At the heart of this journey lies the compiler, the tool that transforms the code we write into machine instructions. It serves as a bridge that imparts structure and meaning to the words we write.

To start I look at the question above. Given the expression (+ 3 4) how would I get to the value of 7?

## The Initial Challenge

I need some way to manipulate this expression that is defined in my file. My first though is to read the expression from my file as a string. Maybe then I could translate that string to its individual parts. I could read character by charater. Employing the function int_of_string to turn my number charaters to their programatic representation. I imagine a program along the following lines

(psuedocode with python style)

```python
expr = "(+ 3 4)"
def evaluate_string(expr : string):
  number_list = []
  operator = None
  for character in expr:
    if character is number:
      number_list.add(int_of_character(character))
    if character is operator:
      operator = operator_of_charater(character)
  
  return (number_list[0] operator numeber_list[1])

```

We can imagine that in a perfect world the above would give us 7. Would this function work for (- 3 2)? probably. How about (* 4 7)? Yep, I still think we are good. How about (+ 3 (+ 2 3)). Hmmmmmmm we will definitely have a problem here. The problem here lies in the fact that for the infinite variations of code we could write we would need to define a function that handles each specific case.

The solution to this is what seems to be a solution to everything involving computers. **ABSTRACTION**... What we really need is a way to represnt expression in our computer program, and the first step of that process is to abrstract away the necessary information from our expressions.

## Tokenizing

Tokenizing is the first challenge I encountered, and it's proven to be more intricate than I initially anticipated. It's the process of turning code like `(+ 3 5)` into a structure that can be easily manipulated. Tokenizing/Parsing is hard work, and there are more exciting aspects of compiler development than crafting a perfect implementation from scratch.

I've chosen to leverage the powerful OCaml parsing library known as **menhir**. While the parser's implementation is essential, what truly matters is the structure of our parsed expressions.

### s_exp: Tokenized Representation

In this context, we use the term "s_exp" to represent the tokenized version of our input. The structure of an **s_exp** can be understood through this OCaml type definition:

```ocaml
type s_exp =
  | Num of int
  | Sym of string
  | Chr of char
  | Str of string
  | Lst of s_exp list
  | Dots

```

It's crucial to grasp this structure as it's the first internal representation we introduce in the compiler development process. This structure takes our input, like (+ 3 4), and transforms it into something like:

```ocaml
Lst [Sym "+"; Num 3; Num 4]
```

This transformation breathes life and structure into an otherwise abstract sequence of characters. It dissects the expression into its essential components.

Consider a more complex example:

```ocaml
(+ (add1 4) 3)
```

Here, nesting occurs, and the s_exp structure looks something like:

```ocaml
Lst [Sym "+"; Lst [Sym "add1"; Num 4]; Num 3]
```

This representation, with its nested structure, is precisely what the S_exp library aims to achieve in my OCaml project. You are welcome to utilize it in your own implementations.
