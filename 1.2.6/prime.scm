(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

;; Added for Exercise 1.23. This eliminates even numbers from
;; the test divisors.
(define (next test-divisor)
  (if (= test-divisor 2)
      (+ test-divisor 1)
      (+ test-divisor 2)))

(define (divides? b a)
  (= (remainder a b) 0))

(define (prime? n)
  (= (smallest-divisor n) n))

(define (square n)
  (* n n))

;; > (1)
;; square (2)
;; = (3)
;; + (4)
