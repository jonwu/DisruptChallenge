$(document).ready(function() {
	$('.submissions').click(function(event) {
		
		$(this).appendTo('#question-content .col-sm-8')
		$('.submissions').not(this).each(function(){
        	$(this).appendTo('#question-content .col-sm-4')
        	
     	});

     
	});
});