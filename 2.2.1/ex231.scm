;; Exercise 2.31 - Create a tree-map function.

(define (tree-map f tree)
  (map (lambda(node)
         (if (not (list? node))
             (f node)
             (tree-map f node)))
       tree))

