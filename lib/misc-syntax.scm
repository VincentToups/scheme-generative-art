(library (lib misc-syntax)
  (export begin1 let-from-vector dont)
  (import (chezscheme))
  (begin
    (define-syntax begin1
	  (lambda (expr)
	    (syntax-case expr ()
	      [(_ body0 body ...)
	       #'(let ((r body0))
		   body ...
		   r)])))

    (define-syntax dont
      (lambda (expr)
	(syntax-case expr ()
	  [(_ body ...)
	   #'(begin)])))

    (define-syntax let-from-vector-safe
      (lambda (expr)
	(define (my-map f l)
	  (let loop ((rest l)
		     (acc '()))
	    (cond
	     ((eq? rest '()) (reverse acc))
	     (else
	      (loop (cdr rest)
		    (cons (f (car rest)) acc))))))
	(syntax-case expr ()
	  [(_ ((var ...) vector offset) body0 body ...)
	   (with-syntax [((term ...)
			  (let ((i 0))
			    (my-map (lambda (var)
				      (let ((old-i i))
					(set! i (+ i 1))
					(with-syntax ((var var)
						      (i-syntax (datum->syntax-object #'var old-i)))
					  #'(var (vector-ref vector (+ offset i-syntax))))))
				 (syntax->list #'(var ...)))))]
					;		 (display #'(term ...))
	     #'(let (term ...)
		 body0 body ...))])))
    
    (define-syntax let-from-vector  
      (lambda (expr)
	(syntax-case expr ()
	  [(_ (vars vector offset) body0 body ...)
	   #'(let ((v vector)
		   (o offset))
	       (let-from-vector-safe (vars v o)
				     body0 body ...))]
	  [(_ (vars vector) body0 body ...)
	   #'(let ((v vector)
		   (o 0))
	       (let-from-vector-safe (vars v o)
				     body0 body ...))])))))
