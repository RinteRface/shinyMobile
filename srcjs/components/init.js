import { getAppInstance } from "../init.js";
import { shinyInputsReset } from "../utils/shinyUtils.js";

$(function() {
  const app = getAppInstance();

  const uiWidgets = ["gauge", "swiper", "searchbar"];
  const serverWidgets = ["toast", "photoBrowser", "notification", "popup", "listIndex"];

  const widgets = uiWidgets.concat(serverWidgets);

  // Instantiate a widget
  activateWidget = function(widget) {
    // Handle ui side widgets
    if (uiWidgets.indexOf(widget) > -1) {
      $("." + widget).each(function() {
        var $el = $(this);
        var config = $(document).find(
          "script[data-for='" + $el.attr("id") + "']"
        );
        config = JSON.parse(config.html());
        // add the id
        config.el = "#" + $el.attr("id");

        // feed the create method
        app[widget].create(config);
      });
    } else {
      // This concerns toasts, notifications, photoBrowser, ...
      // that don't have any UI element in the DOM before creating
      // the widget instance.
      Shiny.addCustomMessageHandler(widget, function(message) {
        if (widget === "listIndex") {
          // We first insert the HTML before the target element.
          $(
            '<div class="list-index" id="' + message.el + '"></div>'
          ).insertBefore($(message.listEl));
        }
        // Handle dark mode
        message.on = {
          open: function(target) {
            if (message.id !== undefined) Shiny.setInputValue(message.id, true);
            if (target.app.params.dark) {
              $(target.el).addClass("theme-dark");
            }
            shinyInputsReset();
          },
          close: function() {
            if (message.id !== undefined)
              Shiny.setInputValue(message.id, false);
          }
        };
        if (widget === "listIndex") {
          message.el = "#" + message.el;
          app[widget].create(message);
          // add sticky class to the list index div
          // need to do that later to make sure indexes are present
          $(message.el).addClass("sticky-list-index");

          // get the calculated height and move the listEl up (-height)
          var height = $(message.el).height();
          $(message.listEl).css("margin-top", -height + "px");

        } else {
          app[widget].create(message).open();
        }
      });
    }
  };

  // Loop over all widgets to activate them
  widgets.forEach(function(w) {
    activateWidget(w);
  });
});

