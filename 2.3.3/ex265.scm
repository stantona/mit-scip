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

;; Accepts to binary trees, and performs a union, returning a balanced
;; binary tree.
(define (union-set set1 set2)

  (define (append-uniq list1 list2)
    (cond ((null? list1) list2)
          ((null? list2) list1)
          (else
           ((let ((first-list1 (car list1))
                  (first-list2 (car list2)))
              (cond ((< first-list1 first-list2)
                     (cons first-list1 (append-uniq (cdr list1) list2)))
                    ((> first-list1 first-list2)
                     (cons first-list2 (append-uniq list1 (cdr list2))))
                    (else
                     (cons first-list1 (append-uniq (cdr list1) (cdr list2))))))))))
     
  (let ((elements (append-uniq
                   (tree->list set1)
                   (tree->list set2))))
    (list->tree elements)))
