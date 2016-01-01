;; Exercise 2.53

;; Getting acquainted with atoms, or symbolic data as SCIP refers to.

(list 'a 'b 'c) ;=> (a b c)

(list (list 'george)) ;=> ((george))

(cdr '((x1 x2) (y1 y2))) ;=> ((y1 y2))

(cadr '((x1 x2) (y1 y2))) ;=> (y1 y2)

(pair? (car '(a short list))) ;=> #f

(car '(a short list)) ;=> a

(pair? 'a) ;=> #f

(memq 'red '((red shoes) (blue socks))) ;=> #f

(memq 'red '(red shoes blue socks)) ;=> (red shoes blue socks)

(memq 'blue '(red shoes blue socks)) ;=> (blue socks)



