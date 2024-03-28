import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  Shiny.addCustomMessageHandler("add-popover", function(message) {
    // We store all created instances in app data so that we don't
    // recreate them later if they exist ...
    if (app.store.state.popovers[message.targetEl] === undefined) {
      // Only create if popover is enable for the current targetEl
      if (!$(message.targetEl).hasClass("popover-disabled")) {
        // popover HTML layout
        message.content = `
        <div class="popover" id=${message.targetEl}>
          <div class="popover-angle"></div>
          <div class="popover-inner">
            <div class="block">${message.content}</div>
          </div>
        </div>
        `;

        // Handle dark mode
        message.on = {
          open: function(target) {
            if (target.app.params.dark) {
              $(target.el).addClass("theme-dark");
            }
          }
        };

        // create instance
        var p = app.popover.create(message);
        // Open popover
        p.open();
        // Storage in app data (popovers array)
        app.store.state.popovers[message.targetEl] = p;
      }
    } else {
      // Only show if popover is enable for the current targetEl
      if (!$(message.targetEl).hasClass("popover-disabled")) {
        app.store.state.popovers[message.targetEl].open();
      }
    }
  });

  Shiny.addCustomMessageHandler("toggle-popover", function(message) {
    // Simply adds a class to indicate that the popover has to be hidden
    $(message).toggleClass("popover-disabled");
  });
});

