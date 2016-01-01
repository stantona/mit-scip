;; EX125
;;
;; It gives the same result with a big caveat.
;; Notice that the expt-fast implementation calculates the entire
;; result for the random number raised to the power of the proposed
;; prime. This puts burden on memory and on computation given the limits
;; of integer logic.

;; With expmod, the numbers are kept very small with each recursive call.
;; (trace expmod)
;; > (expmod 16 17 17)
;; | > (expmod 16 17 17)
;; | | > (expmod 16 16 17)
;; | | | > (expmod 16 8 17)
;; | | | | > (expmod 16 4 17)
;; | | | | | > (expmod 16 2 17)
;; | | | | | | > (expmod 16 1 17)
;; | | | | | | | > (expmod 16 0 17)
;; | | | | | | | 1
;; | | | | | | 16
;; | | | | | 1
;; | | | | 1
;; | | | 1
;; | | 1
;; | 16
;; 16
;; > (trace expt-fast)
;; > (expmod 16 17 17)
;; | > (expt-fast 16 17)
;; | | > (expt-fast 16 16)
;; | | | > (expt-fast 16 8)
;; | | | | > (expt-fast 16 4)
;; | | | | | > (expt-fast 16 2)
;; | | | | | | > (expt-fast 16 1)
;; | | | | | | | > (expt-fast 16 0)
;; | | | | | | | 1
;; | | | | | | 16
;; | | | | | 256
;; | | | | 65536
;; | | | 4294967296
;; | | 18446744073709551616
;; | 295147905179352825856
;; 16
(define (expmod base exp m)
  (remainder (expt-fast base exp) m))

(define (expt-fast base exp)
  (cond ((= exp 0) 1)
        ((even? exp)
         (square (expt-fast base (/ exp 2))))
         (else
          (* base (expt-fast base (- exp 1))))))

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
