toggleFullScreen = function() {
  var element = document.documentElement,
  enterFS = element.requestFullscreen || element.msRequestFullscreen || element.mozRequestFullScreen || element.webkitRequestFullscreen,
  exitFS = document.exitFullscreen || document.msExitFullscreen || document.mozCancelFullScreen || document.webkitExitFullscreen;
  if (!document.fullscreenElement && !document.msFullscreenElement && !document.mozFullScreenElement && !document.webkitFullscreenElement) {
    enterFS.call(element);
    // change icon to zoom-out
    $('#fullScreenToggle i').html('zoom_out');
  } else {
    exitFS.call(document);
    // change icon to zoom-in
    $('#fullScreenToggle i').html('zoom_in');
  }
};
