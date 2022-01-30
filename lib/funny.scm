(library (lib funny)
  (export id pipeline apply-pipeline rcompose compose left right // /x /xy /i /ij)
  (import (chezscheme))
  (begin
    (define-syntax /x
      (lambda (expr)
	(syntax-case expr ()
	  [(/x body0 body ...)
	   (with-syntax ([arg (datum->syntax-object #'/x 'x)])
	     #'(lambda (arg) body0 body ...))])))
    (define-syntax /xy
      (lambda (expr)
	(syntax-case expr ()
	  [(/xy body0 body ...)
	   (with-syntax ([x (datum->syntax-object #'/xy 'x)]
			 [y (datum->syntax-object #'/xy 'y)])
	     #'(lambda (x y) body0 body ...))])))

    (define-syntax /i
      (lambda (expr)
	(syntax-case expr ()
	  [(/i body0 body ...)
	   (with-syntax ([arg (datum->syntax-object #'/i 'i)])
	     #'(lambda (arg) body0 body ...))])))

    (define-syntax /ij
      (lambda (expr)
	(syntax-case expr ()
	  [(/ij body0 body ...)
	   (with-syntax ([i (datum->syntax-object #'/ij 'i)]
			 [j (datum->syntax-object #'/ij 'j)])
	     #'(lambda (i j) body0 body ...))])))

    (define-syntax //
      (lambda (expr)
	(define (looks-like? stx sym)
	  (eq? (syntax->datum stx) sym))
	(define (transform whole-form to-parse args)
	  (syntax-case to-parse ()
	    (() (error "$ (short lambda)" "No closing -> detected expanding short lambda stx" (syntax->datum whole-form)))
	    ((hd tl ...)
	     (looks-like? #'hd '->)
	     (with-syntax (((arg0 ...) args))
	       #'(lambda (arg0 ...) tl ...)))
	    ((hd tl ...)
	     (identifier? #'hd)
	     (with-syntax (((arg0 ...) args))
	       (transform whole-form #'(tl ...) #'(arg0 ... hd))))))
	(syntax-case expr ()
	  ((_ form ...)
	   (transform #'($ form ...) #'(form ...) #'())))))
    (define id (lambda (x) x))
    (define (rcompose . funs)
      (cond ((eq? funs '()) id)
	    ((eq? (cdr funs) '()) (car funs))
	    (else
	     (lambda args
	       (let loop ((result (apply (car funs) args))
			  (fs (cdr funs)))
		 (cond ((eq? fs '()) result)
		       (else
			(loop ((car fs) result)
			      (cdr fs)))))))))
    (define (compose . funs)
      (rcompose (reverse funs)))
    (define (left f . fixed-args)
      (lambda unfixed-args
	(apply f (append fixed-args unfixed-args))))
    (define (right f . fixed-args)
      (lambda unfixed-args
	(apply f (append unfixed-args fixed-args))))
    (define (pipeline v . funs)
      ((apply rcompose funs) v))
    (define (apply-pipeline lstv . funs)
      (apply (apply rcompose funs) lstv))))
