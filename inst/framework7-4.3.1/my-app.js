$(function () {
  // select the first nav item by default at start
  $('.toolbar-inner .a:eq(0)').addClass('tab-link-active');
  var ios = $('html').hasClass('ios');
  // only add the highlight bar if the theme is material
  if (!ios) {
   $('.toolbar-inner').append('<span class="tab-link-highlight" style="width: 33.333333333333336%; transform: translate3d(0%, 0px, 0px);"></span>');
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
});
