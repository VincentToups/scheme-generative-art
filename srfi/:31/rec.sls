;; DO NOT EDIT THIS FILE!!
;; This inlined chez-srfi library code is autogenerated using command:
;; $ ./install.chezscheme.sps ../backyard0/srfi-lib
;; Source origin: https://github.com/arcfide/chez-srfi
;; Please refer to project site for full credits and original code.
;;;;;; File header: %3a31/rec.sls
#!r6rs
;; Copyright 2009 Derick Eddington.  My MIT-style license is in the file named
;; LICENSE from the original collection this file is distributed with.
(library (srfi :31 rec)
  (export rec)
  (import (rnrs))
  (define-syntax rec
    (syntax-rules ()
      [(rec (NAME . VARIABLES) . BODY)
       (letrec ([NAME (lambda VARIABLES . BODY)]) NAME)]
      [(rec NAME EXPRESSION) (letrec ([NAME EXPRESSION]) NAME)])))
