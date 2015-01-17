// jQuery(document).ready(function($) {
// 	$(document).pjax('a', '#pjax-container')
// });

jQuery(document).ready(function($) {
    onTextAreaFocusOut()
});

/**
 * Click listener for out of rating input
 * @return {void} 
 */
function onTextAreaFocusOut(){
    alert(3)
    // Delegation pattern. Submissions is guaranteed to exist. Ajax listener will still work.
    $("div.main-content").on('focusout', ".response-textarea", function(e) {
        alert(1)
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