;; DO NOT EDIT THIS FILE!!
;; This inlined chez-srfi library code is autogenerated using command:
;; $ ./install.chezscheme.sps ../backyard0/srfi-lib
;; Source origin: https://github.com/arcfide/chez-srfi
;; Please refer to project site for full credits and original code.
;;;;;; File header: %3a6/basic-string-ports/compat.loko.sls
;; Copyright © 2019 Göran Weinholt
;; SPDX-License-Identifier: MIT
#!r6rs
(library (srfi :6 basic-string-ports compat)
  (export open-output-string get-output-string)
  (import (only (loko) open-output-string get-output-string)))
