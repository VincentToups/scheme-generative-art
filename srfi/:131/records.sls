;; DO NOT EDIT THIS FILE!!
;; This inlined chez-srfi library code is autogenerated using command:
;; $ ./install.chezscheme.sps ../backyard0/srfi-lib
;; Source origin: https://github.com/arcfide/chez-srfi
;; Please refer to project site for full credits and original code.
;;;;;; File header: %3a131/records.sls
(library (srfi :131 records)
  (export define-record-type)
  (import
    (except (rnrs) define-record-type)
    (srfi :99 records procedural))
  (define-syntax define-record-type
    (syntax-rules ()
      [(_ (type-name parent) constructor-spec predicate-spec .
          field-specs)
       (define-record-type-helper0 type-name parent
         constructor-spec predicate-spec . field-specs)]
      [(_ type-name constructor-spec predicate-spec . field-specs)
       (define-record-type-helper0 type-name #f constructor-spec
         predicate-spec . field-specs)]))
  (define-syntax define-record-type-helper0
    (syntax-rules ()
      [(_ type-name parent constructor-spec predicate-spec .
          field-specs)
       (define-record-type-helper1 type-name parent
         constructor-spec predicate-spec field-specs ())]))
  (define-syntax define-record-type-helper1
    (syntax-rules ()
      [(_ type-name parent constructor-spec predicate-spec ()
          revspecs)
       (define-record-type-helper2 type-name parent
         constructor-spec predicate-spec revspecs () () ())]
      [(_ type-name parent constructor-spec predicate-spec
          (spec . field-specs) revspecs)
       (define-record-type-helper1 type-name parent constructor-spec predicate-spec
         field-specs (spec . revspecs))]))
  (define-syntax define-record-type-helper2
    (syntax-rules ()
      [(_ type-name parent constructor-spec predicate-spec ()
          accessors mutators fields)
       (define-record-type-helper type-name fields parent
         constructor-spec predicate-spec accessors mutators)]
      [(_ type-name parent constructor-spec predicate-spec
          ((field-name accessor-name) . field-specs) accessors
          mutators fields)
       (define-record-type-helper2 type-name parent constructor-spec predicate-spec
         field-specs ((accessor-name field-name) . accessors)
         mutators (field-name . fields))]
      [(_ type-name parent constructor-spec predicate-spec
          ((field-name accessor-name mutator-name) . field-specs)
          accessors mutators fields)
       (define-record-type-helper2 type-name parent constructor-spec predicate-spec
         field-specs ((accessor-name field-name) . accessors)
         ((mutator-name field-name) . mutators)
         (field-name . fields))]))
  (define-syntax define-record-type-helper
    (syntax-rules ()
      [(_ type-name fields parent #f predicate
          ((accessor field) ...) ((mutator mutable-field) ...))
       (define-record-type-helper type-name fields parent ignored predicate
         ((accessor field) ...) ((mutator mutable-field) ...))]
      [(_ type-name fields parent constructor #f
          ((accessor field) ...) ((mutator mutable-field) ...))
       (define-record-type-helper type-name fields parent constructor ignored
         ((accessor field) ...) ((mutator mutable-field) ...))]
      [(_ type-name fields parent (constructor args) predicate
          ((accessor field) ...) ((mutator mutable-field) ...))
       (begin
         (define type-name (make-rtd 'type-name 'fields parent))
         (define constructor (rtd-constructor type-name 'args))
         (define predicate (rtd-predicate type-name))
         (define accessor (rtd-accessor type-name 'field))
         ...
         (define mutator (rtd-mutator type-name 'mutable-field))
         ...)]
      [(_ type-name fields parent constructor predicate
          ((accessor field) ...) ((mutator mutable-field) ...))
       (begin
         (define type-name (make-rtd 'type-name 'fields parent))
         (define constructor (rtd-constructor type-name))
         (define predicate (rtd-predicate type-name))
         (define accessor (rtd-accessor type-name 'field))
         ...
         (define mutator (rtd-mutator type-name 'mutable-field))
         ...)])))