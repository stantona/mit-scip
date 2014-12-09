;; This is an infinite continued fraction algorithm
;; The exercise is to approximate 1/(golden-ratio), we 
;; can do this when the N and D functions are always 1.
(load "../helpers.scm")

;; Recursive method
(define (cont-frac n d k)
  (define (term count)
    (if (> count k)
        0
        (/ (n count) (+ (d count) (term (+ count 1))))))

  (term 1))

;; Iterative method
(define (cont-frac-iter n d k)

  (define (next-divisor count divisor)
    (+ (d (1- count)) (/ (n count) divisor)))

  (define (iter count divisor)
    (if (= count 1) 
        (/ (n count) divisor)
        (iter (1- count) 
              (next-divisor count divisor))))

  (trace iter)
  (iter k (d k)))

;; Golden ratio given a k constant
(define (golden-ratio k)
  (cont-frac-iter (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  k))

(define (inverse-golden-ratio k)
  (expt (golden-ratio k) -1))

;; Find the k-term for a continuous function that converges to a point
(define (find-k-term f tolerance)
  (define (try prev-value k)
    (let ((new-value (f k)))
      (if (> (abs(- new-value prev-value)) tolerance)
          (try new-value (1+ k))
          k)))

    (try 0 1))

;; By executing find-k-term with a tolerance of 0.0001 (4 decimal places), 
;; k must equal 12 to reach the tolerance.
  
      
