;; DO NOT EDIT THIS FILE!!
;; This inlined chez-srfi library code is autogenerated using command:
;; $ ./install.chezscheme.sps ../backyard0/srfi-lib
;; Source origin: https://github.com/arcfide/chez-srfi
;; Please refer to project site for full credits and original code.
;;;;;; File header: ./tests/testing.sps
#!r6rs
;; Copyright 2010 Derick Eddington.  My MIT-style license is in the file named
;; LICENSE from the original collection this file is distributed with.
;;;;;; File header: %3a64/srfi-64-test.scm
;;;
;;;  This is a test suite written in the notation of 
;;;  SRFI-64, A Scheme API for test suites
;;;
(import (except (rnrs base) error) (rnrs lists)
  (srfi :23 error) (srfi private include) (srfi :64 testing))
(begin
  (test-begin "SRFI 64 - Meta-Test Suite")
  (define (prop-runner props thunk)
    (let ([r (test-runner-null)] [plist '()])
      (test-runner-on-test-end!
        r
        (lambda (runner) (set! plist (test-result-alist runner))))
      (test-with-runner r (thunk))
      (map (lambda (k) (assq k plist)) props)))
  (define (on-test-runner thunk visit)
    (let ([r (test-runner-null)] [results '()])
      (test-runner-on-test-end!
        r
        (lambda (runner) (set! results (cons (visit r) results))))
      (test-with-runner r (thunk))
      (reverse results)))
  (define (triv-runner thunk)
    (let ([r (test-runner-null)]
          [accum-pass '()]
          [accum-fail '()]
          [accum-xfail '()]
          [accum-xpass '()]
          [accum-skip '()])
      (test-runner-on-bad-count!
        r
        (lambda (runner count expected-count)
          (error (string-append
                   "bad count "
                   (number->string count)
                   " but expected "
                   (number->string expected-count)))))
      (test-runner-on-bad-end-name!
        r
        (lambda (runner begin end)
          (error (string-append
                   "bad end grojup name "
                   end
                   " but expected "
                   begin))))
      (test-runner-on-test-end!
        r
        (lambda (runner)
          (let ([n (test-runner-test-name runner)])
            (case (test-result-kind runner)
              [(pass) (set! accum-pass (cons n accum-pass))]
              [(fail) (set! accum-fail (cons n accum-fail))]
              [(xpass) (set! accum-xpass (cons n accum-xpass))]
              [(xfail) (set! accum-xfail (cons n accum-xfail))]
              [(skip) (set! accum-skip (cons n accum-skip))]))))
      (test-with-runner r (thunk))
      (list (reverse accum-pass) (reverse accum-fail)
        (reverse accum-xfail) (reverse accum-xpass)
        (reverse accum-skip)
        (list (test-runner-pass-count r) (test-runner-fail-count r)
          (test-runner-xfail-count r) (test-runner-xpass-count r)
          (test-runner-skip-count r)))))
  (define (path-revealing-runner thunk)
    (let ([r (test-runner-null)] [seq '()])
      (test-runner-on-test-end!
        r
        (lambda (runner)
          (set! seq
            (cons
              (list
                (test-runner-group-path runner)
                (test-runner-test-name runner))
              seq))))
      (test-with-runner r (thunk))
      (reverse seq)))
  (test-begin "1. Simple test-cases")
  (test-begin "1.1. test-assert")
  (define (t)
    (triv-runner
      (lambda () (test-assert "a" #t) (test-assert "b" #f))))
  (test-equal
    "1.1.1. Very simple"
    '(("a") ("b") () () () (1 1 0 0 0))
    (t))
  (test-equal
    "1.1.2. A test with no name"
    '(("a") ("") () () () (1 1 0 0 0))
    (triv-runner
      (lambda () (test-assert "a" #t) (test-assert #f))))
  (test-equal
    "1.1.3. Tests can have the same name"
    '(("a" "a") () () () () (2 0 0 0 0))
    (triv-runner
      (lambda () (test-assert "a" #t) (test-assert "a" #t))))
  (define (choke) (vector-ref '#(1 2) 3))
  (test-equal
    "1.1.4. One way to FAIL is to throw an error"
    '(() ("a") () () () (0 1 0 0 0))
    (triv-runner (lambda () (test-assert "a" (choke)))))
  (test-end)
  (test-begin "1.2. test-eqv")
  (define (mean x y) (/ (+ x y) 2.0))
  (test-equal
    "1.2.1.  Simple numerical equivalence"
    '(("c") ("a" "b") () () () (1 2 0 0 0))
    (triv-runner
      (lambda ()
        (test-eqv "a" (mean 3 5) 4)
        (test-eqv "b" (mean 3 5) 4.5)
        (test-eqv "c" (mean 3 5) 4.0))))
  (test-end)
  (test-end "1. Simple test-cases")
  (test-begin "2. Tests for catching errors")
  (test-begin "2.1. test-error")
  (test-equal
    "2.1.1. Baseline test; PASS with no optional args"
    '(("") () () () () (1 0 0 0 0))
    (triv-runner
      (lambda () (test-error (vector-ref '#(1 2) 9)))))
  (test-equal
    "2.1.2. Baseline test; FAIL with no optional args"
    '(() ("") () () () (0 1 0 0 0))
    (triv-runner
      (lambda () (test-error (vector-ref '#(1 2) 0)))))
  (test-equal
    "2.1.3. PASS with a test name and error type"
    '(("a") () () () () (1 0 0 0 0))
    (triv-runner
      (lambda () (test-error "a" #t (vector-ref '#(1 2) 9)))))
  (test-end "2.1. test-error")
  (test-end "2. Tests for catching errors")
  (test-begin "3. Test groups and paths")
  (test-equal
    "3.1. test-begin with unspecific test-end"
    '(("b") () () () () (1 0 0 0 0))
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-assert "b" #t)
        (test-end))))
  (test-equal
    "3.2. test-begin with name-matching test-end"
    '(("b") () () () () (1 0 0 0 0))
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-assert "b" #t)
        (test-end "a"))))
  (test-error
    "3.3. test-begin with mismatched test-end"
    #t
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-assert "b" #t)
        (test-end "x"))))
  (test-equal
    "3.4. test-begin with name and count"
    '(("b" "c") () () () () (2 0 0 0 0))
    (triv-runner
      (lambda ()
        (test-begin "a" 2)
        (test-assert "b" #t)
        (test-assert "c" #t)
        (test-end "a"))))
  (test-error
    "3.5. test-begin with mismatched count"
    #t
    (triv-runner
      (lambda ()
        (test-begin "a" 99)
        (test-assert "b" #t)
        (test-end "a"))))
  (test-equal
    "3.6. introspecting on the group path"
    '((() "w") (("a" "b") "x") (("a" "b") "y") (("a") "z"))
    (path-revealing-runner
      (lambda ()
        (test-assert "w" #t)
        (test-begin "a")
        (test-begin "b")
        (test-assert "x" #t)
        (test-assert "y" #t)
        (test-end)
        (test-assert "z" #t))))
  (test-end "3. Test groups and paths")
  (test-begin "4. Handling set-up and cleanup")
  (test-equal
    "4.1. Normal exit path"
    '(in 1 2 out)
    (let ([ex '()])
      (define (do s) (set! ex (cons s ex)))
      (triv-runner
        (lambda ()
          (test-group-with-cleanup "foo" (do (quote in)) (do 1) (do 2)
            (do (quote out)))))
      (reverse ex)))
  (test-equal
    "4.2. Exception exit path"
    '(in 1 out)
    (let ([ex '()])
      (define (do s) (set! ex (cons s ex)))
      (triv-runner
        (lambda ()
          (test-error
            (triv-runner
              (lambda ()
                (test-group-with-cleanup "foo" (do (quote in)) (test-assert #t) (do 1)
                  (test-assert #t) (choke) (test-assert #t) (do 2)
                  (test-assert #t) (do (quote out))))))))
      (reverse ex)))
  (test-end "4. Handling set-up and cleanup")
  (test-begin "5. Test specifiers")
  (test-begin "5.1. test-match-named")
  (test-equal
    "5.1.1. match test names"
    '(("y") () () () ("x") (1 0 0 0 1))
    (triv-runner
      (lambda ()
        (test-skip (test-match-name "x"))
        (test-assert "x" #t)
        (test-assert "y" #t))))
  (test-equal
    "5.1.2. but not group names"
    '(("z") () () () () (1 0 0 0 0))
    (triv-runner
      (lambda ()
        (test-skip (test-match-name "x"))
        (test-begin "x")
        (test-assert "z" #t)
        (test-end))))
  (test-end)
  (test-begin "5.2. test-match-nth")
  (test-equal
    "5.2.1. skip the nth one after"
    '(("v" "w" "y" "z") () () () ("x") (4 0 0 0 1))
    (triv-runner
      (lambda ()
        (test-assert "v" #t)
        (test-skip (test-match-nth 2))
        (test-assert "w" #t)
        (test-assert "x" #t)
        (test-assert "y" #t)
        (test-assert "z" #t))))
  (test-equal
    "5.2.2. skip m, starting at n"
    '(("v" "w" "z") () () () ("x" "y") (3 0 0 0 2))
    (triv-runner
      (lambda ()
        (test-assert "v" #t)
        (test-skip (test-match-nth 2 2))
        (test-assert "w" #t)
        (test-assert "x" #t)
        (test-assert "y" #t)
        (test-assert "z" #t))))
  (test-end)
  (test-begin "5.3. test-match-any")
  (test-equal
    "5.3.1. basic disjunction"
    '(("v" "w" "z") () () () ("x" "y") (3 0 0 0 2))
    (triv-runner
      (lambda ()
        (test-assert "v" #t)
        (test-skip
          (test-match-any (test-match-nth 3) (test-match-name "x")))
        (test-assert "w" #t)
        (test-assert "x" #t)
        (test-assert "y" #t)
        (test-assert "z" #t))))
  (test-equal
    "5.3.2. disjunction is commutative"
    '(("v" "w" "z") () () () ("x" "y") (3 0 0 0 2))
    (triv-runner
      (lambda ()
        (test-assert "v" #t)
        (test-skip
          (test-match-any (test-match-name "x") (test-match-nth 3)))
        (test-assert "w" #t)
        (test-assert "x" #t)
        (test-assert "y" #t)
        (test-assert "z" #t))))
  (test-end)
  (test-begin "5.4. test-match-all")
  (test-equal
    "5.4.1. basic conjunction"
    '(("v" "w" "y" "z") () () () ("x") (4 0 0 0 1))
    (triv-runner
      (lambda ()
        (test-assert "v" #t)
        (test-skip
          (test-match-all (test-match-nth 2 2) (test-match-name "x")))
        (test-assert "w" #t)
        (test-assert "x" #t)
        (test-assert "y" #t)
        (test-assert "z" #t))))
  (test-equal
    "5.4.2. conjunction is commutative"
    '(("v" "w" "y" "z") () () () ("x") (4 0 0 0 1))
    (triv-runner
      (lambda ()
        (test-assert "v" #t)
        (test-skip
          (test-match-all (test-match-name "x") (test-match-nth 2 2)))
        (test-assert "w" #t)
        (test-assert "x" #t)
        (test-assert "y" #t)
        (test-assert "z" #t))))
  (test-end)
  (test-end "5. Test specifiers")
  (test-begin "6. Skipping selected tests")
  (test-equal
    "6.1. Skip by specifier - match-name"
    '(("x") () () () ("y") (1 0 0 0 1))
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-skip (test-match-name "y"))
        (test-assert "x" #t)
        (test-assert "y" #f)
        (test-end))))
  (test-equal
    "6.2. Shorthand specifiers"
    '(("x") () () () ("y") (1 0 0 0 1))
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-skip "y")
        (test-assert "x" #t)
        (test-assert "y" #f)
        (test-end))))
  (test-begin "6.3. Specifier Stack")
  (test-equal
    "6.3.1. Clearing the Specifier Stack"
    '(("x" "x") ("y") () () ("y") (2 1 0 0 1))
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-skip "y")
        (test-assert "x" #t)
        (test-assert "y" #f)
        (test-end)
        (test-begin "b")
        (test-assert "x" #t)
        (test-assert "y" #f)
        (test-end))))
  (test-equal
    "6.3.2. Inheriting the Specifier Stack"
    '(("x" "x") () () () ("y" "y") (2 0 0 0 2))
    (triv-runner
      (lambda ()
        (test-skip "y")
        (test-begin "a")
        (test-assert "x" #t)
        (test-assert "y" #f)
        (test-end)
        (test-begin "b")
        (test-assert "x" #t)
        (test-assert "y" #f)
        (test-end))))
  (test-end)
  (test-begin "6.4. Short-circuit evaluation")
  (test-equal
    "6.4.1. In test-match-all"
    '(("x") ("y" "x" "z") () () ("y") (1 3 0 0 1))
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-skip (test-match-all "y" (test-match-nth 2)))
        (test-assert "x" #t)
        (test-assert "y" #f)
        (test-assert "y" #f)
        (test-assert "x" #f)
        (test-assert "z" #f)
        (test-end))))
  (test-equal
    "6.4.2. In separate skip-list entries"
    '(("x") ("x" "z") () () ("y" "y") (1 2 0 0 2))
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-skip "y")
        (test-skip (test-match-nth 2))
        (test-assert "x" #t)
        (test-assert "y" #f)
        (test-assert "y" #f)
        (test-assert "x" #f)
        (test-assert "z" #f)
        (test-end))))
  (test-begin "6.4.3. Skipping test suites")
  (test-equal
    "6.4.3.1. Introduced using 'test-begin'"
    '(("x") () () () () (1 0 0 0 0))
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-skip "b")
        (test-begin "b")
        (test-assert "x" #t)
        (test-end "b")
        (test-end "a"))))
  (test-expect-fail 1)
  (test-equal
    "6.4.3.2. Introduced using 'test-group'"
    '(() () () () () (0 0 0 0 1))
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-skip "b")
        (test-group "b" (test-assert "x" #t))
        (test-end "a"))))
  (test-equal
    "6.4.3.3. Non-skipped 'test-group'"
    '(("x") () () () () (1 0 0 0 0))
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-skip "c")
        (test-group "b" (test-assert "x" #t))
        (test-end "a"))))
  (test-end)
  (test-end)
  (test-end "6. Skipping selected tests")
  (test-begin "7. Expected failures")
  (test-equal
    "7.1. Simple example"
    '(() ("x") ("z") () () (0 1 1 0 0))
    (triv-runner
      (lambda ()
        (test-assert "x" #f)
        (test-expect-fail "z")
        (test-assert "z" #f))))
  (test-equal
    "7.2. Expected exception"
    '(() ("x") ("z") () () (0 1 1 0 0))
    (triv-runner
      (lambda ()
        (test-assert "x" #f)
        (test-expect-fail "z")
        (test-assert "z" (choke)))))
  (test-equal
    "7.3. Unexpectedly PASS"
    '(() () ("y") ("x") () (0 0 1 1 0))
    (triv-runner
      (lambda ()
        (test-expect-fail "x")
        (test-expect-fail "y")
        (test-assert "x" #t)
        (test-assert "y" #f))))
  (test-end "7. Expected failures")
  (test-begin "8. Test-runner")
  (define (with-factory-saved thunk)
    (let* ([saved (test-runner-factory)] [result (thunk)])
      (test-runner-factory saved)
      result))
  (test-begin "8.1. test-runner-current")
  (test-assert
    "8.1.1. automatically restored"
    (let ([a 0] [b 1] [c 2])
      (triv-runner
        (lambda ()
          (set! a (test-runner-current))
          (triv-runner (lambda () (set! b (test-runner-current))))
          (set! c (test-runner-current))))
      (and (eq? a c) (not (eq? a b)))))
  (test-end)
  (test-begin "8.2. test-runner-simple")
  (test-assert
    "8.2.1. default on-test hook"
    (eq? (test-runner-on-test-end (test-runner-simple))
         test-on-test-end-simple))
  (test-assert
    "8.2.2. default on-final hook"
    (eq? (test-runner-on-final (test-runner-simple))
         test-on-final-simple))
  (test-end)
  (test-begin "8.3. test-runner-factory")
  (test-assert
    "8.3.1. default factory"
    (eq? (test-runner-factory) test-runner-simple))
  (test-assert
    "8.3.2. settable factory"
    (with-factory-saved
      (lambda ()
        (test-runner-factory test-runner-null)
        (test-with-runner
          (test-runner-create)
          (lambda ()
            (test-begin "a")
            (test-assert #t)
            (test-assert #f)
            (test-assert (vector-ref '#(3) 10))
            (test-end "a")))
        (eq? (test-runner-factory) test-runner-null))))
  (test-end)
  (test-begin "8.4. test-runner-create")
  (test-end)
  (test-begin "8.5. test-runner-factory")
  (test-end)
  (test-begin "8.6. test-apply")
  (test-equal
    "8.6.1. Simple (form 1) test-apply"
    '(("w" "p" "v") () () () ("x") (3 0 0 0 1))
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-assert "w" #t)
        (test-apply
          (test-match-name "p")
          (lambda ()
            (test-begin "p")
            (test-assert "x" #t)
            (test-end)
            (test-begin "z")
            (test-assert "p" #t)
            (test-end)))
        (test-assert "v" #t))))
  (test-equal
    "8.6.2. Simple (form 2) test-apply"
    '(("w" "p" "v") () () () ("x") (3 0 0 0 1))
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-assert "w" #t)
        (test-apply
          (test-runner-current)
          (test-match-name "p")
          (lambda ()
            (test-begin "p")
            (test-assert "x" #t)
            (test-end)
            (test-begin "z")
            (test-assert "p" #t)
            (test-end)))
        (test-assert "v" #t))))
  (test-expect-fail 1)
  (test-equal
    "8.6.3. test-apply with skips"
    '(("w" "q" "v") () () () ("x" "p" "x") (3 0 0 0 3))
    (triv-runner
      (lambda ()
        (test-begin "a")
        (test-assert "w" #t)
        (test-skip (test-match-nth 2))
        (test-skip (test-match-nth 4))
        (test-apply
          (test-runner-current)
          (test-match-name "p")
          (test-match-name "q")
          (lambda ()
            (test-assert "x" #t)
            (test-assert "p" #t)
            (test-assert "q" #t)
            (test-assert "x" #f)
            0))
        (test-assert "v" #t))))
  (test-end)
  (test-begin "8.7. test-with-runner")
  (test-end)
  (test-begin "8.8. test-runner components")
  (define (auxtrack-runner thunk)
    (let ([r (test-runner-null)])
      (test-runner-aux-value! r '())
      (test-runner-on-test-end!
        r
        (lambda (r)
          (test-runner-aux-value!
            r
            (cons
              (test-runner-test-name r)
              (test-runner-aux-value r)))))
      (test-with-runner r (thunk))
      (reverse (test-runner-aux-value r))))
  (test-equal
    "8.8.1. test-runner-aux-value"
    '("x" "" "y")
    (auxtrack-runner
      (lambda ()
        (test-assert "x" #t)
        (test-begin "a")
        (test-assert #t)
        (test-end)
        (test-assert "y" #f))))
  (test-end)
  (test-end "8. Test-runner")
  (test-begin "9. Test Result Properties")
  (test-begin "9.1. test-result-alist")
  (define (symbol-alist? l)
    (if (null? l)
        #t
        (and (pair? l)
             (pair? (car l))
             (symbol? (caar l))
             (symbol-alist? (cdr l)))))
  (test-assert
    (symbol-alist?
      (car (on-test-runner
             (lambda () (test-assert #t))
             (lambda (r) (test-result-alist r))))))
  (test-assert
    (symbol-alist?
      (car (on-test-runner
             (lambda () (test-assert #t))
             (lambda (r) (test-result-alist r))))))
  (test-equal
    '((result-kind . pass))
    (prop-runner '(result-kind) (lambda () (test-assert #t))))
  (test-equal
    '((result-kind . fail)
       (expected-value . 2)
       (actual-value . 3))
    (prop-runner
      '(result-kind expected-value actual-value)
      (lambda () (test-equal 2 (+ 1 2)))))
  (test-end "9.1. test-result-alist")
  (test-begin "9.2. test-result-ref")
  (test-equal
    '(pass)
    (on-test-runner
      (lambda () (test-assert #t))
      (lambda (r) (test-result-ref r 'result-kind))))
  (test-equal
    '(pass)
    (on-test-runner
      (lambda () (test-assert #t))
      (lambda (r) (test-result-ref r 'result-kind))))
  (test-equal
    '(fail pass)
    (on-test-runner
      (lambda () (test-assert (= 1 2)) (test-assert (= 1 1)))
      (lambda (r) (test-result-ref r 'result-kind))))
  (test-end "9.2. test-result-ref")
  (test-begin "9.3. test-result-set!")
  (test-equal
    '(100 100)
    (on-test-runner
      (lambda () (test-assert (= 1 2)) (test-assert (= 1 1)))
      (lambda (r)
        (test-result-set! r 'foo 100)
        (test-result-ref r 'foo))))
  (test-end "9.3. test-result-set!")
  (test-end "9. Test Result Properties")
  (test-end "SRFI 64 - Meta-Test Suite"))