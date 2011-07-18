/**
 * Written by the hand of Chris Miller circa July 2011.
 * Please feel free to do whatever. Just don't sue me.
 */

function drawDiagrams() {
	drawTrigDiagram();
	drawUnitCircleDiagram();
}

function makeArrow(context, x, y, r) {
	context.save();
	context.translate(x, y);
	context.rotate(r);
	
	context.beginPath();
	context.moveTo( 0.0, 0.0);
	context.lineTo(-3.0, 7.0);
	context.lineTo( 0.0, 5.0);
	context.lineTo( 3.0, 7.0);
	context.lineTo( 0.0, 0.0);
	context.closePath();
	context.fill();
	
	context.restore();
}

function makeDot(context, x, y, r) {
	context.save();
	context.translate(x, y);

	context.beginPath();
	context.arc(0.0,
		0.0,
		r,
		0.0,
		Math.PI*2.0,
		false);
	context.closePath();
	context.fill();
	
	context.restore();
}

function drawUnitCircleDiagram() {
	var unitCircleDiagram = document.getElementById('unit-circle-diagram');
	var unitCircleContext = unitCircleDiagram.getContext("2d");
	var unitCircleCx = 110.0; // centre-x
	var unitCircleCy = 110.0; // centre-y
	var unitCircleCr = 70.0; // radius
	var unitCircleCg = 40.0; // gutter
	
	{ // circle
		unitCircleContext.beginPath();
		unitCircleContext.arc(
			unitCircleCx,
			unitCircleCy,
			unitCircleCr,
			0.0,
			Math.PI*2.0,
			false);
		unitCircleContext.closePath();
		unitCircleContext.stroke();
	}
	
	{ // y-axis
		unitCircleContext.beginPath();
		unitCircleContext.moveTo(unitCircleCx,unitCircleCy+unitCircleCr+unitCircleCg-2.0);
		unitCircleContext.lineTo(unitCircleCx, 2.0);
		unitCircleContext.closePath();
		unitCircleContext.stroke();
		// y-axis top arrowhead
		makeArrow(unitCircleContext, unitCircleCx, 0.0, 0.0);
		// y-axis bottom arrowhead
		makeArrow(unitCircleContext, unitCircleCx, unitCircleCy+unitCircleCr+unitCircleCg,Math.PI);
	}
	
	{ // x-axis
		unitCircleContext.beginPath();
		unitCircleContext.moveTo(2.0, unitCircleCy);
		unitCircleContext.lineTo(unitCircleCx+unitCircleCr+unitCircleCg, unitCircleCy);
		unitCircleContext.closePath();
		unitCircleContext.stroke();
		// x-axis left arrowhead
		makeArrow(unitCircleContext, 0.0, unitCircleCy, 1.5*Math.PI);
		// x-axis right arrowhead
		makeArrow(unitCircleContext, unitCircleCx+unitCircleCr+unitCircleCg, unitCircleCy, Math.PI/2.0);
	}
	
	unitCircleContext.save();
	unitCircleContext.translate(unitCircleCx, unitCircleCy);
	
	var points = [
		0.0,
		Math.PI/6.0,
		Math.PI/4.0,
		Math.PI/3.0,
		Math.PI/2.0,
		2.0/3.0*Math.PI,
		3.0/4.0*Math.PI,
		5.0/6.0*Math.PI,
		Math.PI
	];
	
	var szPi=String.fromCharCode(0x3c0);
	var labels = [
		"0",
		szPi+"/6",
		szPi+"/4",
		szPi+"/3",
		szPi+"/2",
		"2"+szPi+"/3",
		"3"+szPi+"/4",
		"5"+szPi+"/6",
		szPi
	]
	
	var labelsYDelta = [
		7.0,
		7.0,
		7.0,
		7.0,
		7.0,
		5.0,
		0.0,
		-5.0,
		5.0
	]
	
	for (var i in points) {
		points[i] = points[i]+Math.PI/2.0;
	}
	
	unitCircleContext.font = "Italic 16pt Serif"
	
	for (var i in points) {
		makeDot(unitCircleContext,
			Math.sin(points[i])*unitCircleCr,
			Math.cos(points[i])*unitCircleCr,
			3.0);
		if (i <= 4) {
			unitCircleContext.fillText(
				labels[i],
				Math.sin(points[i])*unitCircleCr+7.0,
				Math.cos(points[i])*unitCircleCr-labelsYDelta[i]);
		} else {
			unitCircleContext.fillText(
				labels[i],
				Math.sin(points[i])*unitCircleCr-unitCircleContext.measureText(labels[i]).width-7.0,
				Math.cos(points[i])*unitCircleCr-labelsYDelta[i]);
		}
	}
	
	unitCircleContext.restore();
}

