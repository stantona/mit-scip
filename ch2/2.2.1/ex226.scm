(define x (list 1 2 3))
(define y (list 4 5 6))

;; It's best to think of these in box dot notation.
(append x y) ;; (1 2 3 4 5 6)
(cdr (append x y)) ;; (2 3 4 5 6)

(cons x y) ;; ((1 2 3) 4 5 6)
(cdr (cons x y)) ;; (4 5 6)

(list x y) ;; ((1 2 3) (4 5 6))
(cdr (list x y)) ;; ((4 5 6)) Returns a list of a list, with the second element in the pair being nil
