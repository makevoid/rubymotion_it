post_close = (post) ->
  $(post).addClass("closed")
  $(post).removeClass("open")
  
post_open = (post) ->
  $(post).addClass("open")
  $(post).removeClass("closed")

bindAll = ->
  $(".post.closed").off "click"    
  $(".post.closed").on "click", (evt) ->
    target = $(evt.target)
    evt.preventDefault() if !target.hasClass("title") || $(this).hasClass("closed")
  
    if target.hasClass("close")
      post_close this
    else
      post_open this
    
$ ->
  bindAll()
