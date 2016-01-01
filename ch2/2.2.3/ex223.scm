;; Exercise 2.33

(load "../../helpers")

(define (map-t p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

(define (append-t seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length-t sequence)
  (accumulate 1+ 0 sequence))
