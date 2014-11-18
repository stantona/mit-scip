;; Greatest common denominator
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


;; Normal-order evaluation rule
(gcd 206 40)
;; Falls through to line 5 (gcd 40 (remainder 206 40))
(gcd 40 (remainder 206 40))
;; Falls through to line 3 where operand b gets evaluated as (= a b) is a primitive function (1)
;; Falls to line 5
(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))
;; At line three, operand b gets evaluated. There are two remainder calls (3)
;; Falls to line 5
(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;; At line three, operand b gets evaluated. (7)
;; Falls to line 5
(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))) 
;; At line three, operand b gets evaluated. (14)
;; At line four, operand a gets evaluated. (18)
;; The result is 2



;; Applicative-order evaluation rule
(gcd 206 40)
(gcd 40 6) ;; Evaluated on line 5 (1)
(gcd 6 4) ;; Evaluated on line 5 (2)
(gcd 4 2) ;; Evaluated on line 5 (3)
(gcd 2 0) ;; Evaluated on line 5 (4)



