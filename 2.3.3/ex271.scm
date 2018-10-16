(load "ex269.scm")

;; Build a huffman tree with relative freqencies of 1, 2, 4, ... 2 ^ (n-1)
;; For n = 5: 1, 2, 4, 8, 16

(define tree-5
  (generate-huffman-tree
   '(
     (A 1)
     (B 2)
     (C 4)
     (D 8)
     (E 16))))

(define tree-10
  (generate-huffman-tree
   '(
     (A 1)
     (B 2)
     (C 4)
     (D 8)
     (E 16)
     (F 32)
     (G 64)
     (H 128)
     (I 256)
     (J 512))))

(pp tree-5)
(pp tree-10)
