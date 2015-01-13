(load "interval-arith.scm")
(load "../test-helpers.scm")

(define (test-interval-percent desc center percent)
  (let ((interval (make-center-percent center percent)))
    (assert = desc percent (interval-percent interval))))

(test-interval-percent "negative interval" -2.5 20)
(test-interval-percent "positive interval" 2.5 20)
(test-interval-percent "zero interval" -0.1 50)
