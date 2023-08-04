;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders


;; Constants:

(define WIDTH  300)
(define HEIGHT 500)

(define INVADER-X-SPEED 1.5)  ;speeds (not velocities) in pixels per tick
(define INVADER-Y-SPEED 1.5)
(define TANK-SPEED 2)
(define MISSILE-SPEED 10)

(define HIT-RANGE 10)

(define INVADE-RATE 100)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")              ;cockpit cover
              -5 6
              (ellipse 20 10 "solid"   "blue")))            ;saucer

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ;tread center
                       (ellipse 30 10 "solid" "green"))     ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "black")       ;gun
                     (rectangle 20 10 "solid" "black"))))   ;main body

(define TANK-HEIGHT/2 (/ (image-height TANK) 2))

(define TANKY (- HEIGHT TANK-HEIGHT/2 10))

(define MISSILE (ellipse 5 15 "solid" "red"))



;; Data Definitions:

(define-struct game (invaders missiles tank))
;; Game is (make-game  (listof Invader) (listof Missile) Tank)
;; interp. the current state of a space invaders game
;;         with the current invaders, missiles and tank position

;; Game constants defined below Missile data definition

#;
(define (fn-for-game s)
  (... (fn-for-loinvader (game-invaders s))
       (fn-for-lom (game-missiles s))
       (fn-for-tank (game-tank s))))

(define-struct tank (x dir))
;; Tank is (make-tank Number Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir -1, right if dir 1

(define T0 (make-tank (/ WIDTH 2) 1))   ;center going right
(define T1 (make-tank 50 1))            ;going right
(define T2 (make-tank 50 -1))           ;going left

#;
(define (fn-for-tank t)
  (... (tank-x t) (tank-dir t)))

(define-struct invader (x y dx))
;; Invader is (make-invader Number Number Number)
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader along x by dx pixels per clock tick

(define I1 (make-invader 150 100 12))           ;not landed, moving right
(define I2 (make-invader 150 HEIGHT -10))       ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 10)) ;> landed, moving right

#;
(define (fn-for-invader invader)
  (... (invader-x invader) (invader-y invader) (invader-dx invader)))

(define-struct missile (x y))
;; Missile is (make-missile Number Number)
;; interp. the missile's location is x y in screen coordinates

(define M1 (make-missile 150 300))                       ;not hit U1
(define M2 (make-missile (invader-x I1) (+ (invader-y I1) 10)))  ;exactly hit U1
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ;> hit U1

#;
(define (fn-for-missile m)
  (... (missile-x m) (missile-y m)))



(define G0 (make-game empty empty T0))
(define G1 (make-game empty empty T1))
(define G2 (make-game (list I1) (list M1) T1))
(define G3 (make-game (list I1 I2) (list M1 M2) T1))

;; Functions

(define (main g)
  (big-bang g
    (on-tick tock)         ; Game -> Game
    (to-draw render)       ; Game -> Image
    (on-key handle-key)))  ; Game KeyEvent -> Game

;; Game -> Game
;; tock
;; !!!
(define (tock g) G0)

;; Game -> Image
;; render
(check-expect (render G0) (place-image TANK (tank-x T0) TANKY BACKGROUND))
(check-expect (render G2) (place-image TANK (tank-x T1) TANKY
                                       (place-image INVADER (invader-x I1) (invader-y I1)
                                                    (place-image MISSILE (missile-x M1) (missile-y M1) BACKGROUND))))
(check-expect (render G3)
              (place-image TANK (tank-x T1) TANKY
                           (place-image INVADER (invader-x I1) (invader-y I1)
                                        (place-image MISSILE (missile-x M1) (missile-y M1)
                                                     (place-image INVADER (invader-x I2) (invader-y I2)
                                                                  (place-image MISSILE (missile-x M2) (missile-y M2) BACKGROUND))))))

;(define (render g) empty-image)

(define (render g)
  (render-tank (game-tank g)
               (render-invaders (game-invaders g)
                                (render-missiles (game-missiles g) BACKGROUND))))

;; ListOfInvader Image -> Image
;; render list of invaders
(check-expect (render-invaders (list I1) BACKGROUND) (place-image INVADER (invader-x I1) (invader-y I1) BACKGROUND))
(check-expect (render-invaders (list I1 I2) BACKGROUND)
              (place-image INVADER (invader-x I1) (invader-y I1)
                           (place-image INVADER (invader-x I2) (invader-y I2) BACKGROUND)))
;(define (render-invaders loi img) empty-image)

(define (render-invaders loi img)
  (cond [(empty? loi) img]
        [else
         (place-image INVADER
                      (invader-x (first loi))
                      (invader-y (first loi))
                      (render-invaders (rest loi) img))]))

;; ListOfMissile Image -> Image
;; render list of missiles
(check-expect (render-missiles (list M1) BACKGROUND) (place-image MISSILE (missile-x M1) (missile-y M1) BACKGROUND))
(check-expect (render-missiles (list M1 M2) BACKGROUND)
              (place-image MISSILE (missile-x M1) (missile-y M1)
                           (place-image MISSILE (missile-x M2) (missile-y M2) BACKGROUND)))

;(define (render-missiles lom img) empty-image)

(define (render-missiles lom img)
  (cond [(empty? lom) img]
        [else
         (place-image MISSILE
                      (missile-x (first lom))
                      (missile-y (first lom))
                      (render-missiles (rest lom) img))]))

;; Tank Image -> Image
;; render tank
(check-expect (render-tank T0 BACKGROUND) (place-image TANK (tank-x T0) TANKY BACKGROUND))
(check-expect (render-tank T1 BACKGROUND) (place-image TANK (tank-x T1) TANKY BACKGROUND))

;(define (render-tank t img) empty-image)

(define (render-tank t img)
  (place-image TANK (tank-x t) TANKY img))

;; Game KeyEvent -> Game
;; change tank's direction when arrow keys are clicked
;; and shoot missiles when space key is pressed
;; !!!
(check-expect (handle-key G0 "a") G0)
(check-expect (handle-key G0 "left") (make-game empty empty (make-tank (tank-x T0) -1)))
(check-expect (handle-key G0 "right") (make-game empty empty (make-tank (tank-x T0) 1)))
(check-expect (handle-key (make-game empty empty (make-tank 20 -1)) "left")
              (make-game empty empty (make-tank 20 -1)))
(check-expect (handle-key (make-game empty empty (make-tank 20 -1)) "right")
              (make-game empty empty (make-tank 20 1)))

;(define (handle-key g key) G0)

(define (handle-key g key)
  (make-game (game-invaders g)
             (game-missiles g)
             (key-helper (game-tank g) key)))

;; Tank KeyEvent -> Tank
;; helper for handle-key

(check-expect (key-helper T0 "e") T0)
(check-expect (key-helper T0 "left") (make-tank (tank-x T0) -1))
(check-expect (key-helper T0 "right") (make-tank (tank-x T0) 1))

(define (key-helper t key)
  (cond [(key=? key "left") (make-tank (tank-x t) -1)]
        [(key=? key "right") (make-tank (tank-x t) 1)]
        [else t]))