;; Exercise 1.41
;; Create a procedure double that takes as an argument
;; a function to be applied twice.
(load "../helpers")

(define (double f)
  (lambda (x)
    (f (f x))))

;;(double double)
;;(lambda(x) (double (double x)))
;;(double (double double))
;;(double (lambda(x) (double (double x))))
;;(lambda(x) (double (double (double (double x))))))
;;((lambda(x) (double (double (double (double x))))) 1+)
;;(double (double (double (double 1+))))
;;(double (double (double (lambda(x) (1+ (1+ x))))))
;;(double (double (lambda(x) (1+ (1+ ((1+ (1+ x))))))))
;;(double (lambda(x) (1+ (1+ ((1+ (1+ (1+ 1+ ((1+ 1+ x))))))))))
;;(lambda(x) (1+ (1+ ((1+ (1+ (1+ 1+ ((1+ 1+ ((1+ (1+ ((1+ (1+ (1+ 1+ ((1+ 1+ x))))))))))))))))))
;; (1+ 1+ ((1+ (1+ (1+ (1+ ((1+ (1+ ((1+ (1+ ((1+ (1+ (1+ 1+ ((1+ 1+ 5))))))))))))))))))
;; 21
