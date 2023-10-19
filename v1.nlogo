globals [ max-fishes ]  ; don't let the fish population grow too large

breed [ fishes fish ]  ; two breeds fishes and turtles

breed [ tortues tortue ]

fishes-own [ stress ]       ; fishes have caracteristic which is stress

patches-own [ path ] ;  last time a dish was on this patch

to setup
  clear-all
  set max-fishes 1500 ; max number of fish

  ask patches [ set pcolor blue ] ; bleu background to simulate see


  create-fishes initial-number-fishes  ; create the fish, then initialize their variables
  [
    set shape  "fish"
    set color red
    set size 1
    set label-color yellow ; color of label: stress
    set stress 0
    setxy random-xcor random-ycor
  ]

  create-tortues initial-number-tortues  ; create the tortues, then initialize their variables
  [
    set shape "turtle"
    set color green
    set size 1.5 ; easier to see (bigger in size for graphic purpose)
    setxy random-xcor random-ycor
  ]
  ask patches [set path 0]
  display-labels
  reset-ticks
end

to go
  if count fishes > max-fishes [ user-message "The fishes have inherited the earth" stop ] ;end of the simulation if there are too many fishes
  if not any? fishes [ user-message "Fishes stressed out" stop ] ; end of the simulation when there is no more fish
  ask fishes [
    if stress < 5 [reproduce-fishes]  ; if fishes are not stressed too much they can try to reproduce
    ; Check for nearby fish in the same direction
    let nearby-fish one-of other fishes with [stress > 5]  in-cone 5 45; Exclude itself with 'other'
    if nearby-fish != nobody and distance nearby-fish > 0 [
      ; Calculate the direction towards the nearby fish
      let towards-fish towards nearby-fish
      ; Move in the direction of the nearby fish
      set heading towards-fish
      fd 1

      if model-version = "fishes-behavior-analyzer" [ask patch-here [ set path 20 ]]
    ]
    ifelse count tortues in-radius 4 > 0 [set stress stress + 1] [if stress > 0 [set stress stress - 1]] ; if there is a tortue whithin a radius of 4, the fish gets 15 points of stress otherwise he loses 1 point
    death ;we try to see if the fish is to die
  ]
  ask tortues [
    ;move
    let nearby-fishes fishes in-radius 2
    if any? nearby-fishes [
      ask nearby-fishes [
        ; Calculate the direction towards the tortue
        let toward-tortue towards one-of tortues
        ; Calculate the direction away from the tortue
        let away-from-tortue (toward-tortue + 180) mod 360
        ; Move in the opposite direction away from the tortue
        rt random-float 10 - 5 + away-from-tortue
        fd 1

      ]
;        ; Calculate the direction towards a nearby fish
;      let nearby-fish one-of fishes in-radius 2
;      if nearby-fish != nobody [
;      let towards-fish towards nearby-fish
;      set heading towards-fish ; Turn the tortue towards the fish
;      ]
    ]
    move
    if model-version = "turtles-behavior-analyzer" [ask patch-here [ set path 20 ]]
;    ask patch-here [ set pcolor blue ]
  ]
  change-patch-color
  ask patches [set path path - 1]
  tick
  display-labels
end

to change-patch-color
  ask patches [
    if path = 20 [set pcolor 26]
    if path < 20 [set pcolor 28]
    if path < 10 [set pcolor 29]
    if path < 1  [set pcolor blue]
  ]
end

to move  ; turtle procedure
  let nb_tortues (count fishes in-cone 2 90)
  let direction "forwards"

  lt 90
  let new_nb_tortues (count fishes in-cone 2 90)
  if new_nb_tortues > nb_tortues
  [
    set direction "left"
    set nb_tortues new_nb_tortues
  ]

  lt 90
  set new_nb_tortues (count fishes in-cone 2 90)
  if new_nb_tortues > nb_tortues
  [
    set direction "backwards"
    set nb_tortues new_nb_tortues
  ]

  lt 90
  set new_nb_tortues (count fishes in-cone 2 90)
  if new_nb_tortues > nb_tortues
  [
    set direction "right"
    set nb_tortues new_nb_tortues
  ]

  lt 90 ;return to original facing
  lt random 50
  rt random 50
  if direction = "left" [lt 90]
  if direction = "backwards"[lt 180]
  if direction = "right" [rt 90]
  fd 1
end


to reproduce-fishes  ; fishes reproduce
  if random-float 100 < fish-reproduce [  ; throw "dice" to see if you will reproduce depending of the choosen rate in interface
    set stress 10                ; set the stress back for the newborn (max stress)
    hatch 1 [ rt random-float 360 fd 1 ]   ; hatch an offspring and move it forward 1 step
  ]
end

to death  ; fishes death
  if stress > 21 [ die ] ; if the fish is stressed too much it will die
end


