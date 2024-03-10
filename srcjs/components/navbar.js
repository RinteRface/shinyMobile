import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // show navbar (to remove)
  Shiny.addCustomMessageHandler("show_navbar", function(message) {
    var animate;
    if (message.animate == "true") animate = true;
    else animate = false;
    app.navbar.show(".navbar", (animate = message.animate));
  });

  // hide navbar (to remove)
  Shiny.addCustomMessageHandler("hide_navbar", function(message) {
    var animate;
    var hideStatusbar;
    if (message.animate == "true") animate = true;
    else animate = false;
    if (message.hideStatusbar == "true") hideStatusbar = true;
    else hideStatusbar = false;
    app.navbar.hide(
      ".navbar",
      (animate = animate),
      (hideStatusbar = hideStatusbar)
    );
  });

  // toggle navbar
  Shiny.addCustomMessageHandler("toggle_navbar", function(message) {
    $navbar = $(".navbar");
    var isHidden = $navbar.hasClass("navbar-hidden");
    if (isHidden) {
      app.navbar.show(".navbar", (animate = message.animate));
    } else {
      app.navbar.hide(
        ".navbar",
        (animate = message.animate),
        (hideStatusbar = message.hideStatusbar)
      );
    }
  });
});
