(load "../1.2.6/prime.scm")
(load "../../helpers.scm")

(define (prime-sum? pair)
  (prime? (+ (car pair) (cdr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cdr pair) (+ (car pair) (cdr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap (lambda(i)
                          (map (lambda(j) (cons i j))
                               (enumerate-interval 1 (1- n))))
                        (enumerate-interval 1 n)))))
                       
