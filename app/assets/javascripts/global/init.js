// jQuery(document).ready(function($) {
//     $(document).pjax('a', '#pjax-container')
// });

$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
  // $(document).pjax('[data-pjax] a, a[data-pjax]', '.pjax-container')
  toggleActive()
  
});

function toggleActive(){
  $('#questions').on('click', ".list-group-item", function(event) {
    $('#questions .active').removeClass('active');
    $(this).addClass('active');
  });
}

