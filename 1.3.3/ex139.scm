;; Load the continued fraction functcion
(load "ex137.scm")
(load "../helpers.scm")

;; Tangent function using continued fraction.
;; Published in 1770 by mathematician J.H Lambert
(define (tan-cf x k)
  (let ((sqr-x (sqr x)))
    (cont-frac-iter (lambda (i)
                      (if (= i 1)
                          x
                          (- sqr-x)))
                    (lambda (i)
                      (+ i (- i 1)))
                    k)))
