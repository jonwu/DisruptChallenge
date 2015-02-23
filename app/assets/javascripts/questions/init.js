var ready;
ready = function() {
  $('.best_in_place').bind("ajax:success", function () {
    var id = $('.header_question_title').attr('data-id')
    // refresh the two sidebar layouts
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
