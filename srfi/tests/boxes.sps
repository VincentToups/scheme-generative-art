;; DO NOT EDIT THIS FILE!!
;; This inlined chez-srfi library code is autogenerated using command:
;; $ ./install.chezscheme.sps ../backyard0/srfi-lib
;; Source origin: https://github.com/arcfide/chez-srfi
;; Please refer to project site for full credits and original code.
;;;;;; File header: ./tests/boxes.sps
;; Copyright © 2020 Amirouche Boubekki
;; SPDX-License-Identifier: MIT
#!r6rs
(import (rnrs) (srfi :111 boxes) (srfi :64 testing))
(test-begin "boxes")
(test-equal #t (box? (box 42)))
(test-equal 42 (unbox (box 42)))
(test-equal
  42
  (let ([b (box 0)]) (set-box! b 42) (unbox b)))
(test-end "boxes")
