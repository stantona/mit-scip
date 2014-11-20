;; Exercise 1.33
;; filter-accumulate
;; The accumulate function of exercise 1.33 but with a predicate to filter the index range used
;; for calculation.

(define (filtered-accumulate combiner null-value term a next b allow?)
  (define (filter-accumulate-iter x acc)
    (cond ((> x b) acc)
          ((allow? x)
           (filter-accumulate-iter
            (next x)
            (combiner (term x) acc)))
          (else
           (filter-accumulate-iter
            (next x)
            acc))))

  (filter-accumulate-iter a null-value))

;; Helper functions (TODO: put these in a separate file)
(define (1+ n) (+ n 1))

(define (1- n) (- n 1))

(define (sqr n) (expt n 2))

(define (identity n) n)

(load "../1.2.6/prime.scm")

;; a) Sum of of the square of prime numbers in a range
(define (sum-sqr-prime-numbers a b)
  (filtered-accumulate + 0 sqr a 1+ b prime?))

;; b) The product of integers less than n that are "relatively" prime. 
;; i.e GCD(i,n) = 1

;; Contains the Euclid implementation of gcd
(load "../1.2.5/gcd.scm")

(define (product-of-relative-primes n)

  (define (relative-prime? i)
    (= (gcd i n) 1))
  
  (filtered-accumulate * 1 identity 1 1+ (1- n) relative-prime?))
