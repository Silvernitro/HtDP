;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDP-6.1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Physical constants:
(define UFO-SPEED 3)
(define TANK-SPEED 3)
(define MISSILE-SPEED 6)
(define HEIGHT 100)
(define WIDTH 40)

;Graphical constants:
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define UFO-SPRITE (circle 7.5 "solid" "black"))
(define TANK-SPRITE (rectangle 20 10 "solid" "black"))
(define MISSILE-SPRITE (rectangle 2 5 "solid" "red"))



;Renders the starting scene:
(define scene (underlay/xy (underlay/xy BACKGROUND 12.5 0 UFO-SPRITE) 11 90 TANK-SPRITE))

;Data defintions:

;A UFO is a posn structure. (make-posn x y) represents the UFO's position.

(define-struct tank [loc vel])
;A Tank is a structure where loc is its x-position and vel is its velocity (pixels per tick).
;(make-tank number number)

;A missile is a posn structure. (make-posn x y) represents the missile's position.

(define-struct aim [ufo tank])
;Aim is a structure that represents the state of the game before a missile is fired.
;It only has to capture the states of the ufo (location) and tank (location and veloctiy).
;(make-aim UFO TANK)

(define-struct fired [ufo tank missile])
;Fired is a structure that represents the state of the game after a missile is fired.
;In addition to the states of the ufo and tank, it must also capture the location of the missile fired.
;(make-fired UFO TANK MISSILE)

;A SIGS (space invader game state) represents the world state of the game.
;It is an itemization that consists of one of the following:
;-(make-aim UFO TANK)
;-(make-fired UFO TANK MISSILE)

;SIGS -> Image
;Renders the state of the game. It includes the UFO-SPRITE, TANK-SPRITE, and optionally, a MISSILE-SPRITE.
(define (render-state gamestate)
  (cond[(aim? gamestate) (render-aim gamestate)]
       [(fired? gamestate) (render-fired gamestate)]
       [else ...]))


;Tank Image -> Image
;Renders tank onto a given background at the position given by Posn.
(define (render-tank tank background)
  (underlay/xy background (tank-loc tank) 90 TANK-SPRITE))

;Posn Image -> Image
;render missile onto a given background at the position given by Posn.
(define (render-missile missile background)
  (underlay/xy background (posn-x missile) (posn-y missile) MISSILE-SPRITE))

;Posn Image -> Image
;render ufo onto a given background at the position given by Posn.
(define (render-ufo ufo background)
  (underlay/xy background (posn-x ufo) (posn-y ufo) UFO-SPRITE))

;Aim/Fired -> Image
;Render an Aim structure onto BACKGROUND.
;This function can also accept a Fired structure as input. It will simply only render the ufo and tank.
(define (render-aim aim-in)
  (render-tank (cond [(aim? aim-in) (aim-tank aim-in)]
                     [(fired? aim-in) (fired-tank aim-in)])
   (render-ufo (cond [(aim? aim-in) (aim-ufo aim-in)]
                     [(fired? aim-in) (fired-ufo aim-in)])
               BACKGROUND)))

;Fired -> Image
;Render a Fired structure.
(define (render-fired fired-in)
  (render-missile (fired-missile fired-in) (render-aim fired-in)))

;gamestate -> Image
;Renders the ending scene after the worldstate halts.
(define (render-end gamestate)
   (overlay (text "game over" 8 "black") (render-aim gamestate)))

;gamestate -> Boolean
;Checks if the UFO has landed if the gamestate is still an Aim struct.
(define (aim-game-over? gamestate)
  (>= (posn-y (aim-ufo gamestate)) 85))

;gamestate -> Boolean
;Checks if the UFO has landed/collided with missile if the gamestate is a Fired struct.
(define (fired-game-over? gamestate)
  (or (>= (posn-y (fired-ufo gamestate)) 85)
      (and (or (>= (posn-x (fired-missile gamestate)) (- (posn-x (fired-ufo gamestate)) 2))
               (<= (posn-x (fired-missile gamestate)) (+ (posn-x (fired-ufo gamestate)) 15)))
           (or (>= (posn-y (fired-missile gamestate)) (- (posn-y (fired-ufo gamestate)) 5))
               (<= (posn-y (fired-missile gamestate)) (+ (posn-y (fired-ufo gamestate)) 15)))
           )))

;gamestate -> Boolean
;Checks if the game has ended.
(define (end? gamestate)
  (cond [(aim? gamestate) (aim-game-over? gamestate)]
        [(fired? gamestate) (fired-game-over? gamestate)]
    )
  )

