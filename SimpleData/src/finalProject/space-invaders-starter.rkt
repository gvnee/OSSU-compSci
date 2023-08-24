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

(define INVADERH/2 (/ (image-height INVADER) 2))
(define INVADERW/2 (/ (image-width INVADER) 2))


(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ;tread center
                       (ellipse 30 10 "solid" "green"))     ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "black")       ;gun
                     (rectangle 20 10 "solid" "black"))))   ;main body

(define TANKW/2 (/ (image-width TANK) 2))

(define TANK-HEIGHT/2 (/ (image-height TANK) 2))

(define TANKY (- HEIGHT TANK-HEIGHT/2 10))

(define MISSILE (ellipse 5 15 "solid" "red"))

(define MISSILEW/2 (/ (image-width MISSILE) 2))
(define MISSILEH/2 (/ (image-height MISSILE) 2))

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

(define I1 (make-invader 150 100 1))           ;not landed, moving right
(define I2 (make-invader 150 HEIGHT -1))       ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 1)) ;> landed, moving right

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

(define-struct coords (x1 y1 x2 y2))
;; Coords is (make-coords Natural Natural Natural Natural)
;; interp. top right (x1 y1) and bottom left (x2 y2) coordinates of a image

#;
(define (fn-for-coords c)
  (... (coords-x1 c)
       (coords-y1 c)
       (coords-x2 c)
       (coords-y2 c)))

(define C0 (make-coords 0 0 0 0))
(define C1 (make-coords 5 1 2 4))

;; Functions

(define (main g)
  (big-bang g
    (on-tick tock)         ; Game -> Game
    (to-draw render)       ; Game -> Image
    (on-key handle-key)  ; Game KeyEvent -> Game
    (stop-when stop?)))

;; Game -> Game
;; tock
;(define (tock g) G0)

(define (tock g)
  (filter (advance-game g)))

;; Game -> Game
;; filter out collided invaders and missiles

(define (filter g)
  (make-game (filter-invaders (game-invaders g) (game-missiles g))
             (filter-missiles (game-invaders g) (game-missiles g))
             (game-tank g)))

;; Game -> Game
;; advance game state

(define (advance-game g)
  (make-game (next-invaders (game-invaders g))
             (next-missiles (game-missiles g))
             (next-tank (game-tank g))))

;; ListOfInvader ListOfMissile -> ListOfInvader
;; filter out invaders that got hit

(define (filter-invaders loi lom)
  (cond [(empty? loi) empty]
        [(got-hit? (first loi) lom) (filter-invaders (rest loi) lom)]
        [else
         (cons (first loi) (filter-invaders (rest loi) lom))]))

;; ListOfInvader ListOfMissile -> ListOfMissile
;; filter out missiles that hit invader

(define (filter-missiles loi lom)
  (cond [(empty? lom) empty]
        [(hit-invader? loi (first lom)) (filter-missiles loi (rest lom))]
        [else
         (cons (first lom) (filter-missiles loi (rest lom)))]))

;; Invader ListOfMissile -> Boolean

(define (got-hit? i lom)
  (cond [(empty? lom) false]
        [(intersects? (invader->coords i) (missile->coords (first lom))) true]
        [else
         (got-hit? i (rest lom))]))

;; ListOfInvader Missile -> Boolean

(define (hit-invader? loi m)
  (cond [(empty? loi) false]
        [(intersects? (invader->coords (first loi)) (missile->coords m)) true]
        [else
         (hit-invader? (rest loi) m)]))

;; Next-invaders
;; advance invaders and randomly spawn a invader

(define (next-invaders loi)
  (if (= 1 (random INVADE-RATE))
      (cons (make-invader (random WIDTH) 0 (random-sign 1)) (advance-invaders loi))
      (advance-invaders loi)))

;; ListOfInvader -> ListOfInvader
;; advance invaders
;(define (next-invaders loi) empty)

