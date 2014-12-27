jQuery(document).ready(function($) {
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

function addQuestionListener(){
	$(".add-question").click(function(event) {
		text = $.trim($('.question-form').val())
		if(text){
			impact = $(".impact .active").text()
			saveQuestions(text, impact)
		}
		return false
	});
}

function saveQuestions(text, impact){
	$.ajax({
		url: '/creations/add_question',
		type: 'POST',
		data: {"text": text, "qual": true, "quant": true, "impact": impact},
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