;; Exercise 2.40
;;
;; Define a function unique pairs that when given an integer n, produces unique pairs of 
;; integers such that 1 <= j < i <= n

(load "../helpers.scm")
(load "../1.2.6/ex128.scm")

(define (unique-pairs low high)
  (flatmap (lambda(i) 
             (map (lambda(j) (cons j i))
                  (enumerate-interval low (1- i))))
           (enumerate-interval low high)))

;; What is cadr?
(define (make-pair-sum pair)
  (list (car pair) (cdr pair) (+ (car pair) (cdr pair))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cdr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs 1 n))))
  
