;; extends

; Stock hcl query puts attribute names, object keys and `.field` references all in
; @variable.member. Split them so they can be colored apart.

; attribute names:  bucket = ...
(attribute
  (identifier) @property)

; object keys:  { key = val }
(object_elem
  key: (expression
    (variable_expr
      (identifier) @property)))

; first block label is the resource/data type:  resource "aws_s3_bucket" "b"
; (the inner template_literal is what @string captures, so capture that)
(block
  (identifier)
  .
  (string_lit
    (template_literal) @type))

; second block label is the resource/module name:  resource "aws_s3_bucket" "b"
; a unique identifier, not data — color it like a constant, not like a string value
(block
  (identifier)
  (string_lit)
  .
  (string_lit
    (template_literal) @string.special))

; single-label block is a name, not a type:  module "vpc", variable "region", output "id"
; (later pattern wins over the @type rule above)
(block
  (identifier)
  .
  (string_lit
    (template_literal) @string.special)
  .
  (block_start))

; type constructors in `type = ...` expressions are types, not function calls:
;   object({...}), optional(string, "x"), map(string), list(number), set(...), tuple([...])
(function_call
  (identifier) @type.builtin
  (#any-of? @type.builtin "optional" "object" "map" "list" "set" "tuple"))
