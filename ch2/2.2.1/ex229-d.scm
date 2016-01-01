;; Exercise 2.29 (part d)
;; Change from list implementation to cons

;; Three lines of code requied - see comments below.

(load "../../helpers.scm")

(define (make-mobile left right)
  (cons left right)) ;; contructor change

(define (make-branch length structure)
  (cons length structure)) ;; contructor change

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile)) ;; right branch change

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch)) ;;right structure change

(define (left-structure mobile)
  ((compose branch-structure left-branch) mobile))

(define (right-structure mobile)
  ((compose branch-structure right-branch) mobile))

(define mobile? pair?) ;; Change to how we test whether it is a mobile

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
