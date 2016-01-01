;; Exercise 1.46

(load "deriv.scm")
(load "ex145.scm")

(define (iterative-improve pass? improve)
  (lambda(guess)
    (define (improve-iter guess)
      (let ((next (improve guess)))
        (if (pass? next guess)
            next
            (improve-iter next))))

    (improve-iter guess)))

(define tolerance 0.00001)
(define (within-tolerance? a b)
  (< (abs (- a b)) tolerance))

(define (sqrt x)
  ((iterative-improve within-tolerance?
                      (average-damp (lambda(y) (/ x y))))
   1.0))
