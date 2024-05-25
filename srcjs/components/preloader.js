import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();
  // note: we probably don't need to store this
  // in the app store ...
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
    if (message.type === "dialog") {
      app.store.state.preloaders[message.id] = app.dialog.preloader(color = message.color);
      return
    }
    if (message.type === "progress") {
      app.store.state.preloaders[message.id] = app.dialog.progress(0, color = message.color);
      return
    }
    if (typeof message.el !== "undefined") {
      app.preloader.showIn(message.el, message.color);
    } else {
      app.preloader.show(message.color);
    }
  });

  Shiny.addCustomMessageHandler("update-preloader", function(message) {
    var el = app.store.state.preloaders[message.id];
    if (typeof message.title !== undefined) {
      el.setTitle(message.title);
    }
    if (typeof message.text !== undefined) {
      el.setText(message.text);
    }
    if (typeof message.progress !== undefined) {
      el.setProgress(message.progress)
    }
  })

  Shiny.addCustomMessageHandler("hide-preloader", function(message) {
    if (message.id !== undefined) {
      app.store.state.preloaders[message.id].close();
    } 

    if (typeof message.el !== "undefined") {
      app.preloader.hideIn(message.el);
    } else {
      app.preloader.hide();
    }
  });
});

