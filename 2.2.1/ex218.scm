(define (reverse ls)
  (define (reverse-iter old new)
    (if (null? old)
        new
        (reverse-iter 
         (cdr old)
         (cons (car old) new))))

  (reverse-iter ls (list)))
