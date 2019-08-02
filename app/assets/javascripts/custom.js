/* Left menu */
$(document).on('ready turbolinks:load', function(){
  $("#menu-toggle").click(function(e) {
    e.preventDefault();
    $("#wrapper").toggleClass("toggled");
  });
});
