;; Exercise 2.29
(load "../helpers.scm")

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define (left-structure mobile)
  ((compose branch-structure left-branch) mobile))

(define (right-structure mobile)
  ((compose branch-structure left-branch) mobile))

;; Test data.
(define l-branch (make-branch 23 50))
(define r-branch (make-branch 30 (make-mobile (make-branch 10 5) (make-branch 15 10))))
(define test-mobile (make-mobile l-struct r-struct))

;; Simple balanced mobile
(define simple-mobile (make-mobile (make-branch 5 4) (make-branch 10 2)))

(define mobile? list?)

(define (struct-eval struct m w)
  (if (mobile? struct) (m struct) (w struct)))
  
(define (branch-weight branch)
  (define (mobile-structure) (lambda(mobile) (mobile-weight mobile)))
  (define (weight-structure) (lambda(weight) weight))
  (struct-eval (branch-structure branch) (mobile-structure) (weight-structure)))
               
(define (mobile-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(define (branches-balance? left right)
  (= (branch-torque left) (branch-torque right)))

(define (branch-torque branch)
  (* (branch-length branch) (branch-weight branch)))

(define (mobile-balanced? mobile)
  (define (mobile-structure) (lambda(mobile) (mobile-balanced? mobile)))
  (define (weight-structure) (lambda(weight) #t))
  
  (define (try-submobile? struct)
    (struct-eval struct (mobile-structure) (weight-structure)))
  
  (and (branches-balance? (left-branch mobile) (right-branch mobile))
       ((compose try-submobile? left-structure) mobile) 
       ((compose try-submobile? right-structure) mobile)))
