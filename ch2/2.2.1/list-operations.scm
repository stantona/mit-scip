;; List Operations
(load "../../helpers.scm")

(define (list-ref-alt items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (1- n))))
  
(define (length-alt items)
  (define (length-iter a count)
    (if (null? a)
        count
        (length-iter (cdr a) (1+ count))))
  
  (length-iter items 0))

(define (append-alt list-a list-b)
  (if (null? list-a)
      list-b
      (cons (car list-a)
            (append-alt (cdr list-a) list-b))))

;; (1, 2, 3)
;; (4, 5)

;; (cons 1 (append-alt (2, 3) (4, 5)))
;; (cons 1 (cons 2 (append-alt (3), (4, 5))))
;; (cons 1 (cons 2 (cons 3 (append-alt (), (4, 5)))))
;; (cons 1 (cons 2 (cons 3 (4, 5))))
;; (cons 1 (cons 2 (3, 4, 5)))
;; (cons 1 (2, 3, 4, 5))
;; (1, 2, 3, 4, 5)
