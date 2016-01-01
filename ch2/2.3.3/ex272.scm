;; Exercise 2.72

;; The order of growth required to encode a symbol is O(n log n), assuming a balanced huffman tree.

;; When examining the case in Exercise 2.71, the worst case scenario, that is traversing the left
;; side of the tree, the order of growth would approach O(n). This is because for the worst case, the
;; element always appears at the beginning of the set, hence the find operation on each node is O(1).
;; For the best case scenario, it is O(n), since the left branch will be searched, leaving the right branch
;; as the result.

