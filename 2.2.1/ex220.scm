;; Exercise 2.20 Same parity

(define (same-parity first . items)
  (let ((parity (if (odd? first) odd? even?)))
    
    (define (same-parity-iter ls filtered)
      (cond ((null? ls) (reverse filtered))
            ((parity (car ls)) 
             (same-parity-iter (cdr ls) (cons (car ls) filtered)))
            (else
             (same-parity-iter (cdr ls) filtered))))

    (same-parity-iter (cons first items) '())))
