import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  if (app.params.preloader) {
    const preloader = app.dialog.preloader();
    // Handle dark mode
    if (app.params.dark) {
      $(preloader.el).addClass("theme-dark");
    }
    $(document).on("shiny:idle", function(event) {
      if (!window.ran) {
        app.dialog.close();
      }
      window.ran = true;
    });
  }

  // preloader
  Shiny.addCustomMessageHandler("show-preloader", function(message) {
    if (typeof message.el !== "undefined") {
      app.preloader.showIn(message.el, message.color);
    } else {
      app.preloader.show(message.color);
    }
  });

  Shiny.addCustomMessageHandler("hide-preloader", function(message) {
    if (typeof message.el !== "undefined") {
      app.preloader.hideIn(message.el);
    } else {
      app.preloader.hide();
    }
  });
});

