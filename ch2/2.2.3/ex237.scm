;; Exercise 2.37 matrix algebra

(load "../../helpers.scm")
;; Load the exercise for accumulate-n
(load "ex236.scm")

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda(x)
         (dot-product x v))
       m))

(define (transpose mat)
  (accumulate-n cons '() mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda(v)
           (matrix-*-vector cols v))
         m)))
