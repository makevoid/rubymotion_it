(function() {
  var bindAll, post_close, post_open;

  post_close = function(post) {
    $(post).addClass("closed");
    return $(post).removeClass("open");
  };

  post_open = function(post) {
    $(post).addClass("open");
    return $(post).removeClass("closed");
  };

  bindAll = function() {
    $(".post.closed").off("click");
    return $(".post.closed").on("click", function(evt) {
      var target;
      target = $(evt.target);
      if (!target.hasClass("title") || $(this).hasClass("closed")) {
        evt.preventDefault();
      }
      if (target.hasClass("close")) {
        return post_close(this);
      } else {
        return post_open(this);
      }
    });
  };

  $(function() {
    return bindAll();
  });

}).call(this);
