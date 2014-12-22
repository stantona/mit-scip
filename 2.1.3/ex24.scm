;; m is a function
(define (cons x y)
  (lambda(m) (m x y)))

(define (car z)
  (z (lambda(p q) p)))

(define (cdr z)
  (z (lambda(p q) q)))

;; (cons 2 1)
;; (lambda(m) (m 2 1))
;; (cdr (lambda(m) (m 2 1)))
;; (((lambda(m) (m 2 1)) (lambda(p q) q)))
;; (lambda(m) ((lambda(p q) q) 2 1))
;; (lambda(m) ((lambda(2 1) 1)))
;; 1
