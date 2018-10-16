(load "ex269.scm")

(define tree
  (generate-huffman-tree '((A 2) (NA 16) (BOOM  1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1))))

(define song
  '(Get a job Sha na na na na na na na na Get a job Sha na na na na na na na na Wah yip yip yip yip yip yip yip yip yip Sha boom))

(define encoded-song
  (encode song tree))

(length encoded-song)

(* 3 (length song))
