(load "ex22.scm")
(load "../helpers.scm")
;; This is a simpler implementation that only makes use of length and depth.
;; The point is defines where the rectangle is located on the plane. Length and depth
;; could positive or negative which would dictate the direction the rectange is drawn.
(define length car)
(define depth cdr)

(define (distance f r)
  (f (cdr r)))

(define (length-rectangle r)
  (distance length r))

(define (depth-rectangle r)
  (distance depth r))

(define (make-rectangle p len dep)
  (cons p (cons len dep)))

(define (area-rectangle r)
  (abs (* (length-rectangle r) (depth-rectangle r))))

(define (parameter-rectangle r)
  (define (abs-value f r)
    ((compose abs f) r))

  (double (+ (abs-value length-rectangle r) 
             (abs-value depth-rectangle r))))
