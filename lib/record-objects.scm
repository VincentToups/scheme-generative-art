(library (lib record-objects)
  (export
   get-slot
   set-slot!
   slot-ref
   slot-set!
   invoke
   object-chain
   invoke
   define-method
   get-method
   with-slots)
  (import (except (chezscheme) record?)
	  (rnrs records inspection))
  (begin

    (define accessor-cache (make-eq-hashtable))
    (define mutator-cache (make-eq-hashtable))
    (define method-cache (make-eq-hashtable))

    (define (first-match v pred)
      (define n (vector-length v))
      (define result #f)
      (define found #f)
      (do ((i 0 (+ i 1)))
	  ((or found (= i n)) result)
	(let ((item (vector-ref v i)))
	  (when (pred item)
	    (set! result item)
	    (set! found #t)))))

    (define (first-match-index v pred)
      (define n (vector-length v))
      (define found #f)
      (do ((i 0 (+ i 1)))
	  ((or found (= i n)) (if found (-  i 1) #f))
	(let ((item (vector-ref v i)))
	  (when (pred item)
	    (set! found #t)))))
    
    (define (get-slot-accessor-raw rtd name)
      (define names (record-type-field-names rtd))
      (define parent (record-type-parent rtd))
      (define ix (first-match-index names (lambda (field-name)
					    (eq? field-name name))))
      (cond (ix (record-accessor rtd ix))
	    (parent
	     (get-slot-accessor-raw parent name))
	    (else
	     (error "get-slot-accessor" "No slot" rtd name))))
    
    (define (maybe-get-slot-accessor-raw rtd name otherwise)
      (define names (record-type-field-names rtd))
      (define parent (record-type-parent rtd))
      (define ix (first-match-index names (lambda (field-name)
					    (eq? field-name name))))
      (cond (ix (record-accessor rtd ix))
	    (parent
	     (maybe-get-slot-accessor-raw parent name otherwise))
	    (else
	     otherwise)))

    (define (get-slot-mutator-raw rtd name)
      (define names (record-type-field-names rtd))
      (define parent (record-type-parent rtd))
      (define ix (first-match-index names (lambda (field-name)
					    (eq? field-name name))))
      (cond (ix (record-mutator rtd ix))
	    (parent
	     (get-slot-mutator-raw parent name))
	    (else
	     (error "get-slot-mutator" "No slot" rtd name))))

    (define not-found (gensym))
    (define (get-slot-accessor rtd name)
      (let* ((k (+ (symbol-hash (record-type-name rtd)) (symbol-hash name)))
	     (r (hashtable-ref accessor-cache k not-found)))
	(cond ((eq? r not-found)
	       (let ((r-slow (get-slot-accessor-raw rtd name)))
		 (hashtable-set! accessor-cache k r-slow)
		 r-slow))
	      (else r))))

    (define (maybe-get-slot-accessor rtd name dft)
      (let* ((k (+ (symbol-hash (record-type-name rtd)) (symbol-hash name)))
	     (r (hashtable-ref accessor-cache k not-found)))
	(cond ((eq? r not-found)
	       (let ((r-slow (maybe-get-slot-accessor-raw rtd name dft)))
		 (hashtable-set! accessor-cache k r-slow)
		 r-slow))
	      (else r))))

    (define (get-slot-mutator rtd name)
      (let* ((k (+ (symbol-hash (record-type-name rtd)) (symbol-hash name)))
	     (r (hashtable-ref mutator-cache k not-found)))
	(cond ((eq? r not-found)
	       (let ((r-slow (get-slot-mutator-raw rtd name)))
		 (hashtable-set! mutator-cache k r-slow)
		 r-slow))
	      (else r))))

    (define (display-nl k)
      (display k)
      (newline))

    (define (get-method obj method-name dft)
      (define rtd (if (record-type-descriptor? obj) obj (record-rtd obj)))
      (let* ((k (+ (symbol-hash (record-type-name rtd)) (symbol-hash method-name)))
	     (r (hashtable-ref method-cache k dft))
	     (pt (record-type-parent rtd)))
	(cond ((not (eq? r dft)) r)
	      ((and (eq? r dft)
		    pt)
	       (get-method pt method-name dft))
	      (else dft))))

    (define (set-method! rtd method-name def)      
      (let* ((k (+ (symbol-hash (record-type-name rtd)) (symbol-hash method-name))))
	(hashtable-set! method-cache k def)))

    (define-syntax define-method
      (lambda (expr)
	(define (symbol-cat s1 s2)
	  (string->symbol (string-append (symbol->string s1) "-" (symbol->string s2))))
	(syntax-case expr ()
	  [(_ type-name (method-name other-terms ...) body0 body ...)
	   (and (identifier? #'type-name)
		(identifier? #'method-name))
	   (with-syntax ([full-method-name (datum->syntax-object
					    #'type-name
					    (symbol-cat
					     (syntax->datum #'type-name)
					     (syntax->datum #'method-name)))])
	     #'(define full-method-name
		 (let ()
		   (define (full-method-name other-terms ...)
		     body0 body ...)
		   (set-method! (record-type-descriptor type-name)
				'method-name
				full-method-name)
		   full-method-name)))])))
    
    (define (get-slot obj slot-name)
      (let ((accessor (get-slot-accessor (record-rtd obj) slot-name)))
	(accessor obj)))

    (define slot-ref get-slot)
    
    (define (set-slot! obj slot-name new-value)
      (let ((mutator! (get-slot-mutator (record-rtd obj) slot-name)))
	(mutator! obj new-value)
	obj))

    (define slot-set! set-slot!)

    (define (invoke obj slot-name . args)
      (define rtd (record-rtd obj))
      (let* ((accessor (maybe-get-slot-accessor rtd slot-name not-found))
	     (value (if (eq? not-found accessor)
			(get-method rtd slot-name not-found)
			accessor)))
	(if (eq? value not-found)
	    (error "invoke" "no method or slot" obj slot-name accessor value (get-method rtd slot-name not-found)))
	(apply value (cons obj args))))

    (define-syntax with-slots
      (lambda (expr)
	(define (rationalize-form form)
	  (syntax-case form ()
	    [thing
	     (identifier? #'thing)
	     #'(thing thing)]
	    [(name slot)
	     (and (identifier? #'thing)
		  (identifier? #'slot))
	     #'(name slot)]))
	(define (rationalize-forms forms acc)
	  (cond ((eq? forms '())
		 (reverse acc))
		(else
		 (rationalize-forms (cdr forms)
				    (cons (rationalize-form (car forms))
					  acc)))))
	(syntax-case expr ()
	  [(_ (object (form ...))
	      body0 body ...)
	   (with-syntax [(((name slot) ...) (rationalize-forms #'(form ...) '()))]
	     #'(let ((o object))
		 (let ((name (slot-ref object 'slot))
		       ...)
		   body0 body ...)))])))

    (define-syntax object-chain
      (lambda (expr)
	(syntax-case expr ()
	  [(_ obj) #'obj]
	  [(_ obj id rest ...)
	   (identifier? #'id)
	   #'(object-chain (get-slot obj 'id) rest ...)]
	  [(_ obj (id arg ...) rest ...)
	   (identifier? #'id)
	   #'(object-chain (invoke obj 'id arg ...)
			   rest ...)])))))

