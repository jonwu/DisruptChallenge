// jQuery(document).ready(function($) {
//     $(document).pjax('a', '#pjax-container')
// });

$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
  $(document).pjax('a[questions-pjax]', '.main-content-pjax')
  $(document).pjax('a.category-pjax', '.questions-pjax')
});
