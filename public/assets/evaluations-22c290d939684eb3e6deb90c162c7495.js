jQuery(document).ready(function($) {
    numericInputListener()
    clickListenerOutsideInput()
});

function numericInputListener() {
    // TODO: Can pull from a max range value
    max_range = 10

    // Prevent copy and paste
    $('.submissions').on('cut copy paste', 'input.response-rating', function(e) {
      e.preventDefault();
    });

    // Restrict numeric values only
    $('.submissions').on('keydown', 'input.response-rating', function(e) {
        // Exception for backspace and delete
        if (e.keyCode == 8 || e.keyCode == 46) {
            return true;
        }
        var key = e.keyCode ? e.keyCode : e.which;
        var rating = $(e.target).val()
        // Doesn't allow for non integer values and if the value pushes the input greater than the max allowed.
        if (rating * max_range + parseInt(String.fromCharCode(key)) > max_range || isNaN( String.fromCharCode(key) )) {
            return false;
        }
    });
}

/**
 * Click listener for out of rating input
 * @return {void} 
 */
function clickListenerOutsideInput(){
    // Delegation pattern. Submissions is guaranteed to exist. Ajax listener will still work.
    $(".submissions").on('focusout', "input.response-rating", function(e) {
        // e.target gets the element that triggered event
        var submission_id = e.target.id
        var rating = $(e.target).val()
        if (rating.trim() == "") {
            rating = 0
        }
        saveRating(submission_id, rating)
    });
}

function saveRating(submission_id, rating){
  $.ajax({
    url: '/evaluation/save_rating',
    type: 'POST',
    data: {"submission_id": submission_id, "rating": rating},
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
;
