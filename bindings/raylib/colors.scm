(library (bindings raylib colors)
  (export
   red
   black
   light-salmon
   light-coral
   tomato
   light-yellow
   light-goldenrod-yellow
   chartreuse
   forest-green
   light-green
   light-cyan
   pale-turquoise
   turquoise
   medium-turquoise
   dark-turquoise
   light-sea-green
   cadet-blue
   teal
   light-blue
   light-sky-blue
   light-steel-blue
   steel-blue
   midnight-blue
   medium-slate-blue
   slate-blue
   dark-slate-blue
   thistle
   violet
   magenta
   blue-violet
   dark-violet
   dark-magenta
   light-pink
   hot-pink
   pale-violet-red
   medium-violet-red
   white
   mint-cream
   ghost-white
   white-smoke
   floral-white
   antique-white
   misty-rose
   light-gray
   light-slate-gray
   slate-gray
   dark-slate-gray
   navajo-white
   wheat
   taupe
   chocolate)
  (import (chezscheme)
	  (lib futils)
	  (bindings raylib bindings))

  
  (define antique-white (fptr-init Color (r 250) (g 235) (b 215) (a 255)))
  (define black (fptr-init Color (r 0) (g 0) (b 0) (a 255)))
  (define blue-violet (fptr-init Color (r 138) (g 43) (b 226) (a 255)))
  (define cadet-blue (fptr-init Color (r 95) (g 158) (b 160) (a 255)))
  (define chartreuse (fptr-init Color (r 127) (g 255) (b 0) (a 255)))
  (define chocolate (fptr-init Color (r 210) (g 105) (b 30) (a 255)))
  (define dark-magenta (fptr-init Color (r 139) (g 0) (b 139) (a 255)))
  (define dark-slate-blue (fptr-init Color (r 72) (g 61) (b 139) (a 255)))
  (define dark-slate-gray (fptr-init Color (r 47) (g 79) (b 79) (a 255)))
  (define dark-turquoise (fptr-init Color (r 0) (g 206) (b 209) (a 255)))
  (define dark-violet (fptr-init Color (r 148) (g 0) (b 211) (a 255)))
  (define floral-white (fptr-init Color (r 255) (g 250) (b 240) (a 255)))
  (define forest-green (fptr-init Color (r 34) (g 139) (b 34) (a 255)))
  (define ghost-white (fptr-init Color (r 248) (g 248) (b 255) (a 255)))
  (define hot-pink (fptr-init Color (r 255) (g 105) (b 180) (a 255)))
  (define light-blue (fptr-init Color (r 173) (g 216) (b 230) (a 255)))
  (define light-coral (fptr-init Color (r 240) (g 128) (b 128) (a 255)))
  (define light-cyan (fptr-init Color (r 224) (g 255) (b 255) (a 255)))
  (define light-goldenrod-yellow (fptr-init Color (r 250) (g 250) (b 210) (a 255)))
  (define light-gray (fptr-init Color (r 211) (g 211) (b 211) (a 255)))
  (define light-green (fptr-init Color (r 144) (g 238) (b 144) (a 255)))
  (define light-pink (fptr-init Color (r 255) (g 182) (b 193) (a 255)))
  (define light-salmon (fptr-init Color (r 255) (g 160) (b 122) (a 255)))
  (define light-sea-green (fptr-init Color (r 32) (g 178) (b 170) (a 255)))
  (define light-sky-blue (fptr-init Color (r 135) (g 206) (b 250) (a 255)))
  (define light-slate-gray (fptr-init Color (r 119) (g 136) (b 153) (a 255)))
  (define light-steel-blue (fptr-init Color (r 176) (g 196) (b 222) (a 255)))
  (define light-yellow (fptr-init Color (r 255) (g 255) (b 224) (a 255)))
  (define magenta (fptr-init Color (r 255) (g 0) (b 255) (a 255)))
  (define medium-slate-blue (fptr-init Color (r 123) (g 104) (b 238) (a 255)))
  (define medium-turquoise (fptr-init Color (r 72) (g 209) (b 204) (a 255)))
  (define medium-violet-red (fptr-init Color (r 199) (g 21) (b 133) (a 255)))
  (define midnight-blue (fptr-init Color (r 25) (g 25) (b 112) (a 255)))
  (define mint-cream (fptr-init Color (r 245) (g 255) (b 250) (a 255)))
  (define misty-rose (fptr-init Color (r 255) (g 228) (b 225) (a 255)))
  (define navajo-white (fptr-init Color (r 255) (g 222) (b 173) (a 255)))
  (define pale-turquoise (fptr-init Color (r 175) (g 238) (b 238) (a 255)))
  (define pale-violet-red (fptr-init Color (r 219) (g 112) (b 147) (a 255)))
  (define slate-blue (fptr-init Color (r 106) (g 90) (b 205) (a 255)))
  (define slate-gray (fptr-init Color (r 112) (g 128) (b 144) (a 255)))
  (define steel-blue (fptr-init Color (r 70) (g 130) (b 180) (a 255)))
  (define taupe (fptr-init Color (r 210) (g 180) (b 140) (a 255)))
  (define teal (fptr-init Color (r 0) (g 128) (b 128) (a 255)))
  (define thistle (fptr-init Color (r 216) (g 191) (b 216) (a 255)))
  (define tomato (fptr-init Color (r 255) (g 99) (b 71) (a 255)))
  (define turquoise (fptr-init Color (r 64) (g 224) (b 208) (a 255)))
  (define violet (fptr-init Color (r 238) (g 130) (b 238) (a 255)))
  (define wheat (fptr-init Color (r 245) (g 222) (b 179) (a 255)))
  (define white (fptr-init Color (r 255) (g 255) (b 255) (a 255)))
  (define white-smoke (fptr-init Color (r 245) (g 245) (b 245) (a 255)))
  (define red (fptr-init Color (r 255) (g 0) (b 0) (a 255))))
