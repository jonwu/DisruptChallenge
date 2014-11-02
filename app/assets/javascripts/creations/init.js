jQuery(document).ready(function($) {
	// initializeForm()
	titleListener()
	addQuestionListener();
});

function titleListener(){
	$('#category_title_input').keydown(function(evnt){
    if(evnt.keyCode === 13){
      $('#category_title_form').submit();
    }
  });
}

function initializeForm(){
	$.fn.wysihtml5.defaultOptions['toolbar']['image'] = false;
	console.log($.fn.wysihtml5.defaultOptions)
	$('.question-form').wysihtml5();

}

function addQuestionListener(){
	$(".add-question").click(function(event) {
		$.ajax({
			url: '/creations/check_question',
			type: 'POST',
			data: {"category": this.id},
		})
		.done(function() {
			$(".question-form").val('')
			console.log("success");
		})
		.fail(function() {
			console.log("error");
		})
		.always(function() {
			console.log("complete");
		});
		
	});
}