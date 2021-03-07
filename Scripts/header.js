//This simple script handles the header nav menu modal
//also covered nav sub menu selection
//Dependencies: jQuery
$(document).ready(function () {

	$('.burger').click(function () {
		$('header').toggleClass('clicked');
		$('main').toggleClass('hidden');
		$('main').toggleClass('main');
		$('body').toggleClass('overflow');
	});

});