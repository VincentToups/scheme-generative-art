;; DO NOT EDIT THIS FILE!!
;; This inlined chez-srfi library code is autogenerated using command:
;; $ ./install.chezscheme.sps ../backyard0/srfi-lib
;; Source origin: https://github.com/arcfide/chez-srfi
;; Please refer to project site for full credits and original code.
;;;;;; File header: %3a2/and-let%2a.sls
#!r6rs
;; Copyright 2010 Derick Eddington.  My MIT-style license is in the file named
;; LICENSE from the original collection this file is distributed with.
(library (srfi :2 and-let*)
  (export and-let*)
  (import (rnrs))
  (define-syntax and-let*
    (syntax-rules () [(_ . r) (and-let*-core #t . r)]))
  (define-syntax and-let*-core
    (lambda (stx)
      (syntax-case stx ()
        [(kw _ ((var expr) . c) . b)
         #'(let ([var expr]) (and var (kw var c . b)))]
        [(kw last ((expr) . c) . b) #'(kw last ((t expr) . c) . b)]
        [(kw _ (id . c) . b)
         (identifier? #'id)
         #'(and id (kw id c . b))]
        [(_ last ()) #'last]
        [(_ _ () . b) #'(let () . b)]))))