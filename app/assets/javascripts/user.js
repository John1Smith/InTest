$(document).ready(function() {
    $("#share_button").zclip({
        path: "ZeroClipboard.swf",
        copy: function(){
            return $(this).val();
        },
    	afterCopy: function(){
            $('#share_link').text('ссылка скопирована');
        }
    });


    // $("#share_button").on("click",function (){
		// console.log("click");
	// });	
});