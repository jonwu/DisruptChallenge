


jQuery(document).ready(function($) {
    clickListenerOutsidePanel()
    // removeListenerOnPageChange()
    
});

function removeListenerOnPageChange(){
    $(document).on('page:change', function () {
        $(document).unbind('mouseup')
    });
}
/**
 * Click listener that is not response-panel
 * @return {void} 
 */
function clickListenerOutsidePanel(){
    $('#wrapper').click(function(e) {
        var container = $(".panel-content");

        if (!container.is(e.target) // if the target of the click isn't the container...
              && container.has(e.target).length === 0) // ... nor a descendant of the container
        {
            text = $(".response-textarea").val()
            collapseContent(text)
        }
    });
}


function collapseContent(text){
  $.ajax({
    url: '/responses/collapse_content',
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
/**
 * Initialize textarea
 * @return {void} 
 */
function initTextArea(){
  $.fn.wysihtml5.defaultOptions['toolbar']['image']
  $.fn.wysihtml5.defaultOptions
  $('.response-textarea').wysihtml5();       
}