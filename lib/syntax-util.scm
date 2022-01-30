(library (lib syntax-util)
  (export all-identifiers? define-syntax-case syntax-case-lambda with-syntax*)
  (import (chezscheme))

  (define (all-identifiers? syntax-list)
	(cond ((eq? syntax-list '()) #t)
	      ((identifier? (car syntax-list))
	       (all-identifiers? (cdr syntax-list)))
	      (else #f)))

  (define-syntax with-syntax*
    (lambda (expr)
      (syntax-case expr ()
	[(_ () body0 body ...)
	 #'(begin body0 body ...)]
	[(_ ((p0 expr0) (p expr) ...) body0 body ...)
	 #'(with-syntax [(p0 expr0)]
	     (with-syntax* [(p expr) ...] body0 body ...))])))

  (define-syntax syntax-case-lambda
    (lambda (expr)
      (syntax-case expr ()
	[(_ x l terms ...)
	 #'(lambda (x)
	     (syntax-case x l terms ...))])))
  
  (define-syntax define-syntax-case
    (lambda (expr)
      (define (all-identifiers? syntax-list)
	(cond ((eq? syntax-list '()) #t)
	      ((identifier? (car syntax-list))
	       (all-identifiers? (cdr syntax-list)))
	      (else #f)))
      (syntax-case expr ()
	[(_ (transformer-name expr-name (literal ...)) terms0 terms ...)
	 (and (identifier? #'transformer-name)
	      (identifier? #'expr-name)
	      (all-identifiers? (syntax->list #'(literal ...))))
	 #'(define-syntax transformer-name
	     (lambda (expr-name)
	       (syntax-case expr-name (literal ...)
		 terms0 terms ...)))]))))

