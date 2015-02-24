var ready;
ready = function() {
  console.log("HELLOOO")
  $(document).pjax('a.category-pjax', '.questions-pjax')
};

$(document).ready(ready);
$(document).on('page:load', ready);