(check-expect (advance-invaders empty) empty)
;(check-expect (advance-invaders (list I1)) (list (next-invader I1)))
;(check-expect (advance-invaders (list I1 I2)) (list (next-invader I1) (next-invader I2)))

(define (advance-invaders loi)
  (cond [(empty? loi) empty]
        [else
         (cons (next-invader (first loi))
               (advance-invaders (rest loi)))]))

;; Invader -> Invader
;; advance invaders location
(check-expect (next-invader (make-invader 0 0 1)) (make-invader (add1 INVADERW/2) INVADER-Y-SPEED 1))
(check-expect (next-invader (make-invader 200 200 1)) (make-invader (+ 200 INVADER-X-SPEED) (+ 200 INVADER-Y-SPEED) 1))
(check-expect (next-invader (make-invader WIDTH 0 1)) (make-invader (sub1 (- WIDTH INVADERW/2)) INVADER-Y-SPEED -1))

;(define (next-invaderi) I1)

(define (next-invader i)
  (cond [(< (invader-x i) INVADERW/2)
         (make-invader (add1 INVADERW/2)
                       (+ (invader-y i) INVADER-Y-SPEED) 1)]
        [(> (invader-x i) (- WIDTH INVADERW/2))
         (make-invader (sub1 (- WIDTH INVADERW/2))
                       (+ (invader-y i) INVADER-Y-SPEED) -1)]
        [else (make-invader (+ (invader-x i) (* (invader-dx i) INVADER-X-SPEED))
                            (+ (invader-y i) INVADER-Y-SPEED) (invader-dx i))]))

;; Game -> Boolean

(define (stop? g)
  (stop-helper (game-invaders g)))

;; ListOfInvader -> Boolean

(define (stop-helper loi)
  (cond [(empty? loi) false]
        [(invader-bottom? (first loi)) true]
        [else
         (stop-helper (rest loi))]))

;; Invader -> Boolean

(define (invader-bottom? i)
  (>= (+ (invader-y i) INVADERH/2) HEIGHT))

;; Invader -> Boolean

;; Number -> Number
;; return either given number or opposite of that number randomly

(define (random-sign n)
  (if (= 0 (random 2))
      n (- n)))

;; ListOfMissilse -> ListOfMissile
;; return next missiles, remove a missile of it is out of sight
(check-expect (next-missiles empty) empty)
(check-expect (next-missiles (list M1)) (list (next-missile M1)))
(check-expect (next-missiles (list M1 M2)) (list (next-missile M1) (next-missile M2)))
(check-expect (next-missiles (list M1 (make-missile 0 -100))) (list (next-missile M1)))
(check-expect (next-missiles (list M1 (make-missile 0 (- MISSILEH/2)))) (list (next-missile M1)))

;(define (next-missiles lom) empty)

(define (next-missiles lom)
  (cond [(empty? lom) empty]
        [(missile-out? (first lom)) (next-missiles (rest lom))]
        [else
         (cons
          (next-missile (first lom))
          (next-missiles (rest lom)))]))

;; Coords Coords -> Boolean
;; determine whether two coordinates intersect

;(define (intersects? c1 c2) false)

(define (intersects? c1 c2)
  (and (>= (coords-x1 c1) (coords-x2 c2))
       (<= (coords-x2 c1) (coords-x1 c2))
       (<= (coords-y1 c1) (coords-y2 c2))
       (>= (coords-y2 c1) (coords-y1 c2))))

;; Missile -> Coords
;; convert missile to coordinate

; (define (missile->coords m) C0)

(define (missile->coords m)
  (make-coords (+ (missile-x m) MISSILEW/2)
               (- (missile-y m) MISSILEH/2)
               (- (missile-x m) MISSILEW/2)
               (+ (missile-y m) MISSILEH/2)))

;; Invader -> Coords
;; convert invader to coordinate

; (define (invader->coords m) C0)

(define (invader->coords m)
  (make-coords (+ (invader-x m) INVADERW/2)
               (- (invader-y m) INVADERH/2)
               (- (invader-x m) INVADERW/2)
               (+ (invader-y m) INVADERH/2)))

