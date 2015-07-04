;; Exercise 2.47
;;
;; Provide two selector implementations for frames based on the data representations given.

(load "ex246.scm")

(define (make-frame-v1 origin edge1 edge2)
  (list origin edge1 edge2))

(define (make-frame-v2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame frame)
  (car frame))

(define (frame-edges frame)
  (cdr frame))

(define (frame-edge-a frame)
  (car (frame-edges frame)))

(define (frame-edge-b-v1 frame)
  (cadr (frame-edges frame)))

(define (frame-edge-b-v2 frame)
  (cdr (frame-edges frame)))

(define edge1-frame frame-edge-a)
(define edge2-frame frame-edge-b-v2)

;; Test variables.
(define test-origin (make-vect -3 3))
(define test-edge1 (make-vect -2 3))
(define test-edge2 (make-vect 3 6))

(define frame-a (make-frame-v1 test-origin test-edge1 test-edge2))
(define frame-b (make-frame-v2 test-origin test-edge1 test-edge2))


(define (run-tests)
  (define (test op)
    (if (equal? (op frame-a) (op frame-b))
        'pass
        'fail))

  (define (test-output desc op)
    (display (string-append desc ":\t"))
    (display (test op))
    (newline))
  
  (display "---- Testing ----\n")
  (test-output "Origin values equality" origin-frame)
  (test-output "frame-edge-a equality" frame-edge-a)

  (display "frame-edge-b equality:\t")
  (display (if (equal? (frame-edge-b-v1 frame-a) (frame-edge-b-v2 frame-b))
               'pass
               'fail))
  #t)
                
