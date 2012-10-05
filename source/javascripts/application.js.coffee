#= require jquery-1.8.2.js
#= require bootstrap-2.1.1.js
#= require raphael-2.1.0.js

# inspired by https://gist.github.com/1043360, but obviously has a few mods
# draws an arrow along the given vector
Raphael.fn.arrow= (x1, y1, x2, y2, size, sharpness=45) ->
  angle= Raphael.angle x1, y1, x2, y2
  x2a= x2 + Math.cos(Raphael.rad(angle-sharpness)) * size
  x2b= x2 + Math.cos(Raphael.rad(angle+sharpness)) * size
  x2m= x2 - Math.cos(Raphael.rad(angle          )) * (size / 0.66) # the midpoint to get the
  y2m= y2 - Math.sin(Raphael.rad(angle          )) * (size / 0.66) # broken pinched hypotenuse
  y2a= y2 + Math.sin(Raphael.rad(angle-sharpness)) * size
  y2b= y2 + Math.sin(Raphael.rad(angle+sharpness)) * size
  this.path("M#{x2} #{y2} L#{x2a} #{y2a} L#{x2m} #{y2m} L#{x2b} #{y2b} Z").attr 'fill', 'black'

$(document).ready ->
  aspectRatio= 4/3

  ( -> # trig diagram
    trigDia= $('#trig-dia')
    # control the diagram size with the division constant
    trigDia.desiredHeight= (1/aspectRatio * trigDia.width()) / 1.44
    trigPaper= Raphael "trig-dia", trigDia.width(), trigDia.desiredHeight
    # handle some vertical-centering issues with the equations to the 
    # right of the diagram
    identityFormulae= $('#identity-formulae')
    $(identityFormulae).height $(trigDia).parent().height()
    intervalId= window.setInterval( ->
      mathjaxendisp= $(identityFormulae).children('.MathJax_Display:not(.MathJax_Processed)')
      if mathjaxendisp.size() > 0
        window.clearInterval intervalId
        $(mathjaxendisp).css 'margin-top', "-#{$(mathjaxendisp).height() * 0.5}px"
    , 250)
    # yes, all that just to vertically align middle

    # wrap all objects into a list which will be transformed for scale at the end
    trigPaper.setStart()

    # circle and axes
    trigPaper.circle 0, 0, 0.9
    trigPaper.circle(0, 0, 0.015).attr 'fill', 'black'
    yAxis= trigPaper.path "M0,1L0,-1"
    trigPaper.arrow 0, 1, 0, -1, 0.03
    trigPaper.arrow 0, -1, 0, 1, 0.03
    xAxis= trigPaper.path "M-1,0L1,0"
    trigPaper.arrow -1, 0, 1, 0, 0.03
    trigPaper.arrow 1, 0, -1, 0, 0.03


    # scale that sucker up - this way we can work with a circle with r=1 instead
    # of doing funky maths by hand, which would suck majorly
    scale= Math.min trigPaper.width/2-40, trigPaper.height/2-40
    tx= "t#{trigPaper.width/2-2},#{trigPaper.height/2-2}s#{scale},#{scale},0,0"
    trigPaper.setFinish().transform tx
  )()

  ( -> # unit circle
    unitCirc= $('#unit-circ')
    unitCirc.desiredHeight= 1/aspectRatio * unitCirc.width()
    unitCircPaper= Raphael 'unit-circ', unitCirc.width(), unitCirc.desiredHeight
  )()
