;; Exercise 2.11

;; The goal is to test the "9 case" implementation of mul-interval against the original
;; implementation.

(load "interval-arith.scm")

(define (assert predicate desc actual expected)
  (print "\n" desc "\n")
  (print "\nActual/Expected:\n")
  (pretty-print actual)
  (pretty-print expected)
  (if (predicate actual expected)
      (print "\nTest Passes\n")
      (print "\nTest Fails\n")))

(define (test-case x y desc)
  (assert interval-eql? desc (mul-interval-cases x y) (mul-interval x y)))

;; Case 1
(test-case (make-interval -2 -1) (make-interval -5 -4) "All Negative Boundaries")
;; Case 2
(test-case (make-interval 1 2) (make-interval 4 5) "All Positive Boundaries")
;; Case 3
(test-case (make-interval -20 -11) (make-interval -6 32) "Negative x boundaries, Negative lower y, Positive upper y")
;; Case 4
(test-case (make-interval -23 -6) (make-interval 6.32 7.98) "Negative x boundaries, Positive y boundaries")
;; Case 5
(test-case (make-interval 6.32 7.98) (make-interval -23 -6) "Positive x boundaries, Negative y boundaries")
;; Case 7
(test-case (make-interval -21 13) (make-interval 12 13.9) "Negative lower x, Positive upper x and y boundaries")
;; Case 8
(test-case (make-interval -1.98 2.38) (make-interval -2.21 3.21) "Negative lower bounds, Positive upper bounds")
