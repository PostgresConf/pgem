$(document).ready(function(){
    if($('.navbar-custom:not(.navbar-solid)').length) {
      $(window).on('scroll load', function(){
          let top = $(window).scrollTop();

          // skip if user clicked navbar-toggle and the menu is shown
          if($('.navbar-custom.expanded').length === 0) {
            if (top > 50) {
                $('#site-nav').addClass('navbar-solid');
            }
            else {
                $('#site-nav').removeClass('navbar-solid');
            }
          }
      })

      $('.navbar-toggle').click(function(){
        var top = $(window).scrollTop();
        if(top <= 50) {
          $('#site-nav').toggleClass('navbar-solid expanded');
        }
      });
    }
})