import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // Tooltips new API shinyMobile 2.0.0
  Shiny.addCustomMessageHandler("add_tooltip", function(message) {
    // We store all created instances in app data so that we don't
    // recreate them later if they exist ...
    if (app.store.state.tooltips[message.targetEl] === undefined) {
      // create instance
      var t = app.tooltip.create(message);
      // Open tooltip
      t.show();
      // Storage in app data (tooltips array)
      app.store.state.tooltips[message.targetEl] = t;
    }
  });

  Shiny.addCustomMessageHandler("update_tooltip", function(message) {
    if (app.store.state.tooltips[message.targetEl] !== undefined) {
      // Try to get the instance
      var t = app.tooltip.get(message.targetEl);
      if (message.action === "update") {
        if (t) {
          t.setText(message.text);
        }
      } else if (message.action === "toggle") {
        if (t) {
          // create copy that won't be modified if t is destroyed!
          var cachedTooltip = Object.assign({}, t);
          // save copy to replace the deleted one in the app data
          app.store.state.tooltips[message.targetEl] = cachedTooltip;
          // destroy current instance
          t.destroy();
        } else {
          // Parameters
          var pars = app.store.state.tooltips[message.targetEl].params;
          // recreate the tooltip based on the copy configuration
          t = app.tooltip.create(pars);
          app.store.state.tooltips[message.targetEl] = t;
        }
      }
    }
  });
});

