$(function () {
  // select the first nav item by default at start
  $('.toolbar-inner .a:eq(0)').addClass('tab-link-active');
  var ios = $('html').hasClass('ios');
  // only add the highlight bar if the theme is material
  if (!ios) {
   // we programatically set up the with of the tabbar indicator
   // which depends on the number of tab items in the tabbar...
   segment_width = 100 / $('.toolbar-inner > a').length;
   $('.toolbar-inner').append('<span class="tab-link-highlight" style="width: ' + segment_width + '%; transform: translate3d(0%, 0px, 0px);"></span>');
  }
  $('.page-content.tab:eq(0)').addClass('tab-active');

  // handles shinyapps.io
  var workerId = $('base').attr('href');
  // ensure that this code does not locally
  if (typeof workerId != "undefined") {
    var pathname = window.location.pathname;
    var newpath = pathname + workerId;
    window.history.replaceState( {} , 'newpath', newpath);
  }

  // handle background for dark mode
  // need to remove the custom gainsboro color   background
  var dark_mode = $('body').hasClass('theme-dark');
  if (dark_mode) {
    $('.page-content').css('background-color', '');
    $('.page-content.tab').css('background-color', '');
  }


      // allow for subnavbar. If a subnavbar if provided in the navbar
      // add a custom class to the page so that the subnavbar is rendered
  var subnavbar = $('.subnavbar');
  if (subnavbar.length == 1) {
   $('.page').addClass('page-with-subnavbar');
  }


  // set up notifications
  // for now, it only works for 1 notification at a time
  Shiny.addCustomMessageHandler("notif", function(message) {
    var notif = app.notification.create({
      icon: '<i class="f7-icons">bolt_fill</i>',
      title: ' ' + message.title,
      titleRightText: ' ' + message.titleRightText,
      subtitle: ' ' + message.subtitle,
      text: ' ' + message.text,
      closeTimeout: ' ' + message.closeTimeout,
      closeButton: ' ' + message.closeButton,
    });
    // Open Notifications
    notif.open();
  });
});
