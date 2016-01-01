;; Exercise 1.32

;; An accumulator function to generalize functions like sum and product

;; Iterative process
(define (accumulate-iterative combiner null-value term a next b)
  (define (accumulate-iter x acc)
    (if (> x b)
        acc
        (accumulate-iter
         (next x)
         (combiner acc (term x)))))

  (accumulate-iter a null-value))

;; Recursive process
(define (accumulate-recursive combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner a
                (accumulate-recursive
                combiner
                null-value
                term
                (next a)
                next
                b))))
         
;; Incrementer function
(define (1+ n) (+ n 1))

;; I wonder if scheme allows for default parameters?
(define (factorial a b accumulator)
  (accumulator * 1 (lambda (n) n) a 1+ b))

(define (sum a b accumulator)
  (accumulator + 0 (lambda (n) n) a 1+ b))
