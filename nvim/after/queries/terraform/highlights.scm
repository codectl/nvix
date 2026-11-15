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
