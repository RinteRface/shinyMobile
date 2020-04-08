// Input binding
var f7PopupBinding = new Shiny.InputBinding();

$.extend(f7PopupBinding, {

  initialize: function(el) {

    var config = $(el).find("script[data-for='" + el.id + "']");
    config = JSON.parse(config.html());
    config.el = el;

    // this is to show shiny outputs in the popup
    config.on = {
      opened: function () {
        $(el).trigger('shown');
      }
    };

    // feed the create method
    var p = app.popup.create(config);

  },

  find: function(scope) {
    return $(scope).find(".popup");
  },

  getId: function(el) {
    return Shiny.InputBinding.prototype.getId.call(this, el) || el.name;
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return app.popup.get($(el)).opened;
  },


  // see updateF7Popup
  receiveMessage: function(el, data) {
    // create a variable to update the range
    var p = app.popup.get($(el));
    if (p.opened) {
      p.close();
    } else {
      p.open();
    }
  },

  subscribe: function(el, callback) {
    $(el).on("popup:opened.f7PopupBinding popup:closed.f7PopupBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7PopupBinding");
  }
});

Shiny.inputBindings.register(f7PopupBinding, 'f7.popup');
