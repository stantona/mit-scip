;; Exercise 2.32 - Function to create subsets

(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda(x) (cons (car s) x)) rest)))))

;; (subsets '(1 2 3))
;; | > (subsets '(1 2 3))
;; | | > (subsets '(2 3))
;; | | | > (subsets '(3))
;; | | | | > (subsets '())
;; | | | | (())
;; | | | > (append '(()) '((3)))
;; | | | (() (3))
;; | | > (append '(() (3)) '((2) (2 3)))
;; | | (() (3) (2) (2 3))
;; | > (append '(() (3) (2) (2 3)) '((1) (1 3) (1 2) (1 2 3)))
;; | (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
;; (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))

;; Note that let can be thought of as:
;; ((lambda(rest)
;;    (append rest (map (lambda(x) (cons (car s) x)) rest)) (subsets (cdr s)))
