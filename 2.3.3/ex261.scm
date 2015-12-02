(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cond ((or (null? set)
             (< x (car set)))
         (cons x set))
        ((= x (car set)) set)
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))
         
