;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname sort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ListOfNumber -> ListOfNumber
;; sort numbers in ascending order
(check-expect (sort empty) empty)
(check-expect (sort (list 1)) (list 1))
(check-expect (sort (list 2 1)) (list 1 2))
(check-expect (sort (list 3 2 1)) (list 1 2 3))
(check-expect (sort (list 4 1 3 2)) (list 1 2 3 4))

; (define (sort lst) empty)

(define (sort lst)
  (cond [(empty? lst) empty]
        [else
         (insert (first lst) (sort (rest lst)))]))

;; Number ListOfNumber -> ListOfNumber
;; insert a number into a sorted list
(check-expect (insert 1 empty) (list 1))
(check-expect (insert 1 (list 1 1 1 1 1 1 1)) (list 1 1 1 1 1 1 1 1))
(check-expect (insert 1 (list 2 3)) (list 1 2 3))
(check-expect (insert 2 (list 1 3)) (list 1 2 3))
(check-expect (insert 3 (list 1 2)) (list 1 2 3))

;(define (insert n lst) empty)

(define (insert n lst)
  (cond [(empty? lst) (list n)]
        [else
         (if (> n (first lst))
             (cons (first lst) (insert n (rest lst)))
             (cons n lst))]))

(sort (list 5 4 3 2 45 1 23 48))