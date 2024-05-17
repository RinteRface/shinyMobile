import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // Update app instance params (see updateF7App)
  Shiny.addCustomMessageHandler("update-routes", function(message) {
    // Include new route in existing routes
    app.utils.extend(app.routes, message);
    // Reset main view
    app.views.get(".view-main").destroy();
    app.views.create(".view-main")
  });
}); 
