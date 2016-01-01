;; Exercise 2.3 Implement a representation of a rectangle

;; Experiment with two points
;; Understand the abstraction barriers
(load "ex22.scm")
(load "../../helpers.scm")

(define (start-point r) (car r))
(define (opp-point r) (cdr r))

(define (distance f r)
  (- (f (opp-point r)) (f (start-point r))))

(define (length-rectangle r)
  (distance x-point r))

(define (depth-rectangle r)
  (distance y-point r))

(define (make-rectangle p len dep)
  (define (make-opposite-point)
    (make-point (+ (x-point p) len)
                (+ (y-point p) dep)))

  (make-segment p (make-opposite-point)))

(define (area-rectangle r)
  (abs (* (length-rectangle r) (depth-rectangle r))))

(define (parameter-rectangle r)
  (define (abs-value f r)
    ((compose abs f) r))

  (double (+ (abs-value length-rectangle r) 
             (abs-value depth-rectangle r))))
