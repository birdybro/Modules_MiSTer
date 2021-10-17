/*
  Canvas 2D version of an XY oscilloscope (real time scatterplot). 
  Goal performance: 5µs point processing time at 60Hz. 
  That's about 3.3k points per frame. 

  Next steps: Measure performance drawing 3400 random points.
  Make it read from a pipe of some sort (websocket?). 
  Make a translator that we can pipe into. 
  Why am I not doing this sort of thing in puredata?
  
  
*/

var width=1024, height=1024;
var imageData, ctx, frame=0;

function renderonce(event) {
    requestAnimationFrame( render );
}
var lastCalledTime, fps;
function renderloop(now) {
    if (render(now))  // Let render() decide if we finished.
	requestAnimationFrame( renderloop );
}

function render(now) {
    //    var now = Date.now()
    var delta;
    if(!lastCalledTime) {
	lastCalledTime = now;
	fps = 0;
	delta = 1e6;
    } else {
	delta = (now - lastCalledTime)/1000;
	lastCalledTime = now;
	fps = /*frame*/1/delta;
    }
    
    // Decay hack
    // This isn't nearly as good as an age based exponential falloff.
    // It produces the faint trace effect of digital emulated
    // phosphorous. Still, might be good enough for the moment.
    var alpha = 1-Math.exp(-5*delta);
    ctx.fillStyle = 'rgba(0,0,0,'+alpha+')';
    ctx.fillRect(0,0,width,height);

    // Plot colour
    ctx.fillStyle = 'rgba(255,255,255,1)';
    for (var i=0; i<5400; i++) {
	var x = Math.floor(Math.random()*width);
	var y = Math.floor(Math.random()*height);
	ctx.fillRect(x,y,1,1);
	/*
	var s = Math.floor(Math.sin(x/100)*height/2+height/2);
	var miny = Math.max(s-5,0), maxy=Math.min(s+5,height);
	for (var y=miny; y<maxy; y++) {
	    var pi = (y*width+x)*4;
	    imageData.data.fill(255, pi+0, pi+3);
	    //imageData.data[pi+3] = 0;
	}
	*/
    }
    //    ctx.putImageData(imageData, 0, 0);

    if (++frame==width) {
	frame=0;
	ctx.font = "48px serif";
	ctx.fillText(fps, width/3, height/3);
	return false;
    }
    return true;
}

function startrenderloop(event) {
    requestAnimationFrame( renderloop );
}

function start(canvasid) {
    canvas = document.getElementById(canvasid);
    if (!canvas.getContext) {
	alert("Canvas doesn't support contexts?");
	return;
    }
    canvas.onclick = startrenderloop;
    ctx = canvas.getContext("2d");
    /*
    imageData = ctx.createImageData(width,height);

    // TODO: Generate new points per frame

    imageData.data.fill(0);
    for (var pi = 3; pi < width*height*4; pi+=4)
	imageData.data[pi]=255;  // opaque
    ctx.putImageData(imageData, 0, 0);
    */

//    renderloop();
}

