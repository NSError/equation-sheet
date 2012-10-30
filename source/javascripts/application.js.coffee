#= require jquery-1.8.2.js
#= require bootstrap-2.1.1.js
#= require raphael-2.1.0.js

# inspired by https://gist.github.com/1043360, but obviously has a few mods
# draws an arrow along the given vector
Raphael.fn.arrow= (x1, y1, x2, y2, size, sharpness=45) ->
  angle= Raphael.angle x1, y1, x2, y2
  this.arrow2 x2, y2, angle, size, sharpness
  #x2a= x2 + Math.cos(Raphael.rad(angle-sharpness)) * size
  #x2b= x2 + Math.cos(Raphael.rad(angle+sharpness)) * size
  #x2m= x2 - Math.cos(Raphael.rad(angle          )) * (size / 0.66) # the midpoint to get the
  #y2m= y2 - Math.sin(Raphael.rad(angle          )) * (size / 0.66) # broken pinched hypotenuse
  #y2a= y2 + Math.sin(Raphael.rad(angle-sharpness)) * size
  #y2b= y2 + Math.sin(Raphael.rad(angle+sharpness)) * size
  #this.path("M#{x2} #{y2} L#{x2a} #{y2a} L#{x2m} #{y2m} L#{x2b} #{y2b} Z").attr 'fill', 'black'
Raphael.fn.arrow2 = (x, y, angle, size, sharpness=45) ->
  xa = x + Math.cos(Raphael.rad(angle-sharpness)) * size
  xb = x + Math.cos(Raphael.rad(angle+sharpness)) * size
  xm = x - Math.cos(Raphael.rad(angle          )) * (size / 0.66)
  ya = y + Math.sin(Raphael.rad(angle-sharpness)) * size
  yb = y + Math.sin(Raphael.rad(angle+sharpness)) * size
  ym = y - Math.sin(Raphael.rad(angle          )) * (size / 0.66)
  console.log {
    origin:
      x: x
      y: y
    angle: angle
    size: size
    sharpness: sharpness
    a: 
      x: xa
      y: ya
    b:
      x: xb
      y: yb
    m:
      x: xm
      y: ym
  }

  this.path("M#{x},#{y}L#{xa},#{ya}L#{xm},#{ym}L#{xb},#{yb}Z").attr 'fill', 'black'

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
    evtHandler = (e) ->
      if e.target.parentNode.id == 'identity-formulae'
        $(document).off 'DOMNodeInserted', '#identity-formulae .MathJax_Display', evtHandler
        mathjax = $(e.target)
        h = $(trigDia).parent().height()
        bh = "#{h}px"
        lh = "#{h-parseInt($(mathjax).css('margin-top'))-parseInt($(mathjax).css('margin-bottom'))}px"
        $(identityFormulae).height bh
        $(identityFormulae).css 'line-height', lh
      else
        console.log 'other event triggered'
    $(document).on 'DOMNodeInserted', '#identity-formulae .MathJax_Display', evtHandler
    # yes, all that just to vertically align middle

    # wrap all objects into a list which will be transformed for scale at the end
    trigPaper.setStart()

    # circle and axes
    cx = 0.0
    cy = 0.0
    radius = 0.9
    dot = (x, y, fill='black') ->
      trigPaper.circle(x, y, 0.015).attr 'fill', fill
    trigPaper.circle cx, cy, radius
    dot(cx, cy)
    #trigPaper.circle(cx, cy, 0.015).attr 'fill', 'black'
    yAxis= trigPaper.path "M0,1L0,-1"
    trigPaper.arrow 0, 1, 0, -1, 0.03
    trigPaper.arrow 0, -1, 0, 1, 0.03
    xAxis= trigPaper.path "M-1,0L1,0"
    trigPaper.arrow -1, 0, 1, 0, 0.03
    trigPaper.arrow 1, 0, -1, 0, 0.03

    # ray segment line thingy - what, i've been two years since i was in a classroom!
    rAngle = Math.PI / 3.0 * -1.0#) * Math.PI / 4.0
    rx = cx + Math.cos(rAngle) * radius
    ry = cy + Math.sin(rAngle) * radius
    trigPaper.path "M0,0L#{rx},#{ry}"
    dot(rx, ry)

    # arc
    shortening = 0.66
    a = # beginning point on x axis
      x: cx + Math.cos(0.0) * (radius * shortening)
      y: cy + Math.sin(0.0) * (radius * shortening)
    b = # ending point on ray line
      x: cx + Math.cos(rAngle) * (radius * shortening)
      y: cy + Math.sin(rAngle) * (radius * shortening)
    trigPaper.path "M#{a.x},#{a.y}A#{radius * shortening},#{radius * shortening},0,0,0,#{b.x},#{b.y}"
    # arrow at the end of the arc
    arrowAngle = Math.cos(rAngle * 0.15)
    trigPaper.arrow2 b.x, b.y, arrowAngle, 0.02
    console.log "rAngle: #{rAngle}"
    console.log "arrowAngle: #{arrowAngle}"

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
