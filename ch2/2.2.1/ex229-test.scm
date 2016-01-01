(load "ex229.scm")
(load "../../test-helpers.scm")

;; Test data.
(define l-branch (make-branch 20 60))
(define r-branch (make-branch 20 (make-mobile (make-branch 5 45) (make-branch 15 15))))
(define expected-mobile (make-mobile l-branch r-branch))

(assert-true "Mobile should be balanced" (mobile-balanced? expected-mobile))
