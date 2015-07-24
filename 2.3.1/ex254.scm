;; Exercise 2.54
;; Implementation of equal?. Equal? compares lists of atoms. The set must much exactly, including the order.

(define (equal? lat1 lat2)
  (define (lists-empty?)
    (and (null? lat1) (null? lat2)))

  (define (either-list-empty?)
    (or (null? lat1) (null? lat2)))

  (cond ((lists-empty?) #t)
        ((either-list-empty?) #f)
        ((eq? (car lat1) (car lat2)) (equal? (cdr lat1) (cdr lat2)))
        (else
         #f)))
