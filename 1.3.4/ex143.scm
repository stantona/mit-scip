;; Exercise 1.43
;; Repeated function such that given a numberical function, and  n is a positive
;; number, the function is repeated n times on a given value x.

;; Contains the compose function
(load "ex142.scm")
(load "../helpers.scm")

(define (repeated func iterations)
  (define (repeated-iter composed r)
    (if (= r 1)
        composed
        (repeated-iter
         (compose func composed) (1- r))))
  
  (repeated-iter func iterations))
