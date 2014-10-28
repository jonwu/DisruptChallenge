$(document).ready(function() {
  $("#create_form").sortable();
  $("#create_form").disableSelection();

  $("#add_question").click(addQuestion);
});


function addQuestion() {
  $("#create_form").prepend(
    $('<li>').append(
      $('<div>').append(
        "<%= label_tag 'Question 1'%><%= text_field_tag :q1 %>")
    ));
}