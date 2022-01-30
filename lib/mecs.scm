(library (lib mecs (1 0))
  (export
   mecs
   component
   entity
   system
   make-mecs
   mecs-entities
   mecs-components
   mecs-component-name-map
   make-entity
   mecs-get-entities-from
   mecs-get-tracked-system-entities
   mecs-get-tracked-system
   mecs-update-system
   entity-mask
   entity-components
   entity-components-vector-ref
   entity-add-component!
   entity-add-components!
   entity-delete-components!
   entity-delete-component!
   entity-get-component
   entity-has-component?
   entity-component
   entity-set-component!
   entity-component-set!
   entity-empty?
   delete-entity!
   entity-mecs
   non-empty-entity?
   entity?
   collect-systems
   make-system
   system?
   system-mask
   entity-in-system?
   for-each-with-components
   map-with-components
   with-components
   value-component
   mecs-tests
   lookup-tracked-system)
  (import (except (chezscheme) system)
	  (lib shadchen)
	  (lib syntax-util))

  (define-syntax verbose-define
    (lambda (expr)
      (syntax-case expr ()
	[(_ id val)
	 (identifier? #'id)
	 #'(define id val)]
	[(_ (id arg ...) body0 body ...)
	 (identifier? #'id)
	 #'(define
	    (id arg ...)
	    (display (format "entering ~a ~s\n" (quote id)
			     (with-output-to-string (lambda () (pretty-print (list arg ...))))))
	    (let ((result ((lambda () body0 body ...))))
	      (display (format "exiting ~a ~s\n" (quote id) (with-output-to-string (lambda () (pretty-print result)))))
	      result))]
	[(_ (id arg ... . rest) body0 body ...)
	 (identifier? #'id)
	 #'(define
	    (id arg ... . rest)
	    (display (format "entering ~a ~s\n" (quote id) (with-output-to-string (lambda () (pretty-print (list* arg ... rest))))))
	    (let ((result ((lambda () body0 body ...))))
	      (display (format "exiting ~a ~s\n" (quote id) (with-output-to-string (lambda () (pretty-print result)))))
	      result))])))

  (define-syntax chain (lambda (expr)
			 (syntax-case expr ()
			   [(_ name form) #'form]
			   [(_ name form0 form1 ...)
			    #'(let ((name #f))
				(set! name form0)
				(set! name form1)
				...
				name)])))

  (define (fnot f)
    (lambda args (not (apply f args))))

  (define *end* -1)
  (define (end-value? x)
    (eq? *end* x))
  
  (define *empty* (list '*empty*))
  (define (empty-value? x)
    (eq? *empty* x))

  (define (double-vector-size input-vector)
    (let* ((n (vector-length input-vector))
	   (out (make-vector (* n 2) *end*)))
      (let loop ((i 0))
	(cond ((< i n)
	       (vector-set! out i (vector-ref input-vector i))
	       (loop (+ i 1)))
	      (else out)))))

  (define (mecs-protocol protocol-p)
    (lambda (components . systems)
      (let* ((systems (if (eq? systems '()) '() (car systems)))
	     (ctable (make-eq-hashtable))
	     (parsed (parse-component-args components))
	     (cvector (make-vector (length parsed)))
	     (parsed-systems (parse-system-args systems))
	     (stable (make-eq-hashtable))
	     (n-systems (length parsed-systems))
	     (svector (make-vector n-systems))
	     (the-mecs (protocol-p (make-eq-hashtable) 				   
				   cvector
				   ctable
				   svector
				   stable)))
	(let loop ((rest parsed)
		   (i 0))
	  (match rest
	    [(list) the-mecs]
	    [(list* (and (list? plist)
			 (let (name (plist-get plist 'name #f))
			   (constructor (plist-get plist 'constructor (value-component)))
			   (cleanup (plist-get plist 'cleanup (lambda (e) #f)))
			   (->string (plist-get plist '->string default-string-converter))
			   (string-> (plist-get plist 'string-> default-reader)))) rest)
	     (when (eq? name #f) (error "make-mecs (mecs-protocol)" "No component name in component plist" plist name))
	     (hashtable-set! ctable name i)
	     (vector-set! cvector i (make-component-raw the-mecs i name (expt 2 i) constructor cleanup ->string string->))
	     (loop rest (+ i 1))]))
	(let loop ((rest parsed-systems)
		   (i 0))
	  (match rest
	    ((list) the-mecs)
	    ((list* (list system-name components-list additional-args) rest)
	     (let ((the-system (apply make-tracked-system (cons* the-mecs components-list additional-args))))
	       (vector-set! svector i the-system)
	       (hashtable-set! stable system-name i))
	     (loop rest (+ i 1)))))
	the-mecs)))

  
  (define-record-type (mecs make-mecs mecs?)
    (protocol mecs-protocol)
    (fields
     (mutable entities)
     components
     component-name-map
     systems
     system-namp-map))
  
  (define-record-type (component make-component-raw component?)
    (fields
     mecs
     index
     name
     mask
     constructor
     cleanup
     ->string
     string->))
  
  (define-record-type (entity make-entity-raw entity?)
    (fields
     mecs
     components
     (mutable mask)
     (mutable component-count)))

  (define (make-system-protocol make-system-raw)
    (lambda (the-mecs . components)
      (let* ((n (length components))
	     (cc (make-vector n))
	     (mask (let loop ((s 0)
			      (rest components)
			      (i 0))
		     (match rest
		       [(list) s]
		       [(list* (and (symbol? component-name)
				    (-> name (mecs-component the-mecs name) c)) rest)
			(vector-set! cc i c)
			(loop (logor s (component-mask c))
			      rest
			      (+ i 1))]))))
	(make-system-raw the-mecs cc mask))))
  
  (define-record-type (system make-system system?)
    (protocol make-system-protocol)
    (fields mecs components mask))

  (define (make-tracked-system-protocol parent-constructor)
    (lambda (the-mecs components . opts)
      (let ((make-tracked-system-raw (apply parent-constructor (cons the-mecs components))))
	(let loop ((rest opts)
		   (tmp (make-eq-hashtable)))	  
	  (match rest
	    ((list) (make-tracked-system-raw
		     (hashtable-ref tmp 'enter #f)
		     (hashtable-ref tmp 'exit #f)
		     (hashtable-ref tmp 'update #f)
		     (make-eq-hashtable)))
	    ((list* (and
		     the-keyword
		     (or 'enter 'exit 'update))
		    (procedure? callback) rest)
	     (hashtable-set! tmp the-keyword callback)
	     (loop rest tmp))
	    ((list* (symbol? unrecognized-kw)
		    (procedure? prc) rest)
	     (error "make-tracked-system-protocol" (format "Unrecognized keyword in make-tracked-system argument list ~a" unrecognized-kw) unrecognized-kw opts))
	    (anything-else (error "make-tracked-system-protocol" (format "Cannot parse arguments to make-tracked-system-protocol") opts)))))))

  (define-record-type tracked-system
    (parent system)
    (protocol make-tracked-system-protocol)
    (fields enter exit update (mutable entities)))

  (define (tracked-system-remove-entity s e)
    (hashtable-delete! (tracked-system-entities s) e)
    (when (tracked-system-exit s)
      ((tracked-system-exit s) e))
    e)

  (define (tracked-system-add-entity s e)
    (hashtable-set! (tracked-system-entities s) e e)
    (when (tracked-system-enter s)
      ((tracked-system-enter s) e))
    e)

  (define (mecs-get-tracked-system m s-name)
    (chain _
	   (mecs-system-namp-map m)
	   (hashtable-ref _ s-name #f)
	   (if (not _) (error "mecs-get-tracked-system" "Unknown system" s-name) _)
	   (vector-ref (mecs-systems m) _)))

  (define (mecs-get-tracked-system-entities m s-name)
    (chain _
	   (mecs-get-tracked-system m s-name)
	   (hashtable-keys (tracked-system-entities _))))

  (define (mecs-update-system m s-name)
    (let* ((s (mecs-get-tracked-system m s-name))
	   (update (tracked-system-update s)))
      (vector-for-each update (hashtable-keys (tracked-system-entities s)))))

  (define mecs-get-entities-from mecs-get-tracked-system-entities)

  (define (mecs-get-tracked-system-entities-list m s-name)
    (vector->list (mecs-get-tracked-system-entities m s-name)))

  (define (entity-components-vector-ref entity i)
    (chain _  (entity-components entity)
	   (vector-ref _ i)))

  (define (entity-components-vector-set! entity i v)
    (chain _ (entity-components entity)
	   (vector-set! _ i v)))

  (define (entity-mask-logor! entity n)
    (chain _ (entity-mask entity)
	   (entity-mask-set! entity (logor _ n))
	   entity))

  (define (entity-component-count-incr! entity)
    (chain _ (entity-component-count entity)
	   (entity-component-count-set! entity (+ _ 1))))

  (define (parse-component-args arglist)
    (define (helper al ac)
      (match al
	[(list) (reverse ac)]
	[(list (symbol? component-name))
	 (reverse (cons (list
			 'name component-name
			 'constructor (lambda (e v) v))
			ac))]
	[(list* (symbol? component-name) (symbol? another-name) rest)
	 (helper (cons another-name rest)
		 (cons (list
			 'name component-name
			 'constructor (lambda (e v) v))
		       ac))]
	[(list* (symbol? component-name)
		(procedure? constructor)
		rest)
	 (helper rest
		 (cons (list 'name component-name
			     'constructor constructor)
		       ac))]
	[(list* (symbol? component-name)
		(list? plist)
		rest)
	 (helper rest
		 (cons (append (list 'name component-name) plist)
		       ac))]))
    (helper arglist '()))

  (define (list-of-symbols? lst)
    (match lst      
      ((list) #t)
      ((list* (symbol? s) rest)
       (list-of-symbols? rest))
      (anything-else #f)))

  (define (symbolic-plist? lst)
    (match lst
      ((list) #t)
      ((list x) #f)
      ((list* (symbol? x) value rest)
       (symbolic-plist? rest))
      (anything-else #f)))

  ;; You think its here: with the and/or combo pattern
  (define (parse-system-args lst)
    (if (not (list? lst))
	(error "parse-system-args" "Object must be a list." lst))
    (let loop ((rest lst)
	       (ac (list)))
      (match rest
	((list) (reverse ac))
	((or (list* (symbol? system-name)
		    (? list-of-symbols? components)
		    (? symbolic-plist? additional-args)
		    rest)
	     (and (let (additional-args '()))
		  (list* (symbol? system-name)
			 (? list-of-symbols? components)
			 rest)))
	 (loop rest (cons (list system-name components additional-args) ac)))
	(anything-else (error "parse-system-args" "Can't parse the system argument list during mecs construction starting at irritant" anything-else lst)))))

  (define (plist-get l s alt)    
    (let ((sl (memq s l)))
      (if sl (cadr sl) alt)))

  (define (plist-get-or-error l s)
    (let* ((alt (list 'what))
	   (r (plist-get l s alt)))
      (if (eq? r alt)
	  (error "plist-get-or-error" "Key not found." l s)
	  r)))

  (define (default-string-converter o)
    (with-output-to-string (lambda () (pretty-print o))))

  (define (default-reader s)
    (with-input-from-string s (lambda () (read))))
  
  (define (mecs-entities-count the-mecs)
   (vector-length (hashtable-keys (mecs-entities the-mecs))))

 (define (mecs-add-entity-to-entities! the-mecs entity)
   (let ((entities-table (mecs-entities the-mecs)))
     (when (not (hashtable-contains? entities-table entity))
       (hashtable-set! entities-table entity entity)
       entity)))

 (define (mecs-delete-entity-from-entities! the-mecs entity)
   (let ((entities-table (mecs-entities the-mecs)))
     (when (hashtable-contains? entities-table entity)
       (hashtable-delete! entities-table entity))))

 (define (mecs-list-component-names m)
   (vector->list (hashtable-keys (mecs-component-name-map m))))

 (define (delete-entity! e)
   (apply entity-delete-components!
	  (cons e (filter (lambda (c-name)
			    (entity-has-component? e c-name))
			  (mecs-list-component-names (entity-mecs e)))))
   (mecs-delete-entity-from-entities! (entity-mecs e) e))
  
 (define (mecs-component the-mecs name)
    (chain
     _ the-mecs
     (mecs-component-name-map _)
     (hashtable-contains? _ name)
     (if (not _)
	 (error "mecs-component" "Mecs component not found." _
		(hashtable-keys
		 (mecs-component-name-map the-mecs))
		name
		(list? name))
	 (hashtable-ref (mecs-component-name-map the-mecs) name 'never-here))
     (vector-ref (mecs-components the-mecs) _)))

  (define (mecs-component-index the-mecs component-name)
    (chain _ (mecs-component-name-map the-mecs)
	   (hashtable-ref _ component-name -1)
	   (if (not (= -1 _))
	       _
	       (error "mecs-component-index" "Mecs world has no such component." the-mecs component-name))))

  (define (mecs-component-mask the-mecs component-name)
    (chain _ (mecs-component the-mecs component-name)
	   (component-mask _)))

  (define (entity-component-mask entity component-name)
    (chain _ (entity-mecs entity)
	   (mecs-component-mask _ component-name)))

  (define (entity-component-index entity component-name)
    (chain _ (entity-mecs entity)
	   (mecs-component-index _ component-name)))

  (define (entity-has-component?* entity component-name)
    (let* ((ci (entity-component-index entity component-name))
	   (c? (entity-components-vector-ref entity ci)))
      (if (not (eq? *empty* c?)) c? #f)))

  (define (entity-get-component entity component-name)
    (let ((x (entity-has-component?* entity component-name)))
      (if x x (error "entity-get-component" (format "Entity does not contain the component ~a." component-name) entity component-name))))

  (define entity-component entity-get-component)

  (define (entity-set-component! entity component-name value)
    (let ((x (entity-has-component?* entity component-name)))
      (if x (entity-components-vector-set! entity (entity-component-index entity component-name) value)
	  (error "entity-set-component!" (format "Entity does not contain the component ~a." component-name) entity component-name))))

  (define entity-component-set! entity-set-component!)
  
  (define (entity-has-component? entity component-name)
    (let ((r (entity-has-component?* entity component-name)))
      (if r #t #f)))

  (define (entity-empty? entity)
    (= 0 (entity-mask entity)))

  (define (non-empty-entity? thing)
    (and (entity? thing)
	 (not (entity-empty? thing))))

  (define (entity-add-component! entity component-name arguments)
    (let ((ci (entity-component-index entity component-name))
	  (m (entity-component-mask entity component-name)))
      (chain _ (entity-mecs entity)
	     (mecs-component _ component-name)
	     (component-constructor _)
	     (apply _ (cons entity arguments))
	     (entity-components-vector-set! entity ci _))
      (entity-mask-logor! entity m)))

  (define (entity-delete-component-raw! entity component-name)
    (if (not (symbol? component-name))
	(error "entity-delete-component-raw!" "Component name must be a symbol." component-name))
    (let ((ci (entity-component-index entity component-name))
	  (m (entity-component-mask entity component-name)))
      (entity-components-vector-set! entity ci *empty*)
      (entity-mask-set! entity (logand (entity-mask entity) (lognot m)))))

  (define (entity-delete-components-raw! entity . components)
    (map
     (lambda (component)
       (entity-delete-component-raw! entity component))
     components)
    entity)

  (define (get-component-masks mecs clist)
    (map (lambda (cname)
	   (chain _ (mecs-component mecs cname)
		  (component-mask _)))
	 clist))
  
  (define (calculate-system-deltas entity added-components deleted-components systems)
    (let* ((m (entity-mecs entity))
	   (mask (entity-mask entity))
	   (added-masks (apply logor (get-component-masks m added-components)))
	   (removed-masks (apply logor (get-component-masks m deleted-components)))
	   (mask-w/-added (logor mask added-masks))
	   (mask-w/-removed (logand mask-w/-added (lognot removed-masks))))
      (vector-map (lambda (system)
		    (let ((before (mask-in-system? mask system))
			  (after (mask-in-system? mask-w/-removed system)))
		      (cond
		       ((and before (not after))
			'exit)
		       ((and (not before) after)
			'enter)
		       (else 'no-change))))
		  systems)))

  (define (entity-delete-components! entity . components)
    (let* ((systems (mecs-systems (entity-mecs entity)))
	   (deltas (calculate-system-deltas entity (list) components
					    (mecs-systems (entity-mecs entity)))))
      (vector-map (lambda (status system)
		    (when (eq? status 'exit)
		      (tracked-system-remove-entity system entity)))
		  deltas systems)
      (apply entity-delete-components-raw! entity components)
      (if (= 0 (entity-mask entity))
	  (mecs-delete-entity-from-entities! (entity-mecs entity) entity))
      entity))

  (define (entity-delete-component! entity component)
    (entity-delete-components! entity component))

  (define (entity-in-system-raw? entity system)
    (let ((em (entity-mask entity))
	  (sm (system-mask system)))
      (= sm (logand em sm))))

  (define (mask-in-system? mask system)
    (let ((sm (system-mask system)))
      (= sm (logand mask sm))))

  (define (lookup-tracked-system m name)
    (chain _ (mecs-system-namp-map m)
	   (hashtable-ref _ name #f)
	   (if _ (vector-ref (mecs-systems m) _)
	       (error "lookup-tracked-system" (format "No tracked system named ~a" name) name))))

  (define (entity-in-system? entity system)
    (cond ((symbol? system)
	   (entity-in-system-raw? entity (lookup-tracked-system (entity-mecs entity) system)))
	  ((system? system)
	   (entity-in-system-raw? entity system))
	  (else (error "entity-in-system?" "system is neither a symbol nor a bonafide system." system))))

  (define-syntax vector-iterate (lambda (expr)
				  (syntax-case expr ()
				    [(_ (value-name index-name the-vector) body0 body ...)
				     #'(let* ((v the-vector)
					      (n (vector-length v)))
					 (let loop ((index-name 0))
					   (cond ((< index-name n)
						  (let ((value-name (vector-ref v index-name)))
						    body0 body ...)
						  (loop (+ index-name 1)))
						 (else 'done))))])))

  ;; (define-syntax when (lambda (expr)
  ;; 			(syntax-case expr ()
  ;; 			  [(_ condition body0 body ...)
  ;; 			   #'(if condition (begin body0 body ...) #f)])))

  (define (make-entity the-mecs . components)
    (let* ((n-comps-in-world (vector-length (mecs-components the-mecs))))      
      (let ((entity (make-entity-raw the-mecs
				     (make-vector n-comps-in-world *empty*)
				     0
				     0)))
	(apply entity-add-components! (cons entity components))
	(when (not (entity-empty? entity))
	  (mecs-add-entity-to-entities! the-mecs entity)))))

  (define (entity-add-components-raw! entity . components)
    (let loop ((rest components))
      (match rest
	[(list)
	 entity]
	[(list* (list* (symbol? component-name) args) rest)
	 (entity-add-component! entity component-name args)
	 (loop rest)])))

  (define (entity-add-components! entity . components)
    (let* ((tracked-systems (mecs-systems (entity-mecs entity)))
	   (before (vector-map (lambda (s) (entity-in-system? entity s)) tracked-systems))
	   (_ (apply entity-add-components-raw! (cons entity components)))
	   (after (vector-map (lambda (s) (entity-in-system? entity s)) tracked-systems)))
      (vector-map (lambda (b a s)
		    (cond
		     ((and b (not a))
		      (tracked-system-remove-entity s entity))
		     ((and (not b) a)
		      (tracked-system-add-entity s entity))))
		  before after tracked-systems)
      entity))

  (define (displayf . args)
    (display (apply format args)))

  (define-syntax
    with-components
    (lambda (expr)
      (define (regularize-binding-form form)
	(syntax-case form ()
	    [(binding component-name)
	     (and (identifier? #'binding)
		  (identifier? #'component-name))
	     #'(binding (quote component-name))]
	    [(component-name)
	     (identifier? #'component-name)
	     #'(component-name (quote component-name))]
	    [component-name
	     (identifier? #'component-name)
	     #'(component-name (quote component-name))]))
      (syntax-case expr ()
	[(_ (entity binding-form ...) body0 body ...)
	 (with-syntax [(((binding component-name) ...)
			(map regularize-binding-form #'(binding-form ...)))]
	   #'(let ((entity-value entity))
	       (let ((binding (entity-get-component entity-value component-name))
		     ...)
		 body0 body ...)))])))

  (define-syntax for-each-with-components
    (lambda (expr)
      (syntax-case expr ()
	[(_ entity-list (entity-name binding-form ...) body0 body ...)
	 (identifier? #'entity-name)
	 #'(for-each (lambda (entity-name)
		       (with-components
			(entity-name binding-form ...)
			body0 body ...))
		     entity-list)])))

    (define-syntax map-with-components
      (lambda (expr)
	(syntax-case expr ()
	[(_ entity-list (entity-name binding-form ...) body0 body ...)
	 (identifier? #'entity-name)
	 #'(map (lambda (entity-name)
		       (with-components
			(entity-name binding-form ...)
			body0 body ...))
		entity-list)])))
  
    (define (collect-systems the-mecs . systems)
      (define (collect-system-info mecs systems)
	(let ((out (make-vector (length systems))))
	  (let loop ((rest systems)
		     (indexes (list))
		     (i 0))
	    (match rest
	      [(list) (list out (list->vector systems) (list->vector indexes))]
	      [(list* (symbol? tracked-system-name) rest)
	       (vector-set! out i (mecs-get-tracked-system-entities-list mecs tracked-system-name))
	       (loop rest indexes (+ i 1))]
	      [(list* (? system? s) rest)
	       (vector-set! out i (list))
	       (loop rest (cons i indexes) (+ i 1))]))))
      (let ((entities (hashtable-keys (mecs-entities the-mecs))))
	(match (collect-system-info the-mecs systems)
	  ((list output systems-vector index-vector)
	   (vector-for-each (lambda (entity)
			      (vector-for-each
			       (lambda (index)
				 (when (entity-in-system? entity (vector-ref systems-vector index))
				   (vector-set! output index (cons entity (vector-ref output index))))) index-vector))
			    entities)
	   (vector->list output)))))

  ;; (define-syntax test (lambda (expr)
  ;; 			(syntax-case (expr) ()
  ;; 			  [(_ test-name body0 body ...)
  ;; 			   #'#f;; (if (eq? #t (begin body0 body ...))
  ;; 			       ;; 	 (display (format "... : ~a: success" test-name))
  ;; 			       ;; 	 (display (format "!!! : ~a: failure" test-name)))
  ;; 			   ])))

  ;; (define (test test-name value)
  ;;   (if (eq? #t value)
  ;; 	(display (format "... : ~a : success\n" test-name))
  ;; 	(display (format "!!! : ~a : failure\n" test-name))))

  (define-syntax value-component (lambda (expr)
				   (syntax-case expr ()
				     [(value-component)
				      #'(lambda (e x) x)]
				     [(value-component default)
				      #'(let ((default-lambda (lambda () default)))
					  (lambda (e . r)
					    (if (eq? r '())
						(default-lambda)
						(car r))))]
				     [(value-component name default)
				      (identifier? #'name)
				      #'(let ((default-lambda (lambda (name) default)))
					  (lambda (e . r)
					    (if (eq? r '())
						(default-lambda e)
						(car r))))])))
  
  
  (define (mecs-tests)
    (import (srfi :64))
    (define-syntax test (lambda (expr)
			  (syntax-case expr ()
			    [(_ name body0 body ...)
			     #'(let ((nm name)) (begin (test-begin nm)
						       body0 body ...
						       (test-end nm)))])))
    (test "Basic system functionality."
	  (let* ((m (make-mecs
			       (list 'hp (value-component)
				     'mp (value-component)
				     'max-hp (value-component))))
		 (bounded-hp (make-system m 'hp 'max-hp))
		 (magical (make-system m 'mp)))
	    (make-entity m
			 (list 'hp 10)
			 (list 'max-hp 5)
			 (list 'mp 10))
	    (let* ((collections (collect-systems m bounded-hp magical))
		   (bhp (car collections))
		   (m (cadr collections)))
	      (test-equal 1 (length bhp))
	      (test-equal 1 (length m))
	      (test-equal #t (entity-has-component? (car bhp) 'hp))
	      (test-equal #t (entity-has-component? (car bhp) 'max-hp))
	      (test-equal #t (entity-has-component? (car m) 'mp)))))
    (test "Empty system functionality."
	  (let* ((m (make-mecs
			       (list 'hp (value-component)
				     'mp (value-component)
				     'max-hp (value-component))))
		 (bounded-hp (make-system m 'hp 'max-hp))
		 (magical (make-system m 'mp)))
	    (make-entity m
			 (list 'hp 10)
			 (list 'max-hp 5))
	    (let* ((collections (collect-systems m bounded-hp magical))
		   (bhp (car collections))
		   (m (cadr collections)))
	      (test-equal 1 (length bhp))
	      (test-equal 0 (length m))
	      (test-equal #t (entity-has-component? (car bhp) 'hp))
	      (test-equal #t (entity-has-component? (car bhp) 'max-hp))
	      (test-equal #t (not (entity-has-component? (car bhp) 'mp))))))
    (test "Entity-count"
	  (let* ((m (make-mecs
			       (list
				'hp (value-component)
				'mp (value-component)
				'max-hp (value-component))))
		 (bounded-hp (make-system m 'hp 'max-hp))
		 (magical (make-system m 'mp)))
	    (make-entity m
			 (list 'hp 10)
			 (list 'max-hp 5)
			 (list 'mp 10)) 
	    (make-entity m (list 'hp 10))
	    (make-entity m (list 'mp 25))
	    (make-entity m (list 'hp 10) (list 'max-hp 15))
	    (make-entity m (list 'hp 13) (list 'max-hp 15))
	    (make-entity m (list 'hp 10) (list 'max-hp 15) (list 'mp 3))
	    (displayf "entity-count ~a\n" (mecs-entities-count m))
	    (test-equal 6 (mecs-entities-count m))))
    (test "Repeated collections"
	  (let* ((m (make-mecs
			       (list
				'hp (value-component)
				'mp (value-component)
				'max-hp (value-component))))
		 (bounded-hp (make-system m 'hp 'max-hp))
		 (magical (make-system m 'mp)))
	    (make-entity m
			 (list 'hp 10)
			 (list 'max-hp 5)
			 (list 'mp 10)) 
	    (make-entity m (list 'hp 10))
	    (make-entity m (list 'mp 25))
	    (make-entity m (list 'hp 10) (list 'max-hp 15))
	    (make-entity m (list 'hp 13) (list 'max-hp 15))
	    (make-entity m (list 'hp 10) (list 'max-hp 15) (list 'mp 3))
	    (let* ((collections (collect-systems m bounded-hp magical))
		   (collections (collect-systems m bounded-hp magical))
		   (bhp (car collections))
		   (m (cadr collections)))
	      (displayf "bhp: ~a, m ~a\n" (length bhp) (length m))
	      (test-equal 4 (length bhp))
	      (test-equal 3 (length m))
	      (test-equal #t (entity-has-component? (car bhp) 'hp))
	      (test-equal #t (entity-has-component? (car bhp) 'max-hp))
	      (test-equal #t (entity-has-component? (car m) 'mp)))))
    (test "Adding components after creation."
	  (let* ((m (make-mecs
			       (list
				'hp (value-component)
				'mp (value-component)
				'max-hp (value-component))))
		 (bounded-hp (make-system m 'hp 'max-hp))
		 (magical (make-system m 'mp))
		 (e1 (make-entity m (list 'hp 10))))
	    (make-entity m
			 (list 'hp 10)
			 (list 'max-hp 5)
			 (list 'mp 10)) 
	    (make-entity m (list 'hp 10))
	    (make-entity m (list 'mp 25))
	    (make-entity m (list 'hp 13) (list 'max-hp 15))
	    (make-entity m (list 'hp 10) (list 'max-hp 15) (list 'mp 3))
	    (entity-add-components! e1 (list 'max-hp 10))
	    (let* ((collections (collect-systems m bounded-hp magical))
		   (collections (collect-systems m bounded-hp magical))
		   (bhp (car collections))
		   (m (cadr collections)))
	      (displayf "bhp: ~a, m ~a\n" (length bhp) (length m))
	      (test-equal 4 (length bhp))
	      (test-equal 3 (length m))
	      (test-equal #t (entity-has-component? (car bhp) 'hp))
	      (test-equal #t (entity-has-component? (car bhp) 'max-hp))
	      (test-equal #t (entity-has-component? (car m) 'mp)))))
    (test "with-components"
	  (let* ((m (make-mecs
			       (list
				'hp (value-component)
				'mp (value-component)
				'max-hp (value-component))))
		 (bounded-hp (make-system m 'hp 'max-hp))
		 (magical (make-system m 'mp))
		 (e1 (make-entity m (list 'hp 13))))
	    (make-entity m
			 (list 'hp 10)
			 (list 'max-hp 5)
			 (list 'mp 10)) 
	    (make-entity m (list 'hp 10))
	    (make-entity m (list 'mp 25))
	    (make-entity m (list 'hp 13) (list 'max-hp 15))
	    (make-entity m (list 'hp 10) (list 'max-hp 15) (list 'mp 3))
	    (entity-add-components! e1 (list 'max-hp 11))
	    (with-components
	     (e1 hp max-hp)
	     (test-equal hp 13)
	     (test-equal max-hp 11))))
    (test "for-each-with-components"
	  (let* ((m (make-mecs
			       (list
				'hp (value-component)
				'mp (value-component)
				'max-hp (value-component))))
		 (bounded-hp (make-system m 'hp 'max-hp))
		 (magical (make-system m 'mp))
		 (e1 (make-entity m (list 'hp 13))))
	    (make-entity m
			 (list 'hp 10)
			 (list 'max-hp 5)
			 (list 'mp 10)) 
	    (make-entity m (list 'hp 10))
	    (make-entity m (list 'mp 25))
	    (make-entity m (list 'hp 13) (list 'max-hp 15))
	    (make-entity m (list 'hp 10) (list 'max-hp 15) (list 'mp 3))
	    (entity-add-components! e1 (list 'max-hp 11))
	    (let ((entity-count 0))
	      (for-each-with-components
	       (car (collect-systems m bounded-hp)) (e (h hp) (m max-hp))
	       (set! entity-count (+ 1 entity-count)))
	      (test-equal entity-count 4))))
    (test "for-each-with-components-collecting-values"
	  (let* ((m (make-mecs
			       (list
				'hp (value-component)
				'mp (value-component)
				'max-hp (value-component))))
		 (bounded-hp (make-system m 'hp 'max-hp))
		 (magical (make-system m 'mp))
		 (e1 (make-entity m (list 'hp 13))))
	    (make-entity m
			 (list 'hp 10)
			 (list 'max-hp 5)
			 (list 'mp 10)) 
	    (make-entity m (list 'hp 10))
	    (make-entity m (list 'mp 25))
	    (make-entity m (list 'hp 13) (list 'max-hp 15))
	    (make-entity m (list 'hp 10) (list 'max-hp 15) (list 'mp 3))
	    (entity-add-components! e1 (list 'max-hp 11))
	    (let ((entities (list)))
	      (for-each-with-components
	       (car (collect-systems m bounded-hp)) (e (h hp) (m max-hp))
	       (set! entities (cons (list h m) entities)))
	      (test-equal (length entities) 4))))
    (test "for-each-with-components-collecting-values but no aliasing"
	  (let* ((m (make-mecs
			       (list 'hp (value-component)
				     'mp (value-component)
				     'max-hp (value-component))))
		 (bounded-hp (make-system m 'hp 'max-hp))
		 (magical (make-system m 'mp))
		 (e1 (make-entity m (list 'hp 13))))
	    (make-entity m
			 (list 'hp 10)
			 (list 'max-hp 5)
			 (list 'mp 10)) 
	    (make-entity m (list 'hp 10))
	    (make-entity m (list 'mp 25))
	    (make-entity m (list 'hp 13) (list 'max-hp 15))
	    (make-entity m (list 'hp 10) (list 'max-hp 15) (list 'mp 3))
	    (entity-add-components! e1 (list 'max-hp 11))
	    (let ((entities (list)))
	      (for-each-with-components
	       (car (collect-systems m bounded-hp)) (e hp max-hp)
	       (set! entities (cons (list hp max-hp) entities)))
	      (test-equal (length entities) 4))))
    (test "basic tracked systems test"
	  (let* ((m (make-mecs
			       (list 'hp (value-component)
				     'mp (value-component)
				     'max-hp (value-component))
			       (list 'bounded-hp
				     '(hp max-hp)
				     'magical
				     '(mp))))
		 (e1 (make-entity m (list 'hp 13))))
	    (make-entity m
			 (list 'hp 10)
			 (list 'max-hp 5)
			 (list 'mp 10)) 
	    (make-entity m (list 'hp 10))
	    (make-entity m (list 'mp 25))
	    (make-entity m (list 'hp 13) (list 'max-hp 15))
	    (make-entity m (list 'hp 10) (list 'max-hp 15) (list 'mp 3))
	    (entity-add-components! e1 (list 'max-hp 11))
	    (let ((entities (mecs-get-tracked-system-entities-list m 'bounded-hp)))
	      (test-equal (length entities) 4))))
    (test "basic tracked systems test w/ component deletion"
	  (let* ((m (make-mecs
			       (list 'hp (value-component)
				     'mp (value-component)
				     'max-hp (value-component))
			       (list 'bounded-hp
				     '(hp max-hp)
				     'magical
				     '(mp))))
		 (e1 (make-entity m (list 'hp 13))))
	    (make-entity m
			 (list 'hp 10)
			 (list 'max-hp 5)
			 (list 'mp 10)) 
	    (make-entity m (list 'hp 10))
	    (make-entity m (list 'mp 25))
	    (make-entity m (list 'hp 13) (list 'max-hp 15))
	    (make-entity m (list 'hp 10) (list 'max-hp 15) (list 'mp 3))
	    (entity-add-components! e1 (list 'max-hp 11))
	    (entity-delete-components! e1 'max-hp)
	    (let ((entities (mecs-get-tracked-system-entities-list m 'bounded-hp)))
	      (test-equal (length entities) 3))))
    (test "exit method called before component removed"
	  (let* ((success #f)
		 (m (make-mecs
			       (list 'hp (value-component)
				     'mp (value-component)
				     'max-hp (value-component))
			       (list 'bounded-hp
				     '(hp max-hp)
				     (list 'exit (lambda (e)
					      (if (entity-has-component? e 'max-hp)
						  (set! success #t)
						  (set! success #f))))
				     'magical
				     '(mp))))
		 (e1 (make-entity m (list 'hp 13))))
	    (make-entity m
			 (list 'hp 10)
			 (list 'max-hp 5)
			 (list 'mp 10)) 
	    (make-entity m (list 'hp 10))
	    (make-entity m (list 'mp 25))
	    (make-entity m (list 'hp 13) (list 'max-hp 15))
	    (make-entity m (list 'hp 10) (list 'max-hp 15) (list 'mp 3))
	    (entity-add-components! e1 (list 'max-hp 11))
	    (entity-delete-components! e1 'max-hp)
	    (test-equal success #t)))
    (test "exit method called after wholesale delete"
	  (let* ((success #f)
		 (m (make-mecs
			       (list 'hp (value-component)
				     'mp (value-component)
				     'max-hp (value-component))
			       (list 'bounded-hp
				     '(hp max-hp)
				     (list 'exit (lambda (e)
					      (if (entity-has-component? e 'max-hp)
						  (set! success #t)
						  (set! success #f))))
				     'magical
				     '(mp))))
		 (e1 (make-entity m (list 'hp 13))))
	    (make-entity m
			 (list 'hp 10)
			 (list 'max-hp 5)
			 (list 'mp 10)) 
	    (make-entity m (list 'hp 10))
	    (make-entity m (list 'mp 25))
	    (make-entity m (list 'hp 13) (list 'max-hp 15))
	    (make-entity m (list 'hp 10) (list 'max-hp 15) (list 'mp 3))
	    (entity-add-components! e1 (list 'max-hp 11))
	    (delete-entity! e1)
	    (test-equal success #t)))))

