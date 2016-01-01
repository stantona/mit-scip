;; Exercise 2.71
;; Suppose we have a Huffman tree for an alphabet of n symbols, and that the relative frequencies of the symbols are 1, 2, 4, ..., 2n-1.
;; Sketch the tree for n=5, for n=10. In such a tree (for general n) how many bits are required to encode the most frequent symbol? the least frequent symbol?

;; For n=5

;; 2^0, 2^1, 2^2, 2^3, 2^4
;; 1, 2, 4, 8, 16, 32
;; A=1, B=2, C=4, D=8, E=16
;; ((A 1) (B 2) (C 4) (D 8) (E 16))
;; ((ab 3) (c 4) (d 8) (e 16))
;; ((abc 7) (d 8) (e 16))
;; ((abcd 15) (e 16))
;; We need 1 bit for the most frequent symbol, and (n-1) bits for the least frequent symbol

(load "huffman.scm")

(define n-five (generate-huffman-tree '((a 1) (b 2) (c 4) (d 8) (e 16))))

(define n-ten (generate-huffman-tree '((a 1) (b 2) (c 4) (d 8) (e 16) (f 32) (g 64) (h 128) (i 256) (j 512))))
