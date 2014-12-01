jQuery(function ($) {

	 $('.q-block input').prettyCheckable();

	test_type = $("#h1-test").attr('test_type');
	if (test_type==2)
	{

		$('.q-text').css({   
			"float": "left",
			"width": "36%",
			"line-height": "1.5em",
			"padding-right": "5px" 
		});


		$('.q-text2').css({   
		  	"font-size": "18px",
		  	"width": "auto",
		  	"line-height": "1.5em",
		});

		$('.answer-block').css({  
			 "margin-top": "23px", 
		});

		$('.clearfix').css({   
			 "margin-right": "3px",
		});

		$('.prettyradio label').css({  
			  "display": "block",
			  "float": "left",
			  "cursor": "pointer",
		     "margin-top": "-20px",
		     "margin-left": "-20px"
		});



	}
});


