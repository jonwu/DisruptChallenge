$(document).ready(function() {
  initBestInPlace()
  initPjax()
  toggleQuestionActive()
  toggleCategoryActive()
  initFormValidation()
});

function initBestInPlace(){
  jQuery(".best_in_place").best_in_place();
}

/**
 * Initializes Pjax behavior in sidebars containers.
 */
function initPjax() {
  // both types of attributes go to main-content container
  $(document).pjax('a[question-pjax]', '.main-content-pjax')
  $(document).pjax('a.question-pjax', '.main-content-pjax')
  $(document).pjax('a.category-pjax', '.questions-pjax')
}

function initFormValidation() {
  $('#new_rfi_form').validate({
    rules: {
      "rfi_title": {required: true},
    }
  });
}

function toggleQuestionActive(){
  $('#questions').on('click', ".list-group-item", function(event) {
    $('#questions .active').removeClass('active');
    $(this).addClass('active');
  });
}

function toggleCategoryActive(){
  $('#categories').on('click', ".list-group-item", function(event) {
    $('#categories .active').removeClass('active');
    $(this).addClass('active');
  });
}

