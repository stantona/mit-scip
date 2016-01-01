(load "../../helpers.scm")

(define (each proc items)
  (cond ((null? items) #t)
        (else
         (proc (car items))
         (each proc (cdr items)))))
