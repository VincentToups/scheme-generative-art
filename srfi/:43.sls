;; DO NOT EDIT THIS FILE!!
;; This inlined chez-srfi library code is autogenerated using command:
;; $ ./install.chezscheme.sps ../backyard0/srfi-lib
;; Source origin: https://github.com/arcfide/chez-srfi
;; Please refer to project site for full credits and original code.
;;;;;; File header: %3a43.sls
#!r6rs
;; Automatically generated by private/make-aliased-libraries.sps
(library (srfi :43)
  (export list->vector make-vector reverse-list->vector
   reverse-vector->list vector vector->list vector-any
   vector-append vector-binary-search vector-concatenate
   vector-copy vector-copy! vector-count vector-empty?
   vector-every vector-fill! vector-fold vector-fold-right
   vector-for-each vector-index vector-index-right
   vector-length vector-map vector-map! vector-ref
   vector-reverse! vector-reverse-copy vector-reverse-copy!
   vector-set! vector-skip vector-skip-right vector-swap!
   vector-unfold vector-unfold-right vector= vector?)
  (import (srfi :43 vectors)))