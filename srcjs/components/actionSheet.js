import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // handle action sheet
  Shiny.addCustomMessageHandler("action-sheet", function(message) {
    // Only create action sheet whenever necessary
    if (app.store.state.actions[message.id] === undefined) {
      var buttonsId = message.id + "_button";

      // define function that set an inputvalue those name depends on an index
      // parameter
      function setButtonInput(index) {
        Shiny.setInputValue(buttonsId, index);
      }

      // add those functions to the message.button array
      function setOnClick(element, index) {
        Object.defineProperty(element, "onClick", {
          value: function() {
            setButtonInput(index + 1);
          },
          writable: false
        });
      }

      message.buttons.forEach(setOnClick);

      // Callbacks for shiny inputs
      message.on = {
        open: function(target) {
          if (target.app.params.dark) {
            $(target.el).addClass("theme-dark");
          }
        },
        opened: function() {
          Shiny.setInputValue(message.id, true);
        },
        closed: function() {
          Shiny.setInputValue(message.id, false);
          // input$button is null when the action is closed
          Shiny.setInputValue(buttonsId, null);
        }
      };

      // create the sheet
      var a = app.actions.create(message);
      a.open();
      // save action sheet to app data to update it later
      app.store.state.actions[message.id] = a;
    } else {
      app.store.state.actions[message.id].open();
    }
  });

  Shiny.addCustomMessageHandler("update-action-sheet", function(message) {
    // Destroy old instance
    app.store.state.actions[message.id].destroy();
    // Create new config
    var a = app.actions.create(message);
    // Update app data
    app.store.state.actions[message.id] = a;
  });
});

