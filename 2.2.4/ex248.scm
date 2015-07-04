;; Exercise 2.48
;;
;; Represenation of line segments using two vectors.

(load "ex247.scm")

(define (make-segment vect-start vect-end)
  (cons vect-start vect-end))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))
