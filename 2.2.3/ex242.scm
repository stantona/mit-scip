(load "../helpers.scm")

(define (queens board-size)
  (define empty-board '())

  (define (adjoin-position row col rest-of-queens)
    (cons (cons row col) rest-of-queens))
    
  (define (row position)
    (car position))

  (define (col position)
    (cdr position))

  (define (diagonal? a b)
    (= (abs (- (row a) (row b))) 
       (abs (- (col a) (col b)))))

  (define (intersect? a b)
    (or (= (row a) (row b)) 
        (diagonal? a b)))
               
  (define (safe? positions)
    (define (safe-position? queen rest-of-queens)
      (cond ((null? rest-of-queens) #t)
            ((intersect? queen (car rest-of-queens)) #f)
            (else 
             (safe-position? queen (cdr rest-of-queens)))))

      (safe-position? (car positions) (cdr positions)))

  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (1- k))))))
  (queen-cols board-size))
