function removeListenerOnPageChange(){$(document).on("page:change",function(){$(document).unbind("mouseup")})}function clickListenerOutsidePanel(){$("#wrapper").click(function(e){var n=$(".panel-content");n.is(e.target)||0!==n.has(e.target).length||(text=$(".response-textarea").val(),collapseContent(text))})}function collapseContent(e){$.ajax({url:"/responses/collapse_content",type:"POST",data:{text:e}}).done(function(){}).fail(function(){console.log("error")}).always(function(){console.log("complete")})}function initTextArea(){$.fn.wysihtml5.defaultOptions.toolbar.image,$.fn.wysihtml5.defaultOptions,$(".response-textarea").wysihtml5()}jQuery(document).ready(function(){clickListenerOutsidePanel()});