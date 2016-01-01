;; Exercise 2.64a

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

;; returns a pair, where the car is the constructed tree, and the cdr is the list
;; of elements not included in the tree.
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

;; This procedure traverses the length of the list, with n/2 elements in both branches.
;;
;; At the deepest level, a null list is created, as given by the (= n 0) condition.
;; Therefore, all leaves are null lists, as prescribed by the definition of the binary
;; tree.
;; At each level on the recursive stack, the left most element in "elts" is marked as the current entry.
;; The right branch is constructed similarly, traversing the depth of the list, where
;; at the deepest level, the terminating condition is encountered.
;;
;; For a list that looks like (1 3 5 7 9 11), the initial left result will look like
;; (() 1 3 5 7 9 11). The current entry will be 1.
;; Note that it took 3 recursive calls to get to this result, passing n as 6, 2, 0
;; respectively.
;; The right result will be constructed by calling (partial-tree (3 5 7 9 11) 1).
;;
;; Now keep note that the current entry above is 1. Once we enter the right "partial-tree"
;; call, we will get a new "current-entry". We will also get a new "left-result":
;; (() 3 5 7 9 11). The "current-entry" will be 3. We will then "right-tree" again,
;; by calling (partial-tree (5 7 9 11) 0), which off the bat will return (() 5 7 9 11).
;; Note that current-entry is still three and we now have a left-result and right result.
;; We are not at the stage where we can make a tree, which will consist of the "current-entry",
;; 3, and the two empty lists (or null) as the left and right branches. The remaining entries
;; are those entrie in the right result.
;;
;; We end up with ((3 () ()) 5 7 9 11). Note at this point, we have exited from second
;; call, that sets "right-result". We are now at the point in the stack where 1 is the
;; "current-entry". Here we are ready to build another tree, which will be the "current-entry",
;; 1, with a left branch of () (see the left result above in 1), and the right branch of (3 () (;; )). The overall result is ((1 () (3 () ())) 5 7 9 11).
;;
;; We see a patern emerge; for the remainder of the list, we will see that 5 will be a higher le;; level "current-entry", and the remainder of the list will be built. 9 will be another higher ;; level entry with 7 and 11 as children. The result of the (7 9 11) list is (9 (7 () ()) (11 ();;  ()). We have a left and right branch, and a high level entry 5. So the overall list will be:
;; (5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))
;;
;; Exercise 2.64(b)
;; Given the explaination above, the order of growth is O(n).
;; T(n) = 2*T(n/2) + O(1)
;; O(n)