to display-labels
  ask turtles [ set label "" ]
  if show-stress? [ ; display or not the stress of each fish
    ask fishes [ set label round stress ]
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
395
10
1179
795
-1
-1
15.22
1
14
1
1
1
0
1
1
1
-25
25
-25
25
1
1
1
ticks
30.0

SLIDER
20
130
194
163
initial-number-fishes
initial-number-fishes
0
250
150.0
1
1
NIL
HORIZONTAL

SLIDER
20
170
194
203
fish-reproduce
fish-reproduce
1.0
20.0
4.0
1.0
1
%
HORIZONTAL

SLIDER
200
130
365
163
initial-number-tortues
initial-number-tortues
0
250
33.0
1
1
NIL
HORIZONTAL

BUTTON
125
215
194
248
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
200
215
270
248
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

PLOT
25
310
365
600
populations
time
pop.
0.0
100.0
0.0
100.0
true
true
"" ""
PENS
"fishes" 1.0 0 -612749 true "" "plot count fishes"
"tortues" 1.0 0 -16449023 true "" "plot count tortues"

MONITOR
120
255
195
304
fishes
count fishes
3
1
12

MONITOR
199
255
274
304
tortues
count tortues
3
1
12

SWITCH
200
170
365
203
show-stress?
show-stress?
0
1
-1000

TEXTBOX
25
30
385
60
Testing fishes stress with turtles\n
24
33.0
1

CHOOSER
100
80
287
125
model-version
model-version
"fishes-behavior-analyzer" "turtles-behavior-analyzer"
0

@#$#@#$#@
## WHAT IS IT?

This model simulates the interaction between two types of agents: fishes and tortoises. The fishes have a characteristic called "stress," and the population of fishes is limited to prevent it from growing too large. The fishes move around in a simulated sea environment, interact with each other and the tortoises, and can reproduce under certain conditions. The stress level of fishes is affected by the presence of tortoises in their vicinity, and when fishes are too stressed, they may die. The behavior of the tortoises is to move and interact with nearby fishes.

## HOW IT WORKS

This model consists of two breeds: "fishes" and "tortoises." Fishes have a characteristic called "stress." The simulation is set in a sea environment represented by blue patches.

The model initializes by creating an initial population of fishes and tortoises on random patches in the sea. Fishes are represented by red fish shapes, and tortoises are represented by green turtle shapes.

The behavior of fishes includes movement, reproduction, and stress management. They may reproduce if their stress is below a certain threshold, and they are more stressed if there are tortoises in their vicinity. Fishes can also die if their stress level exceeds a critical value.

The tortoises' behavior involves moving and interacting with nearby fishes.

## HOW TO USE IT

1. Set the maximum number of fishes using the "max-fishes" global variable.
2. Press the "Setup" button to initialize the simulation with the specified parameters.
3. Press the "Go" button to start the simulation.
4. Observe the behaviors of fishes and tortoises in the sea environment.
5. Monitor the stress levels of fishes if the "show-stress?" option is enabled.

### Parameters:

- **max-fishes**: The maximum number of fishes allowed in the simulation.
- **initial-number-fishes**: The initial number of fishes in the simulation.
- **initial-number-tortoises**: The initial number of tortoises in the simulation.
- **fish-reproduce**: The probability of a fish reproducing at each time step.
- **show-stress?**: Whether or not to display the stress levels of fishes as labels.

## THINGS TO NOTICE

- Observe how the fish population fluctuates and how it is affected by the presence of tortoises.
- Pay attention to the stress levels of fishes and how they change based on the proximity of tortoises.
- The simulation may stop if the fish population becomes too large or if there are no more fishes left.

## THINGS TO TRY

- Experiment with different parameter values to see how they affect the stability and behavior of the ecosystem.
- Observe the impact of changing the "max-fishes" limit on the simulation's outcome.
- Analyze the interaction patterns between fishes and tortoises and how they influence stress levels.

## EXTENDING THE MODEL

- You can extend the model by introducing additional behaviors for fishes and tortoises.
- Modify the reproduction rules or stress calculations to explore different scenarios.
- Implement new features such as fish migration, predation, or territorial behavior.

## NETLOGO FEATURES

- This model uses breeds to define two types of agents: fishes and tortoises.
- It employs patches to represent the sea environment.


## CREDITS AND REFERENCES

Author: Antoine Porte and Antoine Neyra

## HOW TO CITE

If you mention this model or the NetLogo software in a publication, we ask that you include the citation below:

For the model itself:

* Antoine Porte and Antoine Neyra (2023).  NetLogo Fish Turtles Ecosystem model. https://github.com/Antoine005/netlogo ENSC, Bordeaux INP, FRANCE.

Please cite the NetLogo software as:

* Wilensky, U. (1999). NetLogo. http://ccl.northwestern.edu/netlogo/. Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.2
@#$#@#$#@
set model-version "sheep-wolves-grass"
set show-energy? false
setup
repeat 75 [ go ]
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
1
@#$#@#$#@
