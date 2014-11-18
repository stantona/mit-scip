;; Exercise 1.31a

;; Iterative product function. Demonstrate this to calculate factorials and the an approximation
;; to prime.

;; Iterative process
;; (define (product term a next b)
;;   (define (iter a acc)
;;     (cond ((= acc 0) 0)
;;           ((> a b) acc)
;;           (else
;;            (iter (next a) (* (term a) acc)))))

;;   (iter a 1))

;; Recursive process
(define (product term a next b)
  (cond ((= a 0) 0)
        ((> a b) 1)
        (else
         (* (term a) (product term (next a) next b)))))

(define (factorial a b)
  (define (inc n) (+ n 1))
  (define (identity n) n)
  (product identity a inc b))


;; pi/4 = 2/3 * 4/3 * 4/5 * 6/5 * 6/7 * 8/7 * 8/9 * 10/9
;; pi/4 = 8/9 * 24/25 * 48/49 * 80/81

(define (pi)
  (define (square n)
    (expt n 2))

  (define (pi-next a)
    (+ a 2))

  (define (pi-term a)
    (/ (- (square a) 1) (square a)))

  (* (product pi-term 3 pi-next 30000) 4))
