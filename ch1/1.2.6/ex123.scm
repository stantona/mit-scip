;; Exercise 1.22
;; I had to change start-prime-test to return #f if not a prime to properly
;; test the condition.

;; What do functions return by default?

;; The numbers in the exercise were too small to produce any meaningful results:
;; (search-for-primes 10000000 3) 0.008001, 0.0039999, 0.004
;; (search-for-primes 100000000 3) 0.012, 0.0079999, 0.008000
;; (search-for-primes 1000000000 3) 0.032002, 0.032003, 0.024

;; prime? is an O(sqrt(n)) algorithm. 

;; Results show that by raising the power, the cpu-time of each prime result does not correlate to an an exact sqrt(10) increase.
;; The results range betwen 2 < ratio < 3.1 for the smaller number above.

;; As of 2014
;; If I do a test on higher powers, increase between powers becomes more consistent and approaches sqrt(10) ~ 3
;; Results support the notion that programs run in time proportion to the number of steps.


(load "prime")

(define (runtime)
  (cpu-time))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
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

;; Exercise 1.23

;; Original incremental test-devisor 10^12
;;1000000000039 *** .7560470000000024 (result = 1.53)
;;1000000000061 *** .7680480000000003 (result = 1.57)
;;1000000000063 *** .7600470000000001 (result = 1.57)

;; Excluding odd numbers 10^12
;;1000000000039 ==> .49202999999999975
;;1000000000061 ==> .48803000000000196
;;1000000000063 ==> .4840299999999971

;; Original incremental test-divisor 10^13
;; 10000000000037 ==> 2.412150000000004 (result = 1.59)
;; 10000000000051 ==> 2.3721490000000074 (result = 1.57)
;; 10000000000099 ==> 2.368147999999991 (result = 1.566)

;; Excluding odd numbers 10^13
;; 10000000000037 ==> 1.5160960000000046
;; 10000000000051 ==> 1.5080949999999973
;; 10000000000099 ==> 1.5120939999999976

;; By only dealing with odd numbers theoretically it halve the time it takes to do the operation.
;; In reality, it has decreased by ~1/3. 
;; There are only a few instructions for the case where the square has not exceeded the number
;; We have an extra overhead of the if test which for every iteration, checks the equality of test-divisor on 2, and if then calls the next procedure as a result.

