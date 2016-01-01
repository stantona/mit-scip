;; We need the repeated function
(load "ex143.scm")
(load "../../helpers.scm")

(define dx 0.00001)

;; Function smoothing can be used in signal analysis and statistics
(define (smooth f)
  (lambda(x)
    (/ 
     (+ (f (- x dx)) 
        (f x) 
        (f (+ x dx)))
     3)))

;; repeat smoothing to smooth out a function even further
(define (n-fold-smooth f x iterations)
  (((repeated smooth iterations) f) x))
