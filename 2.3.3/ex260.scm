(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (union-set (cdr set1)
                   (adjoin-set (car set1) set2))))

(define (intersection-set set1 set2)
  (define (iter set1 set2 new-set)
    (cond ((null? set1) new-set)
          ((element-of-set? (car set1) set2)
           (iter (cdr set1)
                 set2
                 (adjoin-set (car set1) new-set)))
          (else
           (iter (cdr set1) set2 new-set))))
  (iter set1 set2 (iter set2 set1 '())))
