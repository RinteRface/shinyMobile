// Input binding
var f7PopupBinding = new Shiny.InputBinding();

$.extend(f7PopupBinding, {

  initialize: function(el) {

    // recover the inputId passed in the R function
    var id = $(el).attr("id");

    var data = {};
    [].forEach.call(el.attributes, function(attr) {
      if (/^data-/.test(attr.name)) {
        var camelCaseName = attr.name.substr(5).replace(/-(.)/g, function ($0, $1) {
          return $1.toUpperCase();
        });
        // convert "true" to true and "false" to false
        var isTrueSet = (attr.value == "true");
        data[camelCaseName] = isTrueSet;
      }
    });

    // add the id
    data.el = '#' + id;

    // this is to show shiny outputs in the popup
    data.on = {
      opened: function () {
        $(el).trigger('shown');
      }
    };

    // feed the create method
    var p = app.popup.create(data);

  },

  find: function(scope) {
    return $(scope).find(".popup");
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

Shiny.inputBindings.register(f7PopupBinding);
