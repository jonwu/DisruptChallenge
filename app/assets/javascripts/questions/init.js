var ready;
ready = function() {
  $('h2.header_question_title > .best_in_place').bind("ajax:success", function () {
    update_questions()
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);

function update_questions(){
  $.ajax({
    url: '/base/update_questions',
    type: 'GET',
    datatype: 'js',
  })
  .done(function() {
    // console.log("success");
  })
  .fail(function() {
    console.log("error");
  })
  .always(function() {
    console.log("complete");
  });
  
}