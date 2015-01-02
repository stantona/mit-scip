;; 2.1.4 Interval arithmetic
(load "../helpers.scm")

;; Does a represent the lower interval? and vice versa for b?
(define (make-interval a b) (cons a b))

;; This assumes that upper bound is the second value in the pair
(define (upper-bound interval) (cdr interval))
;; This assumes that lower bound is the first value in the pair
(define (lower-bound interval) (car interval))

(define (interval-eql? a b)
  (and (= (lower-bound a) (lower-bound b))
       (= (upper-bound a) (upper-bound b))))

;; ex211 
;; This not clean code but as alluded to by the exercise, the idea
;; is to clearly convey each of the 9 cases.
;; The nineth case shows the double multiplication that must occur.
;; I would never implement interval multiplcation like this and stick to
;; the original implementation, but a good exercise in understand why the
;; original works

;; Lets make a test file to compare results of the original implementation
;; with this one.
(define (mul-interval-cases x y)
  (define (interval-sign lower upper)
    (cond ((and (< lower 0) (< upper 0)) -1)
          ((and (>= lower 0) (>= upper 0)) 1)
          (else 0)))

  (let ((low-x (lower-bound x))
        (low-y (lower-bound y))
        (up-x (upper-bound x))
        (up-y (upper-bound y)))
    
    (define (sign-x) (interval-sign low-x up-x))
    (define (sign-y) (interval-sign low-y up-y))
    
    (cond ((and 
            (negative? (sign-x)) 
            (negative? (sign-y)))
           (make-interval (* low-x low-y) (* up-x up-y)))
          ((and 
            (positive? (sign-x))
            (positive? (sign-y)))
           (make-interval (* low-x low-y) (* up-x up-y)))
          ((and
            (negative? (sign-x))
            (zero? (sign-y)))
           (make-interval (* low-x up-y) (* low-x low-y)))
          ((and
            (negative? (sign-y))
            (zero? (sign-x)))
           (make-interval (* low-y up-x) (* up-y low-x)))
          ((and
            (negative? (sign-x))
            (positive? (sign-y)))
           (make-interval (* low-x up-y) (* up-x low-y)))
          ((and
            (negative? (sign-y))
            (positive? (sign-x)))
           (make-interval (* low-y up-x) (* up-y low-x)))
          ((and
            (zero? (sign-x))
            (positive? (sign-y)))
           (make-interval (* low-x up-y) (* up-x up-y)))
          ((and
            (zero? (sign-y))
            (positive? (sign-x)))
           (make-interval (* low-y up-x) (* up-y up-x)))
          (else
           (make-interval (min (* low-x up-y) (* low-y up-x))
                          (max (* up-x up-y) (* low-x low-y)))))))
        
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (add-interval x y)
  (make-interval
   (+ (lower-bound x) (lower-bound y))
   (+ (upper-bound x) (upper-bound y))))

;; The difference would be computed if:
;; i = x - y (this gives absolute value)
;; x = i + y (this accurately gives the first value)
;; y = x - i (this fails, since i is absolute, it gives a new interval that is not 

;; (define sub (sub-interval first second))
;; (add-interval second sub)
;; (sub-interval first sub)
;; This stasfies the rules of arithmetic given the add function
(define (sub-interval x y)
  (make-interval
   (- (lower-bound x) (upper-bound y))
   (- (upper-bound x) (lower-bound y))))

;; Exercise 2.10
;; What is a zero interval? (0 0), (0 a) (a 0)
(define (zero-interval? i)
  (or (= (lower-bound i) 0)
      (= (upper-bound i) 0)))

(define (div-interval x y)
  (if (zero-interval? y)
      #f
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y)) ;; this will be a lower value than the second value
                                   (/ 1.0 (lower-bound y))))))

;; Excercise 2.9 - The width of an interval
(define (width i)
  (average (upper-bound i) (lower-bound i)))

(define (combine-width x y f)
  (width (f x y)))

(define (add-width x y)
  (combine-width x y add-interval))

(define (sub-width x y)
  (combine-width x y sub-interval))

;; Multiply and division do not work. 
;;
;; eg: (combine-width interval interval2 mul-interval)
;; eg: (combine-width interval interval2 div-interval)
;; (width interval) = 6.8
;; (width interval2) = 5.3
;; (* 6.8 5.3) = 36.04
;; Using the above function: 36.3936
;; (/ 6.8 5.3) = 1.28301
;; For the above function: 1.3081999
;; The reason is how multiplicatin is calculated by multiplying points and taking the minimum and maximum values.
;; Therefore there is no guarantee that the multiplication of widths will equal the width of the multiplication of intervals.