;; Exercise 2.2
;; Create a constructor for a segment.
;; A segment consists of two points where a point is an x and y coordinate.

(load "../../helpers.scm")

(define (make-point x y)
  (cons x y))

(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (print-point p)
  (newline)
  (print "(" (x-point p) "," (y-point p) ")")
  (newline))

(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (midpoint-segment s)
  (define (average-segment-point f)
    (average (f (start-segment s)) (f (end-segment s))))

  (cons (average-segment-point x-point)
        (average-segment-point y-point)))
  
