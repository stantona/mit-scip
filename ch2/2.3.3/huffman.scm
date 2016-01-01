;; Huffman Tree representation
(load "set.scm")

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

;; Exercise 2.68
;; Tested against 'decode', which returns the
;; sample message
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
  
         
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

;; Exercise 2.68
(define (successive-merge leaf-set)
  (cond ((null? leaf-set) '())
        ((null? (cdr leaf-set)) (car leaf-set))
        (else
         (successive-merge
          (adjoin-set
           (make-code-tree (car leaf-set)
                           (cadr leaf-set))
           (cddr leaf-set))))))
           
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

;; Exercise 2.70
;; Generate the lyric set, ensure that the weights are ordered
(define lyric-set '((boom 1) (wah 1) (job 2) (get 2) (a 2) (sha 3) (yip 9) (na 16)))

;; Lyrics to encode (defined as message)
(define message '(get a job sha na na na na na na na na get a job sha na na na na na na na na wah yip yip yip yip yip yip yip yip yip sha boom))
;; (encode message lyric-tree)

;; ;Value 16: (1 1 1 1 1 1 1 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 0 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 1)

;; 84 bits are required to encode this message
;;
;; For a fixed length code given we have eight symbols, we will require 108 bits in the message. 8 symbols can fit into 3 bits
;; (including 000)
