;; EX127
;; This indeeds demostrates the carmichael numbers:
;; 561, 1105, 1729, 2465, 2821, 6601
(load "fermat")

(define (carmichael? prime)
  (if (prime? prime (- prime 1))
      #f
      #t))
