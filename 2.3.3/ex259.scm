(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)

  (define (remove-first-occurance x set)
    (define (iter set removed result)
      (cond ((null? set) result)
            ((and (not removed) (eq? x (car set)))
             (iter (cdr set) true result))
            (else
             (iter (cdr set)
                   removed
                   (cons (car set) result)))))
    (iter set false '()))

  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set
                (cdr set1)
                (remove-first-occurance (car set1) set2))))
        (else (intersection-set (cdr set1) set2))))


;; Exercise 2.59.  Implement the union-set operation for the unordered-list representation of sets.
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
         (union-set (cdr set1)
                    (adjoin-set (car set1) set2)))))

;; Test 'union-set'
;; 1 ]=> (union-set '() '())

;; ;Value: ()

;; 1 ]=> (union-set '(1 2 3) '())

;; ;Value 2: (1 2 3)

;; 1 ]=> (union-set '(1 2 3) '(1 2 3 4))

;; ;Value 3: (1 2 3 4)

;; 1 ]=> (union-set '(1 2 3 4) '(1 2 3))

;; ;Value 4: (4 1 2 3)

;; 1 ]=> (union-set '(1 10 9) '(8 9 12 14 1))

;; ;Value 5: (10 8 9 12 14 1)

;; The performance for the intersection operation degrades to O(n^3) as a check is required for each element, along with rebuilding a set for matched elements.
;; The performance for the union operation improves to O(n) as elements no longer need to be matched.
;; The performance for adjoin-set is O(1) as it is a single cons operation.
