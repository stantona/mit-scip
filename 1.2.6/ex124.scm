(load "ex125")

(define (runtime)
  (cpu-time))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n 10000)
      (report-prime (- (runtime) start-time) n)
      #f))
  
(define (report-prime elapsed-time n)
  (newline)
  (display n)
  (display " ==> ")
  (display elapsed-time))

(define (search-for-primes sample repeat)
  (cond ((= repeat 0) #t)
        ((even? sample) (search-for-primes (+ sample 1) repeat))
        (else 
         (if (timed-prime-test sample)
             (search-for-primes (+ sample 2) (- repeat 1))
             (search-for-primes (+ sample 2) repeat)))))

(search-for-primes (expt 10 3) 3)
(search-for-primes (expt 10 6) 3)
;;(search-for-primes (expt 10 14) 3)

;; > O(3) 
;; 1009 ==> .1320079999999999
;; 1013 ==> .1240079999999999
;; 1019 ==> .1320079999999999#t

;; > O(6) => 6/3 ~ (0.212/0.124) ~ 1.7096
;; 1000003 ==> .20801300000000023
;; 1000033 ==> .20801300000000023
;; 1000037 ==> .21201299999999978#t

;; Higher number support the logorithmic growth
;; 1000000000039 ==> .08000499999999988
;; 1000000000061 ==> .07600400000000018
;; 1000000000063 ==> .07200499999999987#t
;; > 
;; 1000000000000000000000007 ==> .1640100000000002
;; 1000000000000000000000049 ==> .16401099999999946
;; 1000000000000000000000121 ==> .16800999999999977#t

;; Extra investigation, comparing with smallest divisor implementation
;; (smallest divisor O(sqrt 10^12) vs O(12) ~ 83x
;; 1000000000039 ==> .08000499999999966 (x6.25)
;; 1000000000061 ==> .07200500000000032 
;; 1000000000063 ==> .07200399999999973#t

;; > 1.05x (0.076/0.072) ~ (12/11)
;; 10000000000037 ==> .07200399999999973 (x20.86)
;; 10000000000051 ==> .07600500000000032 
;; 10000000000099 ==> .07600499999999988#t

;; > 1.10x (0.084/0.076) ~ (13/12)
;; 100000000000031 ==> .08400499999999989
;; 100000000000067 ==> .08000500000000033
;; 100000000000097 ==> .08400599999999958#t

