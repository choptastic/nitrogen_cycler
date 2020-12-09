function init_cycler(id, images, linger) {
	var iterator = 0;

	setInterval(function() {
		if(iterator > images.length) {
			iterator=0;
		}else{
			iterator++;
		}
		
		var next_image = images[iterator];
		var next_selector = iterator%2==0 ? ".cycler_face img" : ".cycler_back img";
		document.querySelector(next_selector).src=next_image;
		obj(id).classList.toggle("cycler_flipped");
	}, linger);
}
