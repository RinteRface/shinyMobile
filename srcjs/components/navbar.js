import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // toggle navbar
  Shiny.addCustomMessageHandler("toggle-navbar", function(message) {
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
