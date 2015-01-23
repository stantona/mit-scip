(load "../helpers.scm")

(define (each proc items)
  (define (iter op ls)
    (if (null? ls)
        #t
        (iter (proc (car ls)) (cdr ls))))
  (iter #t items))
