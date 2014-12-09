;; Fixed point function
;;
;; A number x is called a fixed point of a function if x satisfied f(x) = x;

(load "../helpers.scm")

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (trace try)
  (try first-guess))

;; Using average damping to find the fixed point of a function.
;; It is the process of finding closer approximations by averages.
(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))

;; Exercise 1.35
;; Findiing the value of the golden ratio
(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)

;; Exercise 1.36
;; Finding the value of x (expt x x) = 1000
;; Without average damping
(print "Exercise 1.36 - without average damping")
(newline)
(fixed-point (lambda (x) (/ (log 1000) (log x))) 10)
(print "30 steps without average damping")
(newline)

;; With average damping
(define (average x y)
  (/ (+ x y) 2))

(print "Exercise 1.36 - with average damping")
(newline)
(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 10)
(print "8 Steps with average damping")
(newline)
