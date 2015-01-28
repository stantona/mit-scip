;; Exercise 2.27

(define x (list (list 1 2) (list 3 4)))
;; ((1 2) (3 4))

;; The base problem is when the items is empty, in which 
;; case we return the new list.
;;
;; The secondary problem is taking the car of the list and
;; cons on to the new list. (This is the standard reverse).
;;
;; The tertiary problem is that elements that are lists must
;; also be reversed.
(define (deep-reverse items)
  (define (try-deep item)
    (if (not (list? item))
        item
        (iter item '())))

  (define (iter old new)
    (if (null? old)
        new
        (iter (cdr old)
              (cons (try-deep (car old)) new))))

  (iter items '()))