function drawTrigDiagram() {
	var trig_diagram = document.getElementById('trig-diagram');
	var trigContext = trig_diagram.getContext("2d");
	var trigCx = 90.0; // centre-x
	var trigCy = 90.0; // centre-y
	var trigCr = 80.0; // radius
	var trigCg = 10.0; // gutter
	var trigCircleRadius = 80.0;
	var trigCircleGutter = 10.0;
	
	{ // circle
		trigContext.beginPath();
		trigContext.arc(trigCx,trigCy,trigCr,0.0,Math.PI*2.0,false);
		trigContext.closePath();
		trigContext.stroke();
	}
	
	{ // y-axis
		trigContext.beginPath();
		trigContext.moveTo(trigCx,trigCy+trigCr+trigCg-2.0);
		trigContext.lineTo(trigCx,2.0);
		trigContext.closePath();
		trigContext.stroke();
		// y-axis top arrowhead
		makeArrow(trigContext, trigCx, 0.0, 0.0);
		// y-axis bottom arrowhead
		makeArrow(trigContext, trigCx, trigCy+trigCr+trigCg,Math.PI);
	}
	
	{ // x-axis
		trigContext.beginPath();
		trigContext.moveTo(2.0,trigCy);
		trigContext.lineTo(trigCx+trigCr+trigCg-2.0,trigCy);
		trigContext.closePath();
		trigContext.stroke();
		// x-axis left arrowhead
		makeArrow(trigContext, 0.0, trigCy, 1.5*Math.PI);
		// x-axis right arrowhead
		makeArrow(trigContext, trigCx+trigCr+trigCg, trigCy, Math.PI/2.0);
	}
	
	{ // radius line
		trigContext.beginPath();
		trigContext.moveTo(trigCx,trigCy);
		trigContext.lineTo(
			trigCx+(Math.cos(Math.PI+3.0*Math.PI/4.0)*trigCr),
			trigCy+(Math.sin(Math.PI+3.0*Math.PI/4.0)*trigCr));
		trigContext.closePath();
		trigContext.stroke();
		// radius point
		makeDot(trigContext,
			trigCx+(Math.cos(Math.PI+3.0*Math.PI/4.0)*trigCr),
			trigCy+(Math.sin(Math.PI+3.0*Math.PI/4.0)*trigCr),
			3.0);
	}
	
	{ // angle arc
		var angleR = 1.5;
		trigContext.beginPath();
		trigContext.arc(
			trigCx,
			trigCy,
			trigCr/angleR,
			Math.PI+2.0*Math.PI/2.0,
			Math.PI+3.0*Math.PI/4.0,
			true);
		trigContext.moveTo(
			trigCx+(Math.cos(Math.PI+3.0*Math.PI/4.0)*trigCr/angleR),
			trigCy+(Math.sin(Math.PI+3.0*Math.PI/4.0)*trigCr/angleR));
		trigContext.closePath();
		trigContext.stroke();
		// angle arc arrow
		makeArrow(
			trigContext,
			trigCx+(Math.cos(Math.PI+3.0*Math.PI/4.0)*trigCr/angleR),
			trigCy+(Math.sin(Math.PI+3.0*Math.PI/4.0)*trigCr/angleR),
			1.77*Math.PI
			);
	}
	
	{ // text
		trigContext.save();
		trigContext.font = "Italic 16pt Serif"
		trigContext.fillText(
			String.fromCharCode(0x3b8),
			trigCx+25.0,
			trigCy-5.0);
		trigContext.fillText(
			"r",
			trigCx+(Math.cos(Math.PI+3.0*Math.PI/4.0)*trigCr/1.75)-trigContext.measureText("r").width-7.0,
			trigCy+(Math.sin(Math.PI+3.0*Math.PI/4.0)*trigCr/1.75)-7.0);
		trigContext.fillText(
			"(x, y)",
			trigCx+(Math.cos(Math.PI+3.0*Math.PI/4.0)*trigCr)-10.0,
			trigCy+(Math.sin(Math.PI+3.0*Math.PI/4.0)*trigCr)-15.0);
		trigContext.restore();
	}
}