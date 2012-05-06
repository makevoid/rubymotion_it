(function() {

  $(function() {
    return $(".post").on("click", function(evt) {
      evt.preventDefault();
      $(this).toggleClass("open");
      return $(this).toggleClass("closed");
    });
  });

}).call(this);
