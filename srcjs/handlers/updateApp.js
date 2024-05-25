import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // Update app instance params (see updateF7App)
  Shiny.addCustomMessageHandler("update-app", function(message) {
    // If color, dark or theme is changed, we need to update it
    if (message.hasOwnProperty("color")) {
      app.setColorTheme(message.color);
    }

    // Note that app.setDarkMode does not work in tab layout
    // That's why we need to manually add/remove dark/light class
    if (message.hasOwnProperty("dark")) {
      if (message.dark) {
        $("html").addClass("dark");
        $("html").removeClass("light");
        $("body").addClass("dark");
        $("body").removeClass("light");
      } else {
        $("html").addClass("light");
        $("html").removeClass("dark");
        $("body").addClass("light");
        $("body").removeClass("dark");
      }
    }

    if (message.hasOwnProperty("theme")) {
      if (message.theme === "md") {
        $("html").addClass("md");
        $("html").removeClass("ios");
        $(".tab-link-highlight").show();
      } else if (message.theme === "ios") {
        $("html").addClass("ios");
        $("html").removeClass("md");
        $(".tab-link-highlight").hide();
      }
    }

    // Merge new config to existing one
    app.utils.extend(app.params, message);
  });
});

