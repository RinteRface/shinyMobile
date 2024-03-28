import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // Create and show all f7Progress
  activateAllProgress = function() {
    $(".progressbar").each(function() {
      var el = "#" + $(this).attr("id");
      var progress = parseInt($(this).attr("data-progress"));
      // color does not work from JS (needs to be done from R)
      app.progressbar.show(el, progress);
    });
  };

  activateAllProgress();

  // update f7Progress
  Shiny.addCustomMessageHandler("update-progress", function(message) {
    app.progressbar.set("#" + message.id, message.progress);
  });
});

