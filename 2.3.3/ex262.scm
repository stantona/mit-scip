;; Exercise 2.62

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((= (car set1) (car set2))
         (cons (car set1) (union-set (cdr set1) (cdr set2))))
        ((< (car set1) (car set2))
         (cons (car set1) (union-set (cdr set1) set2)))
        (else
         (cons (car set2) (union-set set1 (cdr set2))))))

(newline)
(write-string "set1 is empty\n")
(pp (union-set '() '(2 3 5 9)))
(write-string "set2 is empty\n")
(pp (union-set '(2 3 5 9) '()))
(write-string "set1 and set2 are distinct\n")
(pp (union-set '(1 9 11 25 26) '(101 102 200 210)))
(write-string "set1 and set2 intersect\n")
(pp (union-set '(1 9 11 25 26) '(1 5 9 11 12 13 25 99)))
