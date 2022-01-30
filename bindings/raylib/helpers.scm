(library (bindings raylib helpers)
  (export with-raylib-preamble begin-drawing begin-drawing/w make-raylib raylib draw-render-texture)
  (import (chezscheme)
	  (bindings raylib bindings)
	  (lib record-objects)
	  (lib futils)
	  (lib utils))
  (begin
    (define (with-raylib-preamble w h name init thunk exit-thunk)
      (InitWindow w h name)
      (init)
      (let ((t (GetTime))
	    (dt 0.01))
	(let loop ((stop (WindowShouldClose)))
	  (if stop (exit-thunk t dt)
	      (let ((nt (GetTime)))
		(set! dt (- nt t))
		(set! t nt)
		(thunk t dt)
		(loop (WindowShouldClose)))))))

    (define-syntax begin-drawing
      (lambda (expr)
	(syntax-case expr ()
	  [(_ body ...)
	   #'(begin
	       (BeginDrawing)
	       (let ((r (begin body ...)))
		 (EndDrawing)
		 r))])))

    (define-syntax begin-drawing/w
      (lambda (expr)
	(syntax-case expr ()
	    [(_ (render-texture-2d)
		body ...)
	     #'(begin
		 (BeginTextureMode render-texture-2d)
		 (let ((r (begin body ...)))
		   (EndTextureMode)
		   r))])))

    (define-record-type raylib
      (fields width height title misc)
      (protocol
       (lambda (maker)
	 (lambda (width height title . rest-pairs)
	   (let ((tbl (make-eq-hashtable)))
	     (do ((hd rest-pairs (cdr (cdr rest-pairs))))
		 ((eq? rest-pairs '()))
	       (hashtable-set! tbl (car hd) (cadr hd)))
	     (maker width height title tbl))))))

    (define-method raylib
      (create-window self)
      (InitWindow (slot-ref self 'width)
		  (slot-ref self 'height)
		  (slot-ref self 'title))
      self)

    (define-method raylib
      (update self t dt)
      #t)

    (define-method raylib
      (handle-input self t dt)
      #t)

    (define white (fptr-init Color (r 255) (g 255) (b 255) (a 255)))
    (define-method raylib
      (draw self t dt)
      (BeginDrawing)
      (ClearBackground white)
      (DrawFPS 30 30)
      (EndDrawing)
      #t)

    (define-method raylib
      (stop? self t dt)
      (WindowShouldClose))

    (define-method raylib
      (cleanup self t dt)
      #f)

    (define-method raylib
      (run self)
      (define t (GetTime))
      (define dt 0.01)
      (define stop? (get-method self 'stop? #f))
      (define update (get-method self 'update #f))
      (define draw (get-method self 'draw #f))
      (define handle-input (get-method self 'handle-input #f))
      (let raylib-loop ((done (stop? self t dt)))
	(cond (done (invoke self 'cleanup t dt))
	      (else
	       (let ((now (GetTime)))
		 (set! dt (- now t))
		 (set! t now))
	       (handle-input self t dt)
	       (update self t dt)
	       (draw self t dt)
	       (raylib-loop (stop? self t dt))))))

    (define draw-render-texture
      (let ((rect-storage (fptr-init Rectangle (x 0.0) (y 0.0)))
	    (pos-storage (fptr-init Vector2))
	    (color-storage (fptr-init Color (r 255) (g 255) (b 255) (a 255))))
	(lambda (render-texture x y)
	  (ftype-set! Vector2 (x) pos-storage (float x))
	  (ftype-set! Vector2 (y) pos-storage (float y))
	  (ftype-set! Rectangle (width) rect-storage
		      (float (ftype-ref RenderTexture2D (texture width) render-texture)))
	  (ftype-set! Rectangle (height) rect-storage
		      (float (- (ftype-ref RenderTexture2D (texture height) render-texture))))
	  (DrawTextureRec
	   (ftype-&ref RenderTexture2D (texture) render-texture)
	   rect-storage
	   pos-storage
	   color-storage))))))
