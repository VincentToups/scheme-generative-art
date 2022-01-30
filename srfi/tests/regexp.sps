;; DO NOT EDIT THIS FILE!!
;; This inlined chez-srfi library code is autogenerated using command:
;; $ ./install.chezscheme.sps ../backyard0/srfi-lib
;; Source origin: https://github.com/arcfide/chez-srfi
;; Please refer to project site for full credits and original code.
;;;;;; File header: ./tests/regexp.sps
#!r6rs
(import
  (rename
    (rnrs)
    (get-line read-line)
    (call-with-string-output-port call-with-output-string))
  (srfi :78 lightweight-testing)
  (srfi :115 regexp))
(define (test-begin name) #f)
(define-syntax test
  (lambda (x)
    (syntax-case x ()
      [(_ x y)
       #'(guard (exn
                  [else
                   (display "Failed with exception: ")
                   (write 'x)
                   (newline)
                   (write
                     (list
                       (and (message-condition? exn)
                            (condition-message exn))
                       (and (irritants-condition? exn)
                            (condition-irritants exn))))
                   (newline)])
           (check x => y))])))
(define (test-end) #f)
(define (run-tests)
  (define (maybe-match->sexp rx str . o)
    (let ([res (apply regexp-matches rx str o)])
      (and res (regexp-match->sexp res))))
  (define-syntax test-re
    (syntax-rules ()
      [(test-re res rx str start end)
       (test res (maybe-match->sexp rx str start end))]
      [(test-re res rx str start)
       (test-re res rx str start (string-length str))]
      [(test-re res rx str) (test-re res rx str 0)]))
  (define (maybe-search->sexp rx str . o)
    (let ([res (apply regexp-search rx str o)])
      (and res (regexp-match->sexp res))))
  (define-syntax test-re-search
    (syntax-rules ()
      [(test-re-search res rx str start end)
       (test res (maybe-search->sexp rx str start end))]
      [(test-re-search res rx str start)
       (test-re-search res rx str start (string-length str))]
      [(test-re-search res rx str)
       (test-re-search res rx str 0)]))
  (test-begin "regexp")
  (test-re '("ababc" "abab") '(: ($ (* "ab")) "c") "ababc")
  (test-re '("ababc" "abab") '(: ($ (* "ab")) "c") "xababc" 1)
  (test-re-search '("y") '(: "y") "xy")
  (test-re-search
    '("ababc" "abab")
    '(: ($ (* "ab")) "c")
    "xababc")
  (test-re
    #f
    '(: (* any) ($ "foo" (* any)) ($ "bar" (* any)))
    "fooxbafba")
  (test-re
    '("fooxbarfbar" "fooxbarf" "bar")
    '(: (* any) ($ "foo" (* any)) ($ "bar" (* any)))
    "fooxbarfbar")
  (test-re '("abcd" "abcd") '($ (* (or "ab" "cd"))) "abcd")
  (test-re
    '("abcdc" (("ab") ("cd")) "cd")
    '(: (* (*$ (or "ab" "cd"))) "c")
    "abcdc")
  (test
    "ab"
    (regexp-match-submatch
      (regexp-matches '(or (-> foo "ab") (-> foo "cd")) "ab")
      'foo))
  (test
    "cd"
    (regexp-match-submatch
      (regexp-matches '(or (-> foo "ab") (-> foo "cd")) "cd")
      'foo))
  (let* ([elapsed '(: (** 1 2 num) ":" num num
                      (? ":" num num))]
         [span (rx ,elapsed "-" ,elapsed)])
    (test-re-search
      '("1:45:02-2:06:13")
      span
      " 1:45:02-2:06:13 "))
  (test-re
    '("ababc" "abab")
    '(: bos ($ (* "ab")) "c")
    "ababc")
  (test-re
    '("ababc" "abab")
    '(: ($ (* "ab")) "c" eos)
    "ababc")
  (test-re
    '("ababc" "abab")
    '(: bos ($ (* "ab")) "c" eos)
    "ababc")
  (test-re #f '(: bos ($ (* "ab")) eos "c") "ababc")
  (test-re #f '(: ($ (* "ab")) bos "c" eos) "ababc")
  (test-re
    '("ababc" "abab")
    '(: bol ($ (* "ab")) "c")
    "ababc")
  (test-re
    '("ababc" "abab")
    '(: ($ (* "ab")) "c" eol)
    "ababc")
  (test-re
    '("ababc" "abab")
    '(: bol ($ (* "ab")) "c" eol)
    "ababc")
  (test-re #f '(: bol ($ (* "ab")) eol "c") "ababc")
  (test-re #f '(: ($ (* "ab")) bol "c" eol) "ababc")
  (test-re
    '("\nabc\n" "abc")
    '(: (* #\newline) bol ($ (* alpha)) eol (* #\newline))
    "\nabc\n")
  (test-re
    #f
    '(: (* #\newline) bol ($ (* alpha)) eol (* #\newline))
    "\n'abc\n")
  (test-re
    #f
    '(: (* #\newline) bol ($ (* alpha)) eol (* #\newline))
    "\nabc.\n")
  (test-re
    '("ababc" "abab")
    '(: bow ($ (* "ab")) "c")
    "ababc")
  (test-re
    '("ababc" "abab")
    '(: ($ (* "ab")) "c" eow)
    "ababc")
  (test-re
    '("ababc" "abab")
    '(: bow ($ (* "ab")) "c" eow)
    "ababc")
  (test-re #f '(: bow ($ (* "ab")) eow "c") "ababc")
  (test-re #f '(: ($ (* "ab")) bow "c" eow) "ababc")
  (test-re
    '("  abc  " "abc")
    '(: (* space) bow ($ (* alpha)) eow (* space))
    "  abc  ")
  (test-re
    #f
    '(: (* space) bow ($ (* alpha)) eow (* space))
    " 'abc  ")
  (test-re
    #f
    '(: (* space) bow ($ (* alpha)) eow (* space))
    " abc.  ")
  (test-re
    '("abc  " "abc")
    '(: ($ (* alpha)) (* any))
    "abc  ")
  (test-re '("abc  " "") '(: ($ (*? alpha)) (* any)) "abc  ")
  (test-re
    '("<em>Hello World</em>" "em>Hello World</em")
    '(: "<" ($ (* any)) ">" (* any))
    "<em>Hello World</em>")
  (test-re
    '("<em>Hello World</em>" "em")
    '(: "<" ($ (*? any)) ">" (* any))
    "<em>Hello World</em>")
  (test-re-search '("foo") '(: "foo") " foo ")
  (test-re-search #f '(: nwb "foo" nwb) " foo ")
  (test-re-search '("foo") '(: nwb "foo" nwb) "xfoox")
  (test-re '("beef") '(* (/ "af")) "beef")
  (test-re
    '("12345beef" "beef")
    '(: (* digit) ($ (* (/ "af"))))
    "12345beef")
  (let ([number '($ (+ digit))])
    (test
      '("555" "867" "5309")
      (cdr (regexp-match->list
             (regexp-search
               `(: ,number "-" ,number "-" ,number)
               "555-867-5309"))))
    (test
      '("555" "5309")
      (cdr (regexp-match->list
             (regexp-search
               `(: ,number "-" (w/nocapture ,number) "-" ,number)
               "555-867-5309")))))
  (test-re
    '("12345BeeF" "BeeF")
    '(: (* digit) (w/nocase ($ (* (/ "af")))))
    "12345BeeF")
  (test-re #f '(* lower) "abcD")
  (test-re '("abcD") '(w/nocase (* lower)) "abcD")
  (test-re '("σζ") '(* lower) "σζ")
  (test-re '("Σ") '(* upper) "Σ")
  (test-re '("ǅ") '(* title) "ǅ")
  (test-re '("σζǅ") '(w/nocase (* lower)) "σζǅ")
  (test-re '("кириллица") '(* alpha) "кириллица")
  (test-re #f '(w/ascii (* alpha)) "кириллица")
  (test-re '("кириллица") '(w/nocase "КИРИЛЛИЦА") "кириллица")
  (test-re '("１２３４５") '(* digit) "１２３４５")
  (test-re #f '(w/ascii (* digit)) "１２３４５")
  (test-re '("한") 'grapheme "한")
  (test-re '("글") 'grapheme "글")
  (test-re '("한") '(: bog grapheme eog) "한")
  (test-re #f '(: "ᄒ" bog grapheme eog "ᆫ") "한")
  (test
    '("123" "456" "789")
    (regexp-extract '(+ digit) "abc123def456ghi789"))
  (test
    '("123" "456" "789")
    (regexp-extract '(* digit) "abc123def456ghi789"))
  (test
    '("abc" "def" "ghi" "")
    (regexp-split '(+ digit) "abc123def456ghi789"))
  (test
    '("abc" "def" "ghi" "")
    (regexp-split '(* digit) "abc123def456ghi789"))
  (test '("a" "b") (regexp-split '(+ whitespace) "a b"))
  (test '("a" "" "b") (regexp-split '(",;") "a,,b"))
  (test '("a" "" "b" "") (regexp-split '(",;") "a,,b,"))
  (test '("") (regexp-partition '(* digit) ""))
  (test
    '("abc" "123" "def" "456" "ghi")
    (regexp-partition '(* digit) "abc123def456ghi"))
  (test
    '("abc" "123" "def" "456" "ghi" "789")
    (regexp-partition '(* digit) "abc123def456ghi789"))
  (test
    '("한" "글")
    (regexp-extract
      'grapheme
      (utf8->string
        '#vu8(225 132 146 225 133 161 225 134 171 225 132 128 225
              133 179 225 134 175))))
  (test
    "abc def"
    (regexp-replace '(+ space) "abc \t\n def" " "))
  (test
    "  abc-abc"
    (regexp-replace
      '(: ($ (+ alpha)) ":" (* space))
      "  abc: "
      '(1 "-" 1)))
  (test
    "  abc-  abc"
    (regexp-replace
      '(: ($ (+ alpha)) ":" (* space))
      "  abc: "
      '(1 "-" pre 1)))
  (test
    "-abc \t\n d ef  "
    (regexp-replace '(+ space) "  abc \t\n d ef  " "-" 0))
  (test
    "-abc \t\n d ef  "
    (regexp-replace '(+ space) "  abc \t\n d ef  " "-" 0 #f 0))
  (test
    "  abc-d ef  "
    (regexp-replace '(+ space) "  abc \t\n d ef  " "-" 0 #f 1))
  (test
    "  abc \t\n d-ef  "
    (regexp-replace '(+ space) "  abc \t\n d ef  " "-" 0 #f 2))
  (test
    "  abc \t\n d ef-"
    (regexp-replace '(+ space) "  abc \t\n d ef  " "-" 0 #f 3))
  (test
    "  abc \t\n d ef  "
    (regexp-replace '(+ space) "  abc \t\n d ef  " "-" 0 #f 4))
  (test
    " abc d ef "
    (regexp-replace-all '(+ space) "  abc \t\n d ef  " " "))
  (test-end))
(run-tests)
