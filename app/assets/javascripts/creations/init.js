$(document).ready(function(){
  $('#category_title_input').keydown(function(evnt){
    if(evnt.keyCode === 13){
      $('#category_title_form').submit();
    }
  });
});