;; Missile -> Boolean
;; check whether missile is out of sight
(check-expect (missile-out? M1) false)
(check-expect (missile-out? (make-missile 0 -100)) true)
(check-expect (missile-out? (make-missile 0 (- MISSILEH/2))) true)

;(define (missile-out? m) false)

(define (missile-out? m)
  (<= (missile-y m) (- MISSILEH/2)))

;; Missile -> Missile
(check-expect (next-missile (make-missile 0 HEIGHT)) (make-missile 0 (- HEIGHT MISSILE-SPEED)))
(check-expect (next-missile (make-missile 10 100)) (make-missile 10 (- 100 MISSILE-SPEED)))

;(define (next-missile m) M1)

(define (next-missile m)
  (make-missile (missile-x m) (- (missile-y m) MISSILE-SPEED)))

;; Tank -> Tank
(check-expect (next-tank T0) (make-tank (+ TANK-SPEED (tank-x T0)) (tank-dir T0)))
(check-expect (next-tank (make-tank 0 -1)) (make-tank (add1 TANKW/2) 1))
(check-expect (next-tank (make-tank 0  1)) (make-tank (add1 TANKW/2) 1))
(check-expect (next-tank (make-tank WIDTH 1)) (make-tank (sub1 (- WIDTH TANKW/2)) -1))

;(define (next-tank t) T0)

(define (next-tank t)
  (cond [(< (tank-x t) TANKW/2) (make-tank (add1 TANKW/2) 1)]
        [(> (tank-x t) (- WIDTH TANKW/2)) (make-tank (sub1 (- WIDTH TANKW/2)) -1)]
        [else (make-tank (+ (* (tank-dir t) TANK-SPEED) (tank-x t)) (tank-dir t))]))

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
(check-expect (handle-key G0 "a") G0)
(check-expect (handle-key G0 "left") (make-game empty empty (make-tank (tank-x T0) -1)))
(check-expect (handle-key G0 "right") (make-game empty empty (make-tank (tank-x T0) 1)))
(check-expect (handle-key (make-game empty empty (make-tank 20 -1)) "left")
              (make-game empty empty (make-tank 20 -1)))
(check-expect (handle-key (make-game empty empty (make-tank 20 -1)) "right")
              (make-game empty empty (make-tank 20 1)))

(check-expect (handle-key G0 " ") (make-game empty (list (make-missile (tank-x T0) (- TANKY 20))) T0))
(check-expect (handle-key G2 " ") (make-game (game-invaders G2)
                                             (cons (make-missile (tank-x T1) (- TANKY 20)) (game-missiles G2))
                                             T1))

;(define (handle-key g key) G0)

(define (handle-key g key)
  (make-game (game-invaders g)
             (shoot-missile (game-missiles g) (game-tank g) key)
             (change-direction (game-tank g) key)))

;; Tank KeyEvent -> Tank
;; change tank's direction if left or right arrows are clicked 
(check-expect (change-direction T0 "e") T0)
(check-expect (change-direction T0 "left") (make-tank (tank-x T0) -1))
(check-expect (change-direction T0 "right") (make-tank (tank-x T0) 1))

(define (change-direction t key)
  (cond [(key=? key "left") (make-tank (tank-x t) -1)]
        [(key=? key "right") (make-tank (tank-x t) 1)]
        [else t]))

;; ListOfMissile Tank KeyEvent -> ListOfMissile
;; add new missile if " " is clicked
(check-expect (shoot-missile empty T0 "a") empty)
(check-expect (shoot-missile empty T0 " ") (list (make-missile (tank-x T0) (- TANKY 20))))
(check-expect (shoot-missile (list M1) T0 " ") (cons (make-missile (tank-x T0) (- TANKY 20)) (list M1)))

;(define (shoot-missile lom t key) empty)

(define (shoot-missile lom t key)
  (cond [(key=? key " ") (cons (make-missile (tank-x t) (- TANKY 20)) lom)]
        [else lom]))