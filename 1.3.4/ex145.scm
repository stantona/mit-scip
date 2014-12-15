(load "../helpers.scm")

(load "../1.3.3/fixed-point.scm")

;; Contains the repeated function
(load "ex143.scm")

;; The fixed point function is f(x) = x
;; y = sqrt(x)
;; y^2 = x
;; y = x/y
;; Fixed point functions work by making an initial guess and converging to a solution.

(define (average-damp f)
  (lambda(y)
    (average y (f y))))

(define (root-n x n)
  (define (root y)
    (/ x (expt y (1- n))))

  (define (repeat-average-damp)
    ((repeated average-damp n) root))

  (fixed-point (repeat-average-damp) 1.0))
