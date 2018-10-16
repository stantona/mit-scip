(load "huffman.scm")
(define (encode-symbol symbol tree)

  (define (member? symbol branch)
    (element-of-set? symbol (symbols branch)))

  (cond ((leaf? tree) '())
        ((member? symbol (left-branch tree))
         (cons 0 (encode-symbol symbol (left-branch tree))))
        ((member? symbol (right-branch tree))
         (cons 1 (encode-symbol symbol (right-branch tree))))
        (else
         (error "Symbol is not a member" symbol))))

;; Testing (using code from ex267.scm)
(define sample-tree
  (make-cde-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(define decoded-message (decode sample-message sample-tree))

(encode decoded-message sample-tree)
;; (0 1 1 0 0 1 0 1 0 1 1 1 0)
