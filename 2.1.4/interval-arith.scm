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
;; This is a very gross implementation and I'm not sure why you
;; would chose this over the original. I'm assuming the exercise is
;; to fully understand how interval multiplication works.
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

;; Exercise 2.12 Create intervals using percentages
(define (make-center-percent c p)
  (let ((tolerance (* c (/ p 100))))
    (make-interval
     (- c tolerance)
     (+ c tolerance))))

(define (interval-center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

;; Apply some tests to this
;; This suffers from floating point inexactness
(define (interval-percent i)
  (let ((center (interval-center i)))
    (let ((tolerance (- (upper-bound i) center)))
      (* (/ tolerance center) 100))))

;; Exercise 2.13
;; The interval is defined by the center and the tolerance
;; Under the assumption of small percentage tolerances
;; Also for positve centers.

;;|----c1----|................|--c2--|
;; c1 = 2; c2 = 3
;; Lower bound
;; (c1 - c1t1)(c2 - c2t2)
;; (c1c2 - c1c2t2 - c1c2t1 + c1t1c2t2)
;; (c1c2 - (t2 + t1)c1c2 + c1t1c2t2)
;; c1c2(1 - (t2 + t1) + t1t2)

;; Upper bound
;; (c1 + c1t1)(c2 + c2t2)
;; (c1c2 + c1c2t1 + c1c2t2 + c1t1c2t2)
;; (c1c2 + (t1 + t2)c1c2 + c1t1c2t2)
;; c1c2(1 + (t1 + t2) + t1t2)
;;
;; For approximations, the c1c2t1t2 multiplication is not included.
;; As the exercise mentions, this only works for small percentages.
(define (mul-interval-percent a b)
  (make-center-percent
   (* (interval-center a) (interval-center b))
   (+ (interval-percent a) (interval-percent b))))

;; Exercise 2.14
;; =============

;; Two ways of calculating parallel resistors

(define (par1 r1 r2)
  (div-interval
   (mul-interval r1 r2)
   (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))
