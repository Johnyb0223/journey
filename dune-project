(lang dune 3.10)

(name journey)

(using menhir 2.1)

(package
 (name journey)
 (synopsis "A journey into compilers")
 (depends ocaml dune ppx_import ppx_deriving core)
 (allow_empty)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
