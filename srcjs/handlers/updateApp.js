import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // Update app instance params (see updateF7App)
  Shiny.addCustomMessageHandler("update-app", function(message) {
    // Merge new config to existing one
    app.utils.extend(app.params, message);
  });
});

