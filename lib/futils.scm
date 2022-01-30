(library (lib futils)
  (export fptr-init with-fptr with-fptrs fptr-pool fptr-init-w/pool)
  (import (chezscheme))
  (begin
    (define-syntax fptr-init
      (lambda (exp)
	(syntax-case exp ()
	  [(_ type (fld val) ...)
	   (identifier? #'type)
	   #'(let* ((ptr (make-ftype-pointer type (foreign-alloc (ftype-sizeof type)))))
	       (ftype-set! type (fld) ptr val)
	       ...
	       ptr)])))

    (define-syntax fptr-init-w/pool
      (lambda (exp)
	(syntax-case exp ()
	  [(_ pool type (fld val) ...)
	   (identifier? #'type)
	   #'(let* ((ptr (pool 'alloc)))
	       (ftype-set! type (fld) ptr val)
	       ...
	       ptr)])))

    (define-syntax with-fptr
      (lambda (exp)
	(syntax-case exp ()
	  [(_ (name type (fld val) ...) body0 body ...)
	   #'(let* ((name (fptr-init type (fld val) ...))
		    (r (begin body0 body ...)))
	       (foreign-free (ftype-pointer-address name))
	       r)])))

    (define-syntax with-fptrs
      (lambda (exp)
	(syntax-case exp ()
	  [(_ () body0 body ...)
	   #'(begin body0 body ...)]
	  [(_ (form0 form ...) body0 body ...)
	   #'(with-fptr form0
			(with-fptrs (form ...) body0 body ...))])))

    (define-syntax fptr-pool
      (lambda (exp)
	(syntax-case exp ()
	  [(_ type)
	   (identifier? #'type)
	   #'(let ((free-list (list)))
	       (lambda (action . rest)
		 (cond
		  [(eq? action 'alloc)
		   (cond ((not (eq? free-list '()))
			  (let ((r (car free-list)))
			    (set! free-list (cdr free-list))
			    r))
			 (else
			  (fptr-init type)))]
		  [(eq? action 'pool)
		   (do ([ptrs rest (cdr ptrs)])
		       ((eq? ptrs '()) #t)
		     (set! free-list (cons (car ptrs) free-list)))]
		  [(eq? action 'clear)
		   (do ([i 0 (+ i 1)])
		       ((eq? free-list '()) i)
		     (let ((item (car free-list)))
		       (foreign-free (ftype-pointer-address item))
		       (set! free-list (cdr free-list))))]
		  [(eq? action 'status)
		   (list 'type (length free-list))])))])))))

