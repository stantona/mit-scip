;; Fermat test
;; exp is the prime number
;; base is a random number
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) 
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else
         (remainder (* base (expmod base (- exp 1) m)) m))))

(define (square n)
  (* n n))

(define (fermat-test prime)
  (define (try-it random)
    (= (expmod random prime prime) random))
  (try-it (random-integer prime)))

(define (prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (prime? n (- times 1)))
        (else #f)))

