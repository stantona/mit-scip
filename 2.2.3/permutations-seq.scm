;; Find all permutations of a set of numbers

;; For each x in S, recursively generate the sequence of permutations of S - x, and adjoin x to each one.
;; Take set {1, 2, 3}
;; {1, 2, 3}, {1, 3, 2}, {3, 2, 1}, {2, 3, 1}, {3, 1, 2}, 
;; {2, 3} {3, 2}
(load "../helpers.scm")

(define (permutations s)
  (if (null? s)
      (list '())
      (flatmap (lambda(x)
                 (map (lambda(p) (cons x p))
                      (permutations (remove x s))))
               s)))

(define (remove item sequence)
  (filter (lambda(x) (not (= x item))) sequence))
