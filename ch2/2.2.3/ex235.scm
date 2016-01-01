;; Exercise 2.35

(load "../../helpers")

(define (count-leaves t)
  (accumulate + 0 (map (lambda(x)
                         (if (not (pair? x))
                             1
                             (count-leaves x)))
                       t)))
