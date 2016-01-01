;; EX 128 (Miller Rabin Test)

;; Fermat's Little Theorem: If n is a prime number and a is any positive integer less than n, 
;; then a raised to the nth power is congruent to a modulo n.

;; Example:
;; n: 17 (prime)
;; a: 3 (random)
;; 3^17 cong 3 modulo 17
;; 129140163 cong 3 modulo 17 (remainder 3)
;; 3 cong 129140163 modulo 17 (remainder 3)
;; Therefore 17 is prime for n: 3.

;; Miller Rabin Test: If n is a prime number and a is any positive integer less than n, 
;; then a raised to the (n - 1) power is congruent to 1 modulo n.
;;
;; n: 17 (prime)
;; a: 3 (random)
;; 3^16 cong 1 modulo 17
;; 43046721 cong 1 modulo 17 (remainder 1)
;; 1 cong 43046721 modulo 17

;; n: 17 (prime)
;; a: 6 (random)
;; 6^16 cong 1 modulo 17 (remainder 1)
;; 1 cong 6^16 modulo 17 

;; random-integer produces a random integer including zero

;; What is a non-trivial square root of 1 modulo n
(define (expmod base exp m)
  ;; Test non-trival sqrt of 1 modulo n
  (define (test-sqrt n)
    (cond ((or (= n 1) (= n (- m 1))) n)
          ((= (remainder (square n) m) 1) 0)
          (else n)))

  (cond ((= exp 0) 1)
        ((even? exp) 
         (remainder (square (test-sqrt (expmod base (/ exp 2) m))) m))
        (else
         (remainder (* base (expmod base (- exp 1) m)) m))))

(define (square n)
  (* n n))

(define (test prime seed)
  (= (expmod seed (- prime 1) prime) 1))

(define (thorough-test prime)
  (define (thorough-test-iter n a)
    (cond ((= a 0) #t)
          ((test n a) (thorough-test-iter n (- a 1)))
          (else #f)))

  (thorough-test-iter prime (- prime 1)))

(define (prime? n)
  (thorough-test n))
