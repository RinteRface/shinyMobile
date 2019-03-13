$(function () {
  // select the first nav item by default at start
  $('.toolbar-inner .a:eq(0)').addClass('tab-link-active');
  $('.page-content.tab:eq(0)').addClass('tab-active');

  // handles shinyapps.io
  var workerId = $('base').attr('href');
  // ensure that this code does not locally
  if (typeof workerId != "undefined") {
    var pathname = window.location.pathname;
    var newpath = pathname + workerId;
    console.log(newpath);
    window.history.replaceState( {} , 'newpath', newpath);
  }
});
