;; Contains the continued fraction procedure
(load "ex137.scm")

;; This calculates the value at the position of the
;; sequence.
(define (euler-seq n)
  (define (multiple? n divisor)
    (= (remainder n divisor) 0))

  (let ((index-shift (+ n 1)))
    (if (multiple? index-shift 3)
        (- index-shift (/ index-shift 3))
        1)))

(define (assert-equal actual expected)
  (print "\nVerifying actual result: " actual " is equal to expected result: " expected ".\n")
  (if (= actual expected)
      (print "\tTest passes: " actual " (actual) is equal to " expected " (expected).\n")
      (print "\tTest fails: " actual " (actual) is not equal to " expected " (expected).\n")))

(define (run-tests)
  (assert-equal (euler-seq 0) 1)
  (assert-equal (euler-seq 1) 2) ;; 3
  (assert-equal (euler-seq 2) 1)
  (assert-equal (euler-seq 3) 1)
  (assert-equal (euler-seq 4) 4) ;; 6
  (assert-equal (euler-seq 5) 1)
  (assert-equal (euler-seq 6) 1)
  (assert-equal (euler-seq 7) 6) ;; 9
  (assert-equal (euler-seq 8) 1)
  (assert-equal (euler-seq 9) 1)
  (assert-equal (euler-seq 10) 8) ;; 12
  (assert-equal (euler-seq 11) 1)
  (assert-equal (euler-seq 12) 1)
  (assert-equal (euler-seq 13) 10)) ;; 15


(cont-frac-iter (lambda (i) 1)
                euler-seq
                20)

(define (natural-logorithm)
  (+ 2 
     (cont-frac-iter (lambda (i) 1)
                     euler-seq
                     15)))
