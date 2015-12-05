(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

(define (intersection-list list1 list2)
  (cond ((or (null? list1) (null? list2)) '())
        ((< (car list1) (car list2))
         (intersection-list (cdr list1) list2))
        ((> (car list1) (car list2))
         (intersection-list list1 (cdr list2)))
        (else
         (cons (car list1)
               (intersection-list (cdr list1) (cdr list2))))))

(define (union-list list1 list2)
  (cond ((null? list1) list2)
        ((null? list2) list1)
        ((< (car list1) (car list2))
         (cons (car list1)
               (union-list (cdr list1) list2)))
        ((> (car list1) (car list2))
         (cons (car list2)
               (union-list list1 (cdr list2))))
        (else
         (cons (car list1)
               (union-list (cdr list1) (cdr list2))))))

(define (union-set set1 set2)
  (list->tree (union-list
               (tree->list set1)
               (tree->list set2))))
     
(define (intersection-set set1 set2)
  (list->tree (intersection-list
               (tree->list set1)
               (tree->list set2))))
