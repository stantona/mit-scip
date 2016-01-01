;; Exercise 1.34

(load "../../helpers.scm")

(define (f g)
  (g 2))

;; Returns 4
(f sqr)

;; Returns 8
(f cube)

;; Returns 3
(f 1+)

;; Returns an error (*** ERROR IN f, (console)@344.3 -- Operator is not a PROCEDURE)
(f f)

;; This can be explained by:
;; -> (f f)
;;   -> (g 2) (substituting g for 2)
;;   -> (2 2) -> error rased here.
