;; Exercise 2.28
;; What is the performance of this function?

(define (fringe list)
  (define (iter x new)
    (if (null? x)
        new
        (let ((first (car x)))
          (if (list? first)
              (append (iter first new) (iter (cdr x) new))
              (cons first (iter (cdr x) new))))))

  (trace iter)
  (iter list '()))
          
(fringe '())

(fringe '(1 2 3))

(fringe (list (list 1 2 3) (list 3 2 1) 3 5 (list 2 3) 6 9))

;; deeper binary tree
(fringe (list (list (list 1 2 3 19 283 38) 2 3 2) (list 2 3 (list 217 382 1827) 2 187 (list 2838)) 2 1 2 (list 2 (list 3 (list 3)) 23 2 1 238)))

