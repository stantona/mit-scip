(load "btree.scm")

(define variation-a
  (make-tree 7
             (make-tree 3
                        (make-tree 1 '() '())
                        (make-tree 5 '() '()))
             (make-tree 9
                        '()
                        (make-tree 11 '() '()))))

(define variation-b
  (make-tree 3
             (make-tree 1 '() '())
             (make-tree 7
                        (make-tree 5 '() '())
                        (make-tree 9
                                   '()
                                   (make-tree 11 '() '())))))

(define variation-c
  (make-tree 5
             (make-tree 3
                        (make-tree 1 '() '())
                        '())
             (make-tree 9
                        (make-tree 7 '() '())
                        (make-tree 11 '() '()))))

;; recursive implementation using append
(trace append)
(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

;; (trace tree->list-1)

;; iterative implementation
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (trace copy-to-list)
  (copy-to-list tree '()))

;; Exercise 2.63b
;;
;; (tree->list-1)
;; The order of growth for the append procedure is proportional to the size of the first list.
;; If the binary tree is not balanced, and all elements fall on the left most branch, then
;; the left branch will return n elements, whereas the right branch will always
;; return an empty list. "append" will act on (n-1), (n-2), (n-3) lists respectively. This
;; repetitive call on each left branch list makes it an O(n^2) operation.
;;
;; However, the question asks for the order of growth for an balanced tree. This means that
;; each branch contains n/2 elements as it is a balanced list.
;;
;; For a balanced list, the size of each left branch will approximately look like:
;; (n/2), (n/4), (n/8), (n/16), (n/32). In other words, the size for each sub branch is halved.

;; We could calculate the total number of elements of the tree like this:
;; 2 * (n/2 + n/4 + n/8 + n/16 + n/32 + .. 0)
;;
;; Say there are 64 items in the tree. The left branch will have 32 and the right will have 32.
;; Each will then be devided accordingly 16, 8, 4, 2 etc.
;;
;; Therefore, the number of times the recursive call is made is approximately equal to the depth
;; of the tree, which is log n (base 2). log 64 is 6, so the tree will have a depth of 6 nodes.
;;
;; Because append acts on the number of items returned by each recurisive call, and it is a O(n)
;; operation, the overall order of growth is O(n * log n).

;; tree->list-2
;;
;; This algorithm is easier to visualize the order of growth. This is still recursive,
;; except that it is iterative. There is no call to append, and each item is "cons" onto
;; the list in an iterative way. Since "cons" is assumed to be constant (O(1)), and is the
;; only tangible operation, the order of growth is O(n).

;; Note, the use of "append" in the first algorithm really degraded the performance.
;; In summary, for each list created by the left branch, it would do an "append" operation. 

