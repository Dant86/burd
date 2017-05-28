var bodyElement = $('body');
var navToggleBtn = bodyElement.find('nav-toggle-btn');
navToggleBtn.on('click',function(){
	bodyElement.toggleClass('active-nav');
	e.preventDefault();
});