;; Exercise 2.45

;; Generalize the split functionality. 'split' returns a function that accepts a painter
;; and the number of iterations of the split.

(define (split p1 p2)
  (define (split-iter painter n)
    (if (= n 0)
        painter
        (let ((smaller (split-iter painter (1- n))))
          (p1 painter (p2 smaller smaller)))))

(define up-split (split below beside))
(define right-split (split beside below))
