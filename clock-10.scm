(import (bindings raylib bindings)
	(bindings raylib helpers)
	(bindings raylib colors)
	(lib rk4)
	(lib vector-shorthand)
	(lib chain)
	(lib futils)
	(lib particles-2d)
	(lib record-objects)
	(lib randomness)
	(lib utils)
	(lib misc-syntax)
	(lib constants))

(define (size-of-black-image width height)
  (let ((fn (string-append (temporary-filename ".") ".png")))
    (create-black-image fn width height)
    (let ((r  (get-file-size-bytes fn)))
      (delete-file fn)
      r)))

(define p: plist-ref)

(define-record-type clock-10
  (parent raylib)
  (fields n
	  (mutable state)
	  (mutable previous-state)
	  g
	  charge
	  alpha
	  canvas
	  point-age
	  color-time-constant
	  point-color
	  teleport-frequency
	  (mutable last-teleport)
	  hour-length
	  minute-length
	  second-length
	  (mutable hand-toggle))
  (protocol (named-lambda
		(clock-10-protocol-outside make-raylib)
	      (named-lambda (clock-10-protocol-inside
			     . plist)
		(let* ((make-clock-10
			(make-raylib (p: plist 'width (int (* 11 120)))
				     (p: plist 'height (int (* 8.5 120)))
				     (p: plist 'title "Clock 10")))
		       (n (p: plist 'n 100))
		       (s (make-vector (* 4 n)))
		       (ps (make-vector (* 4 n))))
		  (make-clock-10 n s ps
				 (p: plist 'g 98.0)
				 (p: plist 'charge 2000.0)
				 (p: plist 'alpha 0.01)
				 (fptr-init RenderTexture2D)
				 (make-vector n (p: plist 'color-time-constant
						    (p: plist 'initial-age (p: plist 'color-time-constant 10.0))))
				 (p: plist 'color-time-constant 10.0)
				 (p: plist 'point-color black)
				 (p: plist 'teleport-frequency 10)
				 0
				 (p: plist 'hour-length 0.5)
				 (p: plist 'minute-length 0.75)
				 (p: plist 'second-length 0.9)
				 (p: plist 'hand-toggle 'minute)))))))

(define (basic-force g)
  (lambda (s t)
    (define n (/ (vector-length s) 4))
    (define out (make-vector (* 4 n) 0.0))
    (do ([i 0 (+ i 1)])
	((= i n) out)
      (let* ([ofst (* i 4)]
	     [xi ofst]
	     [yi (+ ofst 1)]
	     [vxi (+ ofst 2)]
	     [vyi (+ ofst 3)])
	(v! out xi (v: s vxi))
	(v! out yi (v: s vyi))
	(v! out vxi 0.0)
	(v! out vyi g)))))

(define (circle-constraint-force center-x center-y px py radius max-force into offset)
  (let* ((dx (- px center-x))
	 (dy (- py center-y))
	 (d^2 (+ (* dx dx) (* dy dy))))
    (cond ((<= d^2 (* radius radius))
	   #f)
	  (else
	   (let* ((d (sqrt d^2))
		  (excess (- d radius))
		  (nx (- (/ dx d)))
		  (ny (- (/ dy d))))
	     (vincr into offset (* 1000.0 nx (min excess 3.0)))
	     (vincr into (+ 1 offset) (* 1000.0 ny (min excess 3.0))))))))

(define (drag-force vx vy alpha into offset)
  (let* ((v-mag (min (sqrt (+ (* vx vx)
			      (* vy vy)))
		     1000000))
	 (vnx (- (/ vx v-mag)))
	 (vny (- (/ vy v-mag))))
    (cond ((> v-mag 0.1)
	   (vincr into offset (* alpha vnx (* v-mag v-mag)))
	   (vincr into (+ offset 1) (* alpha vny (* v-mag v-mag))))
	  (else #f))))

(define (coulomb-force x1 y1 x2 y2 q1 q2 cc into offset-1 offset-2)
  (let* ((dx12 (- x1 x2))
	 (dy12 (- y1 y2))
	 (d^2 (+ (* dx12 dx12)
		 (* dy12 dy12)))
	 (d (sqrt d^2)))
    (cond ((< d 3.0) #f)
	  (else
	   (let ((force-mag (* q1 q2 cc (/ 1 (* d d))))
		 (force-dir-x (/ dx12 d))
		 (force-dir-y (/ dy12 d)))
	     (vincr into offset-1 (* force-mag force-dir-x))
	     (vincr into (+ 1 offset-1) (* force-mag force-dir-y))
	     (vincr into offset-2 (* force-mag (- force-dir-x)))
	     (vincr into (+ 1 offset-2) (* force-mag (- force-dir-y))))))))

(define-method clock-10
  (force self)
  (with-slots (self (width height charge alpha g n state))
    (named-lambda (a-clock-10-force state t)
      (let ((out ((basic-force g) state t)))
	(do ((i 0 (+ i 1)))
	    ((= i n) out)
	  (let ((i*4 (* i 4)))
	    (let-from-vector ((xi yi vxi vyi) state i*4)
	      (drag-force vxi vyi alpha out (+ i*4 2))
	      (circle-constraint-force (/ width 2) (/ height 2) xi yi (/ (min width height) 2.0) 10000 out (+ i*4 2))
	      (do ((j (+ i 1) (+ j 1)))
		  ((= j n) out)
		(let ((j*4 (* 4 j)))
		  (let-from-vector ((xj yj) state j*4)
		    #f
		    (coulomb-force xi yi xj yj charge charge 1.0 out (+ i*4 2) (+ j*4 2))
		    ))))))))))

(dont
 (define-method clock-10
   (force self)
   (with-slots (self (width height))
     (let ((w/2 (/ width 2))
	   (h/2 (/ height 2)))
       (lambda (s t)
	 (let* ((out ((basic-force (slot-ref self 'g)) s t))
		(s (slot-ref self 'state))
		(n (slot-ref self 'n))
		(charge (slot-ref self 'charge))
		(charge^2 (* charge charge))
		(alpha (slot-ref self 'alpha)))
	   (do ([i 0 (+ i 1)])
	       ((= i n) out)
	     (let ((i-ofst (* i 4)))
	       (let-from-vector
		   ((xi yi vxi vyi) s i-ofst)
		 (let* ((v-mag (sqrt (+ (* vxi vxi)
					(* vyi vyi))))
			(xfc (- xi w/2))
			(yfc (- yi h/2))
			(dfc (sqrt (+ (* xfc xfc)
				      (* yfc yfc))))
			(r (/ (min width height) 2))
			)
		   (when (> dfc r)
		     (let ((excess (- dfc r))
			   (ncfx (- (/ xfc dfc)))
			   (ncfy (- (/ yfc dfc))))
		       (v! out (+ i-ofst 2)
			   (+ (v: out (+ i-ofst 2))
			      (* 1000.0 ncfx excess)))
		       (v! out (+ i-ofst 3)
			   (+ (v: out (+ i-ofst 3))
			      (* 1000.0 ncfy excess)))
		       (if (or (nan? (v: out (+ i-ofst 0)))
			       (nan? (v: out (+ i-ofst 1)))
			       (nan? (v: out (+ i-ofst 2)))
			       (nan? (v: out (+ i-ofst 3))))
			   (error "stop-circle" "stop" i excess xfc yfc ncfx ncfy))))
		   (if (> v-mag 10000)
		       (set! v-mag 10000))
		   (when (> v-mag 3.0)
		     (let ((vnx (/ vxi v-mag))
			   (vny (/ vyi v-mag)))
		       (v! out (+ i-ofst 2)
			   (+ (v: out (+ i-ofst 2))
			      (* alpha (- vnx) (* v-mag v-mag))))
		       (v! out (+ i-ofst 3)
			   (+ (v: out (+ i-ofst 3))
			      (* alpha (- vny) (* v-mag v-mag))))
		       (if (or (nan? (v: out (+ i-ofst 0)))
			       (nan? (v: out (+ i-ofst 1)))
			       (nan? (v: out (+ i-ofst 2)))
			       (nan? (v: out (+ i-ofst 3))))
			   (error "stop-drag" "stop" i v-mag vnx vny vxi vyi))))
		   (do ([j (+ i 1) (+ j 1)])
		       ((= j n))
		     (let ((j-ofst (* j 4)))
		       (let-from-vector
			   ([xj yj] s j-ofst)
			 (let* ((dxij (- xi xj))
				(dyij (- yi yj))
				(d^2 (max 1.0
					  (+ (* dxij dxij)
					     (* dyij dyij))))
				(d (sqrt d^2))
				(nxij (/ dxij d))
				(nyij (/ dyij d)))
			   (when (> d 3.0)
			     (v! out (+ i-ofst 2)
				 (+ (v: out (+ i-ofst 2))
				    (/ (* charge^2 nxij) d^2)))
			     (v! out (+ i-ofst 3)
				 (+ (v: out (+ i-ofst 3))
				    (/ (* charge^2 nyij) d^2)))
			     (v! out (+ j-ofst 2)
				 (+ (v: out (+ j-ofst 2))
				    (/ (* charge^2 (- nxij)) d^2)))
			     (v! out (+ j-ofst 3)
				 (+ (v: out (+ j-ofst 3))
				    (/ (* charge^2 (- nyij)) d^2)))
			     (if (or (nan? (v: out (+ i-ofst 0)))
				     (nan? (v: out (+ i-ofst 1)))
				     (nan? (v: out (+ i-ofst 2)))
				     (nan? (v: out (+ i-ofst 3))))
				 (error "stop-em" "stop" dxij dyij d^2 d nxij nyij i j)))))))))))))))))

(define (impose-maximum-velocity state old-state max-val)
  (let ((vl (vector-length state)))
    (do ((i 0 (+ i 4)))
	((= i vl) state)
      (let* ((vx (vector-ref state (+ i 2)))
	    (vy (vector-ref state (+ i 3)))
	    (v-mag (sqrt (+ (* vx vx) (* vy vy)))))
	(cond ((or (nan? v-mag)
		   (infinite? v-mag))
	       (vector-set! state (+ i 2) (vector-ref old-state (+ i 2)))
	       (vector-set! state (+ i 3) (vector-ref old-state (+ i 3))))
	      ((> v-mag max-val)
	       (let ((nvx (* max-val (/ vx v-mag)))
		     (nvy (* max-val (/ vy v-mag))))
		 (vector-set! state (+ i 2) nvx)
		 (vector-set! state (+ i 3) nvy))))))))

(define-method clock-10
  (update self t dt)
  (impose-maximum-velocity (slot-ref self 'state)
			   (slot-ref self 'previous-state) 5000.0)
  (let* ((s (slot-ref self 'state))
	 (n (slot-ref self 'n))
	 (new-state (rk4-step (invoke self 'force)
			      s
			      t
			      dt))
	 (previous-state (slot-ref self 'previous-state)))
    (impose-maximum-velocity s previous-state 5000.0)
    (do ((i 0 (+ i 1)))
	((= i n))
      (let-from-vector ((vx vy) new-state (+ 2 (* i 4)))
	(when (> vx 10000)
	  (vector-set! new-state (+ 2 (* i 4)) 10000))
	(when (> vy 10000)
	  (vector-set! new-state (+ 3 (* i 4)) 10000))))
    (slot-set! self 'previous-state s)
    (slot-set! self 'state new-state)
    (invoke self 'handle-bounce)
    (with-slots (self (n point-age))
      (do ((i 0 (+ i 1)))
	  ((= i n) self)
	(v! point-age i (+ (v: point-age i) dt))))
    (invoke self 'handle-teleport t dt))
  self)

(define-method clock-10
  (hand-positions self)
  (let* ((date (current-date))
	 (second (+ (date-second date) (/ (date-nanosecond date) (expt 10.0 9.0))))
	 (minute (+ (date-minute date) (/ second 60.0)))
	 (hour (chain $
		      (date-hour date)
		      (if (> $ 12) (- $ 12) $)
		      (+ $  (/ minute 60.0))))
	 (second-angle (- (* 2 pi (/ second 60.0)) (/ pi 2)))
	 (minute-angle (- (* 2 pi (/ minute 60.0)) (/ pi 2)))
	 (hour-angle (- (* 2 pi (/ hour 12.0)) (/ pi 2))))
    (with-slots (self (hour-length minute-length second-length width height))
      (let ((m (/ (min width height) 2.0)))
	(vector (* m hour-length (cos hour-angle))
		(* m hour-length (sin hour-angle))
		(* m minute-length (cos minute-angle))
		(* m minute-length (sin minute-angle))
		(* m second-length (cos second-angle))
		(* m second-length (sin second-angle)))))))

(define-method clock-10
  (draw-clock-hands self)
  (with-slots (self (width height))
    (let ((w/2 (/ width 2))
	  (h/2 (/ height 2)))
      (let-from-vector ((hx hy mx my sx sy) (invoke self 'hand-positions))
	(DrawCircle (int (+ w/2 hx)) (int (+ h/2 hy)) 15.0 red)
	(DrawCircle (int (+ w/2 mx)) (int (+ h/2 my)) 10.0 red)
	(DrawCircle (int (+ w/2 sx)) (int (+ h/2 sy)) 5.0 red)
;	(error "stop" "stop" "stop")
	)))
  self)

(define-method clock-10
  (handle-bounce self)
  (with-slots (self (width height n state))
    (do ((i 0 (+ i 1)))
	((= i n) self)
      (let ((ofst (* i 4)))
	(let-from-vector ((x y vx vy) state ofst)
	  (cond ((< x 0)
		 (v! state (+ ofst 0) 0)
		 (v! state (+ ofst 2) (- vx)))
		((>= x width)
		 (v! state (+ ofst 0) (- width 1))
		 (v! state (+ ofst 2) (- vx))))
	  (cond ((< y 0)
		 (v! state (+ ofst 1) 0)
		 (v! state (+ ofst 3) (- vy)))
		((>= y height)
		 (v! state (+ ofst 1) (- height 1))
		 (v! state (+ ofst 3) (- vy)))))))))

(define (age-to-color color-object age time-consant)
  (let* ((n (int (* 255 (/ age time-consant))))
	 (n (if (> n 255) 255 n)))
    (ftype-set! Color (r) color-object n)
    (ftype-set! Color (g) color-object n)
    (ftype-set! Color (b) color-object n)
    color-object))

(define color-buffer (fptr-init Color (a 255)))
(define-method clock-10
  (draw-lines self t dt)
  (with-slots (self (n
		     state
		     previous-state
		     point-age
		     color-time-constant
		     canvas))
    (BeginTextureMode canvas)   
    (do ((i 0 (+ i 1)))
	((= i n))
      (let ((ofst (* i 4))
	    (age (+ dt (v: point-age i))))
	(v! point-age i age)
	(let-from-vector ((xp yp) previous-state ofst)
	  (let-from-vector ((xc yc) state ofst)
	    (let ((c (age-to-color color-buffer age color-time-constant)))
	      ;; (display point-age) (newline)
	      ;; (display (ftype-ref Color (r) c)) (newline)
	      ;; (display (ftype-ref Color (g) c)) (newline)
	      ;; (display (ftype-ref Color (b) c)) (newline)
	      (DrawLine (int xp) (int yp)
			(int xc) (int yc)
			color-buffer))))))
    (EndTextureMode)
    self))

(define-method clock-10
  (draw-points self t dt)
  (with-slots (self (n state point-color))
    (do ((i 0 (+ i 1)))
	((= i n) self)
      (let-from-vector ((x y) state (* i 4))
	(DrawCircle (int x) (int y)
		    3.0
		    point-color)))))

(define-method clock-10
  (init-points self initer)
  (with-slots (self (n state previous-state))
    (do ((i 0 (+ i 1)))
	((= i n) self)
      (let ((ofst (* i 4)))
	(let-from-vector ((x y xv yv) (initer i))
	  (v!-from state ofst x y xv yv)
	  (v!-from previous-state ofst x y xv yv))))))

(define-method clock-10
  (nearest-point-to self x y)
  (with-slots (self (n state))
    (let ((smallest 0)
	  (smallest-distance +inf.0))
      (do ((i 0 (+ i 1)))
	  ((= i n) smallest)
	(let-from-vector ((px py) state (* i 4))
	  (let* ((dx (- x px))
		 (dy (- y py))
		 (d^2 (+ (* dx dx) (* dy dy))))
	    (when (< d^2 smallest-distance)
	      (set! smallest i)
	      (set! smallest-distance d^2))))))))

(define-method clock-10
  (nearest-point-to-second-hand self)
  (with-slots (self (width height))
    (let-from-vector (($a $b $c $d sx sy) (invoke self 'hand-positions))
      (invoke self 'nearest-point-to
	      (+ (/ width 2.0) sx)
	      (+ (/ height 2.0) sy)))))

(define-method clock-10
  (minute-hand-position self)
  (let-from-vector (($a $b mx my $c $d) (invoke self 'hand-positions))
    (list mx my)))

(define-method clock-10
  (hour-hand-position self)
  (let-from-vector ((hx hy $a $b $c $d) (invoke self 'hand-positions))
    (list hx hy)))

(define-method clock-10
  (get-teleport-position self)
  (with-slots (self (hand-toggle))
    (cond ((eq? hand-toggle 'minute)
	   (slot-set! self 'hand-toggle 'hour)
	   (invoke self 'minute-hand-position))
	  ((eq? hand-toggle 'hour)
	   (slot-set! self 'hand-toggle 'minute)
	   (invoke self 'hour-hand-position)))))

(define-method clock-10
  (handle-teleport self t dt)
  (with-slots (self (n
		     state
		     previous-state
		     width
		     height
		     last-teleport
		     teleport-frequency
		     point-age))
    (let ((last-teleport (+ dt last-teleport)))
      (when (> last-teleport teleport-frequency)
	(let* ((i (invoke self 'nearest-point-to-second-hand))
	       (ofst (* 4 i))
	       (new-pos (invoke self 'get-teleport-position))
	       (nx (+ (/ width 2) (car new-pos)))
	       (ny (+ (/ height 2) (cadr new-pos))))
	  ;(display (format "new pos ~a ~a\n" nx ny))
	  (v!-from state ofst nx ny)
	  (v!-from previous-state ofst nx ny)
	  (v! point-age i 0.0)
	  (set! last-teleport 0.0)
	  ;;(error "stop" "stop" "stop")
	  ))
      (slot-set! self 'last-teleport last-teleport)
      self)))

(define-method clock-10
  (cleanup self t dt)
  (invoke self 'draw-lines t dt)
  (BeginDrawing)
  (ClearBackground white)
  (draw-render-texture (slot-ref self 'canvas) 0 0)
  ;;(invoke self 'draw-points t dt)
  ;; (invoke self 'draw-clock-hands)
  (EndDrawing)
  (with-slots (self (width height))
    (let ((null-size (size-of-black-image width height)))
      (let loop ((i 0))
	(delete-file "out.png")
	(TakeScreenshot "out.png")
	(shell-command-to-lines "convert out.png out.png")
	(cond ((= (get-file-size-bytes "out.png")
		  null-size)
	       (display (format "(~d) Failed to write good screenshot (~d, ~d).\n" i (get-file-size-bytes "out.png")
				null-size))
	       (loop (+ i 1)))
	      (else
	       (display (format "(~d) Apparently succeeded in writing good screenshot (~d, ~d).\n" i (get-file-size-bytes "out.png")
				null-size))
	       self)))))
  (CloseWindow))

(define-method clock-10
  (draw self t dt)
  (invoke self 'draw-lines t dt)
  (BeginDrawing)
  (ClearBackground white)
  (draw-render-texture (slot-ref self 'canvas) 0 0)
  (invoke self 'draw-points t dt)
  (invoke self 'draw-clock-hands)
  (EndDrawing)
  self)

(define-method clock-10
  (create-window self)
  ((get-method (record-type-parent (record-rtd self)) 'create-window #f)
   self)
  (LoadRenderTexture (slot-ref self 'canvas)
		     (slot-ref self 'width)
		     (slot-ref self 'height))
  self)


(define p (make-clock-10 'teleport-frequency 1.0
			 'n 100
			 'alpha 0.01
			 'charge 1000
			 'g 0
			 'color-time-constant 60.0
			 'width (* 11 180)
			 'height (* (+ 8 (/ 1 2)) 180)))
(object-chain p
	      (init-points (lambda (i)
			     (vector (normal (/ (slot-ref p 'width) 2)
					     100.0)
				     (normal (/ (slot-ref p 'height) 2)
					     100.0)
				     0.0
				     0.0)))
	      (create-window)
	      (run))
(exit)
