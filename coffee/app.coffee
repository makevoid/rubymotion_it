$ ->
  $(".post").on "click", (evt) ->
    evt.preventDefault()
    $(this).toggleClass("open")
    $(this).toggleClass("closed")