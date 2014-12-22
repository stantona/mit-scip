;; Exercise 2.5
;; Implement a pair as a number that satisfies
;; 2^a.3^b
;; Demonstrates the question of what is data? That it 
;; is defined by the language that defines it (cons, car and cdr).
;; However, this implementation is ridiculously inefficient.

(load "../helpers.scm")

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (find-exponent pair base)
  (define (iter next count)
    (if (> (remainder next base) 0)
        count
        (iter (/ next base) (1+ count))))

  (iter pair 0))

(define (car pair)
  (find-exponent pair 2))

(define (cdr pair)
  (find-exponent pair 3))
