import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

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
        app.ptr.done(".ptr-content");
        // reset input. This will prevent observeEvent from
        // always being fired since they ignore NULL by default.
        // Therefore, instead of setting ptr to FALSE, we set it
        // to null
        Shiny.setInputValue("ptr", null);
      }, 2000);
    });
  }

});

