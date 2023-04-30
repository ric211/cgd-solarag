/*
	Navigation
*/

var burger = document.querySelector(".navbar-burger");
var menu = document.querySelector("#" + burger.dataset.target);
burger.addEventListener('click', function () {
	burger.classList.toggle('is-active');
	menu.classList.toggle('is-active');
});


/*
	Bilder Vollbild
*/
const fullscreenImg = document.getElementById('full-img');

fullscreenImg.addEventListener('click', () => {
	if(screenfull.isEnabled) {
		screenfull.toggle(fullscreenImg);
	}
});

