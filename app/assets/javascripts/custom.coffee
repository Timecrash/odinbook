$(document).on "click", ".edit_link", ->
  $(this).siblings('.edit_form').slideToggle()
  
$(document).on "click", ".comment_link", ->
  $(this).parent().siblings('.post_comments').slideToggle()