import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // handle dialog
  Shiny.addCustomMessageHandler("dialog", function(message) {
    var type = message.type;
    // decide to lock the vertical size so that
    // people don't need to manually add overflow.
    var text = `<div style="max-height: 300px; overflow-y: scroll;">${message.text}</div>`;
    var dialog;
    switch (type) {
      case "alert":
        dialog = app.dialog.alert(text, message.title, message.on);
        break;
      case "confirm":
        dialog = app.dialog
          .confirm(
            (text = text),
            (title = message.title),
            (callbackOk = function() {
              Shiny.setInputValue(message.id, true);
            }),
            (callbackCancel = function() {
              Shiny.setInputValue(message.id, false);
            })
          )
          .open(Shiny.setInputValue(message.id, null));
        //confirm.closed(Shiny.setInputValue(message.id, null));
        break;
      case "prompt":
        dialog = app.dialog
          .prompt(
            (text = text),
            (title = message.title),
            (callbackOk = function(value) {
              Shiny.setInputValue(message.id, value);
            }),
            (callbackCancel = function() {
              Shiny.setInputValue(message.id, null);
            })
          )
          .open(Shiny.setInputValue(message.id, null));
        break;
      case "login":
        dialog = app.dialog
          .login(
            (text = text),
            (title = message.title),
            (callbackOk = function(username, password) {
              Shiny.setInputValue(message.id, {
                user: username,
                password: password
              });
            }),
            (callbackCancel = function() {
              Shiny.setInputValue(message.id, null);
            })
          )
          .open(Shiny.setInputValue(message.id, null));
        break;
      default:
        console.log("");
    }
    // Handle dark mode
    if (app.params.dark) {
      $(dialog.el).addClass("theme-dark");
    }
  });
});

