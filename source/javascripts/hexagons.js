$(document).ready(function() {
  console.log("Adding hi");
  $('.desc').hide();
  $('.hexagon').hover(
    function() {
      color = $(this).data('overlay-color');
      $(this).find('.desc').fadeIn('fast');
      console.log("Adding color" + color);
      $(this).find('.desc').addClass(color);
    }, 
    function() {
      color = $(this).data('overlay-color');
      $(this).find('.desc').fadeOut('fast', function() {
        $(this).removeClass(color);
      });
    });
});