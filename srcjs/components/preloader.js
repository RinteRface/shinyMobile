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

  // pull to refresh
  // add the preloader tag dynamically
  if ($("body").attr("data-ptr") === "true") {
    const ptrLoader = $(
      '<div class="ptr-preloader">' +
        '<div class="preloader"></div>' +
        '<div class="ptr-arrow"></div>' +
        "</div>"
    );

    // add useful classes to the page content
    $(".page-content")
      .addClass("ptr-content")
      .prepend(ptrLoader)
      .attr("data-ptr-distance", "55")
      .attr("data-ptr-mousewheel", "true");

    // we need to create the ptr manually since it
    // is added after the page initialization
    app.ptr.create(".ptr-content");
    var ptr = app.ptr.get(".ptr-content");
    // Add 'refresh' listener on it
    ptr.on("refresh", function(e) {
      // Emulate 2s loading
      Shiny.setInputValue("ptr", true);
      setTimeout(function() {
        app.ptr.done();
      }, 2000);
    });

    // reset input. This will prevent observeEvent from
    // always being fired since they ignore NULL by default.
    // Therefore, instead of setting ptr to FALSE, we set it
    // to null
    ptr.on("done", function(e) {
      Shiny.setInputValue("ptr", null);
    });
  }

  // validate inputs (see f7ValidateInput)
  Shiny.addCustomMessageHandler("validate-input", function(message) {
    $("#" + message.target)
      .attr("required", "")
      .attr("validate", "")
      .attr("pattern", message.pattern)
      .attr("data-error-message", message.error);

    $("#" + message.target)
      .closest(".item-content.item-input")
      .addClass("item-input-with-info");
    var infoTag;
    if (message.info !== undefined) {
      infoTag = '<div class = "item-input-info">' + message.info + "</div>";
    }
    $("#" + message.target)
      .parent()
      .append(infoTag);
  });

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

