var ready;
ready = function() {
  onTextAreaFocusOut()
};

$(document).ready(ready);
$(document).on('page:load', ready);

/**
 * Click listener for out of rating input
 * @return {void} 
 */
function onTextAreaFocusOut(){
    // Delegation pattern. Submissions is guaranteed to exist. Ajax listener will still work.
    $("div.main-content").bindWithDelay("keyup", ".response-textarea", function(){
      text = $(".response-textarea").val()
      save_response(text)
    }, 250);
}

function save_response(text){
  $.ajax({
    url: '/responses/save_response',
    type: 'POST',
    data: {"text": text},
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