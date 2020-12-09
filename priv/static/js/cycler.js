function init_cycler_flip(id, images, linger) {
	var iterator = 0;

	setInterval(function() {
		if(++iterator >= images.length) {
			iterator=0;
		}

		var next_image = images[iterator];
		var next_selector = iterator%2==0 ? ".cycler_face img" : ".cycler_back img";
		var next_selector = ".wfid_" + id + " " + next_selector;

		document.querySelector(next_selector).src=next_image;
		
		obj(id).classList.toggle("cycler_flipped");
	}, linger);
}

function init_cycler_blink(id, images, linger, speed) {
	var iterator = 0;

	setInterval(function() {
		if(++iterator >= images.length) {
			iterator=0;
		}
		//console.log(iterator);
		var next_image = images[iterator];
	
		var next_selector = ".wfid_" + id + " .cycler_face img";
		document.querySelector(next_selector).src=next_image;
//		$(next_selector)
//			.hide({effect: "slide", speed: speed/2})
//			.next()
//			.prop("src", next_image)
//			.next()
//			.show({effect: "slide", speed: speed/2})
//			.end();

//		document.querySelector(next_selector).src=next_image;
//		
//		obj(id).classList.toggle("cycler_flipped");
	}, linger);
}
