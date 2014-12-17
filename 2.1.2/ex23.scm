;; Exercise 2.3 Implement a representation of a rectangle

;; Experiment with two points
;; Understand the abstraction barriers
(load "ex22.scm")

;; (2,3) 4, -2
(define (make-rectangle p len dep)
  (define (make-opposite-point)
    (make-point (+ (x-point p) len)
                (+ (y-point p) dep)))

  (make-segment p (make-opposite-point)))

(define (start-point r) (car r))
(define (opp-point r) (cdr r))

(define (distance f r)
  (abs (- (f (opp-point r)) (f (start-point r)))))

(define (length-rectangle r)
  (distance x-point r))

(define (depth-rectangle r)
  (distance y-point r))

(define (area-rectangle r)
  (* (length-rectangle r) (depth-rectangle r)))

(define (parameter-rectangle r)
  (* (+ (length-rectangle r) (depth-rectangle r)) 2))
