;; Basic assert
;; This could form the building blocks for more complex
;; asserts.
(define (assert predicate desc actual expected)
  (print "\n" desc "\n")
  (print "\nActual/Expected:\n")
  (pretty-print actual)
  (pretty-print expected)
  (if (predicate actual expected)
      (print "\nTest Passes\n")
      (print "\nTest Fails\n")))
