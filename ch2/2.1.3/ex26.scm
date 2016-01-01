;; Exercise 2.6 - Lambda Calculus
;; Church numerals
(load "../../helpers.scm")

;; zero = Lf.Lx.x
(define zero (lambda(f) (lambda(x) x)))

;; next = Ln.Lf.Lx(f ((n f) x))
(define (add-1 n)
  (lambda(f) (lambda(x) (f ((n f) x)))))

;; one = Lf.Lx.(f x)
(define one
  (lambda(f) (lambda(x) (f x))))

;; two = Lf.Lx.(f (f x))
(define two
  (lambda(f) (lambda(x) (f (f x)))))

;; three = Lf.Lx(f (f (f x)))
(define three
  (lambda(f) (lambda(x) (f (f (f x))))))

(define (add m n)
  (lambda(f)
    (lambda(x)
      ((n f) ((m f) x)))))

;; inc = Ln.(n+1)
;; add = Lm.Ln.Lf.Lx(((n f) ((m f) x)))

;;(add zero one)
;;(lambda(f) (lambda(x) ((one f) ((zero f) x))

;;(lambda(f) (lambda(x) (((lambda(g) (lambda(y) (g y))) f) ((lambda(g) (lambda(x) x)) x))
;;(lambda(f) (lambda(x) ((lambda(y) (f y)) x)
;;(lambda(f) (lambda(x) (f x)))

;; add-1 returns a function
;; That function when called, returns another function.

;;(add-1 zero) (one)
;;((lambda(f) (lambda(x) (f ((n f) x)))) zero)
;;(lambda(f) (lambda(x) (f ((zero f) x))))
;;(lambda(f) (lambda(x) (f ((lambda(g) (lambda(y) y)) f) x))))
;;(lambda(f) (lambda(x) (f ((lambda(f) f) x))))
;;(lambda(f) (lambda(x) (f x))) (Lf.Lx.(f x)


;;(add-1 one)
;;((lambda(f) (lambda(x) (f ((n f) x)))) one)
;;(lambda(f) (lambda(x) (f ((one f) x))))
;;(lambda(f) (lambda(x) (f ((lambda(g) (lambda(y) (g y))) f) x)))
;;(lambda(f) (lambda(x) (f ((lambda(y) (f y)) x))))
;;(lambda(f) (lambda(x) (f (f x))))


