(load "huffman.scm")

(define (successive-merge leaves)
  (cond ((null? leaves) null)
        ((null? (cdr leaves)) (car leaves))
        (else (successive-merge
               (adjoin-set (make-code-tree (car leaves) (cadr leaves))
                           (cddr leaves))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))


