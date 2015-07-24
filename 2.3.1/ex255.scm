;; Exercise 2.55 (car ''abracadabra)

(car ''abracadabra) #=> quote

''abracadabra #=> (quote abracadabra)

'abracadabra #= produces an atom (symbol)

;; The quote generates an atom. Another quote prefixed with an atom generates a list, where the first element is a quote, and the
;; second element is an atom, abracadabra.

;; To make it clearer, ''abracadabra is the same as:
(quote (quote abracadabra))

;; This is the same as
'(quote abracadabra)

;; So therefore:
(car '(quote abracadabra))

;; The interpretor takes the "quote" and expands it like (quote abracadabra)
