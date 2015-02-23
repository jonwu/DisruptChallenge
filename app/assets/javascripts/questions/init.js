var ready;
ready = function() {
  $('h2.header_question_title > .best_in_place').bind("ajax:success", function () {
    update_questions()
  });

  $(document).pjax('a[questions-pjax]', '.main-content-pjax')
  // if ($.support.pjax) {
  //   $(document).on('click', 'a[data-pjax]', function(event) {
  //     var container = $('.main-content, .pjax-container')
  //     $.pjax.click(event, {container: container})
  //   })
  // }
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

jQuery(document).ready(function($) {
  toggleActive()
});

function toggleActive(){
  //Prevent double listeners
  $("#questions .list-group-item").unbind('click');
  // alert(1);
  $("#questions .list-group-item").click(function(event) {
    $('#questions .active').removeClass('active');
    $(this).addClass('active');
  });
}