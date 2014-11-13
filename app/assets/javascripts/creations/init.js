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
		text = $.trim($('.question-form').val())
		if(text){
		  saveQuestions(text)
		}
		return false
	});
}

function saveQuestions(text){
	$.ajax({
		url: '/creations/add_question',
		type: 'POST',
		data: {"text": text, "qual": true, "quant": true, "impact": "high"},
	}).done(function() {
		$(".question-form").val('')
		$('body').animate({ scrollTop: $('body')[0].scrollHeight}, 500);
		console.log("success");
	}).fail(function() {
		console.log("error");
	}).always(function() {
		console.log("complete");
	});
}