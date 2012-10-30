# Calculus Equation Sheet

> Because literally every equation sheet I got in college sucked,
> I made a better one.

* Clean, concise layout. If you're not familiar with the mathematics,
  this won't make a lick of sense - and it's not supposed to.
* Trig fits on just one page.
* Calc 101A fits on just one page (101B material forthcoming... when I
  finally take that course!)

# That's all nice, but...

* I'm aware that it's rather incomplete
* I'll accept pull-requests to complete or correct it

# But it's in this ancient format!

Latex is not ancient! OK, so it is. How to get around this?

* All you need is a working LaTeX distribution! So, MacTex (with
  TeXLive) or some equivalent. Specifically:
  * `latex` to convert LaTeX to dvi. I'm not exactly sure what dvi is,
    but it's an intermediate step and I'm sticking with it.
  * `dvips` to convert div to post-script. You could theoretically
    take that post-script and load it into any PS-compatible printer
    (most of the good ones are). But I'm a GUI-spoiled child, and I love
    my portable document files - so the other two steps are for that.
  * `ps2pdf` to convert the post-script to a PDF!
* If you're inherently lazy (like me), then you'll want working Ruby
  1.8.7 or better with the Rake command.
  * Just run `rake` to build the PDF!
  * Run `rake clean` to get rid of the intermediates!

# In the future...

* I'm planning to write some funny pre-processors to generate the
  diagrams with controllable inputs. That'd be super-cool.
* I'm planning on continuing my education, at which point this little
  resource will get updated and expanded.

# Legal

Licensed [FDOSL 0.1](http://fsdev.net/fdosl). Use for good and not evil,
please!
