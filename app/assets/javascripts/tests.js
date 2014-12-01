
jQuery(function ($) {
	$("a[data-remote]").on("ajax:success",function (e, xhr, status, error){
	    $('table').after(xhr);
	});

	$("a[data-remote]").on("ajax:error",function (e, xhr, status, error){
		var cr = $("tbody");
	});
	
		
});
