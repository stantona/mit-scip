;; Exercise 2.44

;; Upsplit switches the below and beside calls.

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter(1- n))))
        (below painter (beside smaller smaller)))))