;gamestate -> gamestate
;Takes in SIGS struct, moves the game objects, and returns a new SIGS struct with the new positions.
(define (sigs-move gamestate)
  (actual-move gamestate (random 5))
  )

;gamestate number -> gamestate
;This function does the actual moving of objects according to the delta input.
(define (actual-move gamestate delta)
  (cond [(aim? gamestate) (make-aim (change-ufo (aim-ufo gamestate) delta) (change-tank-loc (aim-tank gamestate)))]
        [(fired? gamestate) (make-fired (change-ufo (fired-ufo gamestate) delta) (change-tank-loc (fired-tank gamestate))
                                        (change-missile (fired-missile gamestate)))]
        )
  )

;Ufo (posn struct) number -> Ufo
;Changes the position of a ufo according to delta and returns a new ufo struct with the new coordinates.
(define (change-ufo ufo-in delta)
  (make-posn (+ (posn-x ufo-in) delta) (+ (posn-y ufo-in) UFO-SPEED))
  )

;Tank -> Tank
;Changes the position of a tank and returns a new tank struct with the new x-coordinate.
(define (change-tank-loc tank-in)
  (make-tank (+ (tank-loc tank-in) (tank-vel tank-in)) (tank-vel tank-in))
  )

;Missile (posn struct) -> Missile
;Changes the position of a missile and returns a new missile struct with the new y-coordinate.
(define (change-missile missile-in)
  (make-posn (posn-x missile-in) (+ (posn-y missile-in) MISSILE-SPEED))
  )

;Gamestate string -> Gamestate
;This is a keypress event handler. It modifies the gamestate accordingly and returns the new gamestate struct.
;It accepts "left", "right", and " " (spacebar) as keypress inputs.
(define (keyhandler gamestate keypress)
  (cond [(equal? keypress " ") (fire-missile gamestate)]
        [(equal? keypress "left") (change-tank-vel-left gamestate)]
        [(equal? keypress "right") (change-tank-vel-right gamestate)]
        )
  )

;Gamestate -> Gamestate
;Changes the direction of the tank when the left arrow key is pressed.
(define (change-tank-vel-left gamestate)
  (cond [(aim? gamestate)
          (if (negative? (tank-vel (aim-tank gamestate)))
       gamestate
      (make-aim (aim-ufo gamestate)
                (make-tank (tank-loc (aim-tank gamestate))
                           (- (tank-vel (aim-tank gamestate))))
           )
      )]
        [(fired? gamestate)
          (if (negative? (tank-vel (fired-tank gamestate)))
       gamestate
      (make-fired (fired-ufo gamestate)
                (make-tank (tank-loc (fired-tank gamestate))
                           (- (tank-vel (fired-tank gamestate))))
                (fired-missile gamestate)
           )
      )]
    )
  )

;Gamestate -> Gamestate
;Changes the direction of the tank when the right arrow key is pressed.
(define (change-tank-vel-right gamestate)
  (cond [(aim? gamestate)
          (if (positive? (tank-vel (aim-tank gamestate)))
       gamestate
      (make-aim (aim-ufo gamestate)
                (make-tank (tank-loc (aim-tank gamestate))
                           (- (tank-vel (aim-tank gamestate))))
           )
      )]
        [(fired? gamestate)
          (if (positive? (tank-vel (fired-tank gamestate)))
       gamestate
      (make-fired (fired-ufo gamestate)
                (make-tank (tank-loc (fired-tank gamestate))
                           (- (tank-vel (fired-tank gamestate))))
                (fired-missile gamestate)
           )
      )]
    )
  )

;Gamestate -> Gamestate
;Fires a missile when the spacebar is pressed.
(define (fire-missile gamestate)
  (cond [(aim? gamestate)
         (make-fired
          (aim-ufo gamestate)
          (aim-tank gamestate)
          (make-posn (tank-loc (aim-tank gamestate)) 90))
         ]
        [(fired? gamestate)
         (make-fired
          (fired-ufo gamestate)
          (fired-tank gamestate)
          (make-posn (tank-loc (fired-tank gamestate)) 90))
         ]
    )
  )

;Gamestate -> Gamestate
;Launches the main game's world program.
(define (main-game gamestate)
  (big-bang gamestate
    [to-draw render-state]
    [on-tick sigs-move 0.5]
    [on-key keyhandler]
    [stop-when end? render-end]
  ))

;FUNCTION WISHLIST

;FOR TESTING PURPOSES
(define ufo-1 (make-posn 5 5))
(define tank-1 (make-tank 3 3))
(define missile-1 (make-posn 3 4))
(define aim-1 (make-aim ufo-1 tank-1))
(define fired-1 (make-fired ufo-1 tank-1 missile-1))