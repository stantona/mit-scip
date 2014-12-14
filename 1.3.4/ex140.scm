;; Exercise 1.40
;; Find the roots (zeros) of the cubic formula
;; x^3 + ax^2 + bx + c
;; 0 = x^3 + ax^2 + bx + c
(load "deriv.scm")
(load "../helpers.scm")

(define (cubic a b c)
  (lambda (x)
    (+ (cube x) 
       (* a (sqr x)) 
       (* b x) c)))

(define (find-zeroes-cube a b c)
  (newtons-method (cubic a b c) 1))
