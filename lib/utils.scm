(library (lib utils)
  (export float int named-lambda plist-ref shell-command-to-lines get-file-size-bytes
	  create-black-image
	  temporary-filename
	  dont)
  (import (chezscheme))
  (begin

    (define-syntax dont
      (lambda (expr)
	(syntax-case expr ()
	  [(_ body ...) #'(begin)])))

    (define-syntax chain
      (lambda (expr)
	(syntax-case expr ()
	  [(_ name form)
	   (identifier? #'name)
	   #'form]
	  [(_ name form0 form ...)
	   (identifier? #'name)
	   #'(let ((name form0))
	       (chain name form ...))])))

    (define (process* command . args)
      (cond ((eq? args '())
	     (process command))
	    (else
	     (process (apply format (cons command args))))))

    (define  (shell-command-to-lines command . rest)
      (let* ((r (apply process* (cons command rest)))
	     (process-input-port (car r)))
	(let loop ((result (get-line process-input-port))
		   (acc (list)))
	  (cond ((eof-object? result) (reverse acc))
		(else (loop (get-line process-input-port)
			    (cons result acc)))))))

    (define (get-file-size-bytes filename)
      (chain $ (shell-command-to-lines (format "stat -c %s ~s" filename))
	     (car $)
	     (string->number $)))

    (define (create-black-image filename width height)
      (shell-command-to-lines "convert -size ~dx~d xc:#000000 ~s" width height filename))

    (define (temporary-filename prefix)
      (chain $ (shell-command-to-lines "mktemp -p ~s" prefix)
	     (car $)))
    
    (define (float x)
      (exact->inexact x))
    (define (int x)
      (inexact->exact (round x)))
    (define-syntax named-lambda
      (lambda (expr)
	(syntax-case expr ()
	  [(_ (name arg ...) body0 body ...)
	   (identifier? #'name)
	   #'(let ()
	       (define (name arg ...)
		 body0 body ...)
	       name)]
	  [(_ (name . rest) body0 body ...)
	   (identifier? #'name)
	   #'(let ()
	       (define (name . rest)
		 body0 body ...)
	       name)])))
    (define (plist-ref plist sym otherwise)
      (cond ((eq? plist '()) otherwise)
	    ((eq? (car plist) sym) (cadr plist))
	    (else (plist-ref (cddr plist) sym otherwise))))))
