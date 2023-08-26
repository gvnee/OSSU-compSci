;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname pluralize) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Problem: Design a function that pluralizes a given word. (Pluralize means to convert the word to its plural form.)
;For simplicity you may assume that just adding s is enough to pluralize a word.

;; String -> String
; pluralizes a given word

(check-expect (pluralize "cat") "cats")
(check-expect (pluralize "c") "cs")

; (define (pluralize s) "dummy") ;stub

;(define (pluralize s) ;template
;  (... s))

(define (pluralize s)
  (string-append s "s"))