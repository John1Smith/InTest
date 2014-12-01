// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
jQuery(function ($) {

   // Удаление вопроса и ответа
	$("body").on("ajax:success","a[data-remote]",function (e, xhr, status, error){

		if ($(this).attr("data-method")!=null && $(this).attr("data-method")=="delete") 
		{
			if ($(this).parent().parent(".answer-block").html()!=null)
			{
				var cr = $(this).parent();
				$(cr).fadeOut(200);
			}
			if ($(this).parent().parent(".question-block").html()!=null)
			{
				var cr = $(this).parent().parent();
				$(cr).fadeOut(200);
			}
			if ($(this).parent().html()!=null)
			{
				var cr = $(this).parent();
				$(cr).fadeOut(200);
			}
			

		
			
			
	    }
	});	

	
	$("#submit-button").on("click",function (){
		$(".question-block:hidden").remove();
		$(".one-answer:hidden").remove();		
	});	




		
});


