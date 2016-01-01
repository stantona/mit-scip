(load "../../helpers")

(define (square-tree tree)
  (cond ((null? tree) tree)
        ((not (list? tree)) (sqr tree))
        (else
         (cons (square-tree (car tree))
               (square-tree (cdr tree))))))

(define (square-tree-map tree)
  (map (lambda(node)
         (if (not (list? node))
             (sqr node)
             (square-tree-map node)))
       tree))

;; (list 2 (list 3 4))
;; (cons (square-tree 2) (square-tree '(3 4)))
;; (cons 4 (cons (square-tree 3) (square-tree 4)))
;; (cons 4 (cons 9 16))
;; '(4 '(9 16))
