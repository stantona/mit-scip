;; Helper functions used in many of the exercises

;; Increment number
(define (1+ n) (+ n 1))

;; Decrement number
(define (1- n) (- n 1))

;; Square number
(define (sqr n) (expt n 2))

;; Cube number
(define (cube n) (* n (sqr n)))

;; Return paramter (not required after lambda section)
(define (identity n) n)

;; The average of two numbers
(define (average x y) (/ (+ x y) 2))
