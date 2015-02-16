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
    $("div.main-content").on('focusout', ".response-textarea", function(e) {
        // e.target gets the element that triggered event
        text = $(".response-textarea").val()
        save_response(text)
    });
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