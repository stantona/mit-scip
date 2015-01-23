(load "../helpers.scm")

;; The raw implementation
(define (square-list items)
  (if (null? items)
      '()
      (cons 
       (sqr (car items)) 
       (square-list (cdr items)))))

;; The implementation using map
(define (square-list-alt items)
  (map sqr items))
