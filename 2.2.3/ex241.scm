;; Exercise 2.41
;;

(load "../helpers.scm")

(define (sum-triplets n s)

  (define (equal? triplet)
    (= (cadr triplet) s))

  (define (build-triplet-with-sum i j k)
    (list (list i j k) (+ i j k)))

  (flatmap (lambda(k)
             (flatmap (lambda(j)
                        (filter equal? 
                                (map (lambda(i) (build-triplet-with-sum i j k))
                                     (enumerate-interval 1 (1- j)))))
                      (enumerate-interval 1 (1- k))))
           (enumerate-interval 1 n)))
           
                  
                         

