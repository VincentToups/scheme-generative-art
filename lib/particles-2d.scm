(library (lib particles-2d)
  (export particles-2d make-particles-2d particles-2d-state particles-2d-n particles-2d-particle-state)
  (import (chezscheme)
	  (lib vector-shorthand))
  (begin
    (define (vector-for-each-with-index f . rest)
      (let ((i 0))
	(apply vector-for-each
	       (cons
		(lambda args
		  (apply f (cons i args))
		  (set! i (+ i 1)))
		rest))))

    (define (dump-csv2 list-of-vectors)
      (with-output-to-file "sim.csv"
	(lambda ()
	  (display (format "X1, X2\n"))
	  (let loop ((rows list-of-vectors))
	    (cond
	     ((eq? rows '()) #t)
	     (else
	      (let ((row (car rows))
		    (rest (cdr rows)))
		(display (format "~f, ~f\n" (v: row 0) (v: row 1)))
		(loop rest))))))))

    (define (particles-2d-protocol constructor)
      (lambda (n init)
	(let ((state-vector (make-vector (* 4 n) 0.0))
	      (md-vector (make-vector n #f)))
	  (let loop ((i 0))
	    (cond ((= i n) #t)
		  (else
		   (let* ((offset (* i 4))
			  (vals (init i))
			  (state (car vals))
			  (md (cadr vals)))
		     (assert (= 4 (vector-length state)))
		     (vector-set! md-vector i md)
		     (vector-for-each-with-index
		      (lambda (j e)
			(vector-set! state-vector (+ offset j) e))
		      (init i)))
		   (loop (+ i 1)))))
	  (constructor n state-vector md-vector))))

    (define-record-type particles-2d
      (fields n (mutable state) meta-data)
      (protocol particles-2d-protocol))

    (define (particles-2d-particle-state p2d i)
      (let ((out (make-vector 4))
	    (offset (* i 4))
	    (state (particles-2d-state p2d)))
	(let loop ((j 0))
	  (cond ((= j 4))
		(else
		 (vector-set! out j (vector-ref state (+ offset j)))
		 (loop (+ j 1)))))
	out))

    (define (len2d-squared x y)
      (+ (* x x) (* y y)))

    (define (simple-loop f below)
      (define void (if #f #t))
      (let loop ((i 0))
	(cond ((= i below) void)
	      (else
	       (f i)
	       (loop (+ i 1))))))
    
    (define (make-coloumb-force n-particles cc)
      (let ((out (make-vector (* 4 n-particles) 0.0)))
	(lambda (state t)
	  (simple-loop
	   (lambda (i)
	     (let* ((io (* i 4))
		    (x (vector-ref state io))
		    (y (vector-ref state (+ io 1))))
	       (vector-set! out io (vector-ref state (+ io 2)))
	       (vector-set! out (+ io 1) (vector-ref state (+ io 3)))
	       (vector-set! out (+ io 2) 0.0)
	       (vector-set! out (+ io 3) 0.0)
	       (simple-loop
		(lambda (j)
		  (let* ((jo (* j 4))
			 (other-x (vector-ref state jo))
			 (other-y (vector-ref state (+ jo 1)))
			 (dx (- x other-x))
			 (dy (- y other-y))
			 (l2 (len2d-squared dx dy))
			 (l (sqrt l2))
			 (nx (* cc (/ dx (* l2 l))))
			 (ny (* cc (/ dy (* l2 l)))))
		    (vector-set! out (+ io 2) (+ nx (vector-ref out (+ io 2))))
		    (vector-set! out (+ io 3) (+ ny (vector-ref out (+ io 3))))))
		n-particles)))
	   n-particles)
	  out)))))
