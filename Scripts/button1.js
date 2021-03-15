//This simple script handles the header nav menu modal
//also covered nav sub menu selection
//Dependencies: jQuery
$(document).ready(function () {

	$('.boton1').click(function () {
		$('.desc').toggleClass('hidden');
		$('.botonIcono').toggleClass('fa-caret-down');
		$('.botonIcono').toggleClass('fa-caret-up');
		
	});

});