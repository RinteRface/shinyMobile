import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // Skeleton effect at each output recalculation
  const skeletonClass = "skeleton-text skeleton-effect-fade";

  Shiny.addCustomMessageHandler("add_skeleton", function(message) {
    var cl = "skeleton-text skeleton-effect-" + message.effect;
    $(message.target).addClass(cl);
    if (message.duration !== undefined) {
      setTimeout(function() {
        $(message.target).removeClass(cl);
      }, message.duration * 1000);
    } else {
      $(document).on("shiny:idle", function() {
        $(message.target).removeClass(cl);
      });
    }
  });
  // Skeleton preloader
  window.ran = false;
  if (app.params.skeletonsOnLoad) {
    const skeletonTargets = [".page-content", ".navbar", ".toolbar"];
    $(document).on("shiny:connected", function(event) {
      setTimeout(function() {
        if ($("html").hasClass("shiny-busy")) {
          for (target of skeletonTargets) {
            $(target).addClass(skeletonClass);
          }
        }
      }, 50);
    });
    $(document).on("shiny:idle", function(event) {
      if (!window.ran) {
        for (target of skeletonTargets) {
          $(target).removeClass(skeletonClass);
        }
      }
      window.ran = true;
    });
  }
});

