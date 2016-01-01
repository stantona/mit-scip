;; Exercise 1.2.9 - Samson's Rule for Integrals
;;

(define (integral f a b n)

  (define (first-or-last? k)
    (or (= k 0) (= k n)))

  (define (x-position k h)
    (+ a (* k h)))
    
  (define (integral-iter h n-slice acc)

    (define (area-of-slice)
      (f (x-position n-slice h)))
    
    (define (next-n-slice)
      (+ n-slice 1))

    (define (multiplier)
      (cond ((first-or-last? n-slice) 1)
            ((even? n-slice) 2)
            (else 4)))

    (if (> n-slice n)
        acc
        (integral-iter
         h
         (next-n-slice)
         (+ acc (* (multiplier) (area-of-slice))))))
    
  (* (/ (/ (- b a) n) 3) (integral-iter (/ (- b a) n) 0 0)))
