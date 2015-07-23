;; Exercise 2.49
;;
;; Implementation for the following painters:
;; Outline of designated frame
;; Draws and X
;; A diamond
;; A wave

(load "ex248.scm")
(load-option 'format)

;; Some test data, where should this go?
(define origin (make-vect 2 2))
(define edge-one (make-vect -1 2))
(define edge-two (make-vect 2 0.5))
(define a-frame (make-frame-v2 origin edge-one edge-two))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (draw-line end-point-a end-point-b)
  (display (format #f "~A --> ~A~%" end-point-a end-point-b))
  #t)

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

;; Primitive painter for drawing the outline of the frame
(define (painter->draw-frame-outline)
  (let ((side1 (make-segment (make-vect 0 0) (make-vect 1 0)))
        (side2 (make-segment (make-vect 0 0) (make-vect 0 1)))
        (side3 (make-segment (make-vect 1 0) (make-vect 1 1)))
        (side4 (make-segment (make-vect 0 1) (make-vect 1 1))))
    (segments->painter (list side1 side2 side3 side4))))

;; Draw an X in the frame
(define (painter->draw-x)
  (let ((line1 (make-segment (make-vect 0 0) (make-vect 1 1)))
        (line2 (make-segment (make-vect 1 0) (make-vect 0 1))))
    (segments->painter (list line1 line2))))

;; Draw a diamond
(define (painter->draw-diamond)
  (let ((line1 (make-segment (make-vect 0 0.5) (make-vect 0.5 1)))
        (line2 (make-segment (make-vect 0.5 1) (make-vect 1 0.5)))
        (line3 (make-segment (make-vect 1 0.5) (make-vect 0.5 0)))
        (line4 (make-segment (make-vect 0.5 0) (make-vect 0 0.5))))
    (segments->painter (list line1 line2 line3 line4))))

;; Draw the wave
;; (define (painter->draw-wave)
;;   (let ((left-foot (make-segment (make-vector 0 0.35) (make-vector 0 0.45)))
;;         (inner-left-leg (make-segment (make-vector 0 0.45) (make-vector 5 4)))
;;         (inner-right-leg (make-segment (make-vector

