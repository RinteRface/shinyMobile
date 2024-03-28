import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // Update gauges
  Shiny.addCustomMessageHandler("update-gauge", function(message) {
    var el = "#" + message.id;
    app.gauge.get(el).update(message);
  });
});

