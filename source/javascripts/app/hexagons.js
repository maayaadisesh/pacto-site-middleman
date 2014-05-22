//= require "vendor/jquery"
$(document).ready(function() {
  $('.desc').hide();
  $('.hexagon').hover(
    function() {
      $(this).find('.desc').fadeIn('fast');
      color = $(this).data('overlay-color');
      console.log("Adding color " + color);
      $(this).find('.desc').addClass(color);
    }, 
    function() {
      $(this).find('.desc').fadeOut('fast', function() {
        color = $(this).data('overlay-color');
        $(this).removeClass(color);
      });
    });
});