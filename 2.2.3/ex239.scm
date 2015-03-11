;; Exercise 2.39 Implementation of reverse using fold-right and fold-left

(define (reverse-r sequence)
  (fold-right (lambda (x y) (append y (list x))) '() sequence))

(define (reverse-l sequence)
  (fold-left (lambda (x y) (cons y x)) '() sequence))
