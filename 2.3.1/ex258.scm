(load "../helpers.scm")

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else
         (list '+ a1 a2))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-product a1 a2)
  (cond ((or (=number? a2 0) (=number? a1 0)) 0)
        ((=number? a1 1) a2)
        ((=number? a2 1) a1)
        ((and (number? a1) (number? a2)) (* a1 a2))
        (else
         (list '* a1 a2))))

;; Exercise 2.56
(define (make-exponentiation exp exponent)
  (cond ((eq? exponent 1) exp)
        ((eq? exponent 0) 1)
        (else
         (list '** exp exponent))))

;; Exercise 2.58
(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))

;; Exercise 2.58
(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))

;; Exercise 2.58
(define (exponentiation? exp)
  (and (pair? exp) (eq? (cadr exp) '**)))
  
;; Exercise 2.58
(define (addend s) (car s))

(define (multiplier p) (car p))

;; Exercise 2.58
(define (augend s) (caddr s))

;; Exercise 2.58
(define (multiplicand p) (caddr p))

;; Exercise 2.58
(define (exponent exp) (caddr exp))
(define (base exp) (car exp))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ((exponentiation? exp)
         (make-product
          (make-product (exponent exp)
                        (make-exponentiation
                         (base exp)
                         (make-sum (exponent exp) -1)))
          (deriv (base exp) var)))
        (else
         (error "unknown expression type --DERIV" exp))))
