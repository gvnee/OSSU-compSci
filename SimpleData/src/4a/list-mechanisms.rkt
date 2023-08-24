;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname list-mechanisms) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

empty ;empty list

(cons "item" empty)                        ;a list of 1 element
(cons "another item" (cons "item" empty)) ;a list of 2 elements

(define L1 (cons "a list item" empty))
(define L2 (cons "a list item" (cons "another item" empty)))

(first L1)

(first (rest L2))

(empty? L1)