(define (cc amount coin-values)
  (define (except-highest-denomination values)
    (cdr values))
  
  (define (highest-denomination values)
    (car values))

  (define (no-more? values)
    (null? values))

  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-highest-denomination coin-values))
            (cc (- amount 
                   (highest-denomination coin-values))
                coin-values)))))

;; > (define us-coins (list 50 25 10 5 1))
;; > us-coins
;; (50 25 10 5 1)
;; > (cc 100 us-coins)
;; 292

;; > (define uk-coins (list 100 50 20 10 5 2 1 0.5))
;; > (cc 100 uk-coins)
;; 104561

;; Does the order matter?
;; > (define us-coins (list 1 5 10 25 50))
;; > (cc 100 us-coins)
;; 292
;; > (define uk-coins (list 0.5 1 2 5 10 20 50 100))
;; > (cc 100 uk-coins)
;; 104561
