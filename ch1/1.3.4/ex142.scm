;; Exercise 1.42
;; Write a compose function such that f(g(x))

(load "../../helpers")

(define (compose f g)
  (lambda (x)
    (f (g x))))
