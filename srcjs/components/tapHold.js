import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // handle taphold events
  Shiny.addCustomMessageHandler("tapHold", function(message) {
    var callback = new Function("return (" + message.callback + ")");
    $(message.target).on("taphold", function() {
      callback();
    });
  });
});

