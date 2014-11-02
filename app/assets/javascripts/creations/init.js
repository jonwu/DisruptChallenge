jQuery(document).ready(function($) {
	// initializeForm()
	titleListener()
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
function tabListener(){
	$('.categories ul li').click(function (e) {
		// $('.active').removeClass('active')
		// $(this).addClass('active')
	})	
}
