/* global $ */

$(document).ready(function() {
  $('.edit_link').on('click', function() {
    $(this).siblings('.edit_form').slideToggle();
  });
});