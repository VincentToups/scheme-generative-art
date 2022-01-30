(library (lib chain)
  (export chain)
  (import (chezscheme))
  (begin
    (define-syntax chain
      (lambda (expr)
	(syntax-case expr ()
	  [(_ name value) #'value]
	  [(_ name value0 value ...)
	   #'(let ((name value0))
	       (set! name value)
	       ...
	       name)])))))
