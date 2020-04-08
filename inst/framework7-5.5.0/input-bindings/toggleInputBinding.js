// Input binding
var f7ToggleBinding = new Shiny.InputBinding();

$.extend(f7ToggleBinding, {

  initialize: function(el) {
    app.toggle.create({el: el});
  },

  find: function(scope) {
    return $(scope).find(".toggle");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return app.toggle.get($(el)).checked;
  },

  // see updateF7Toggle
  setValue: function(el, value) {
    var t = app.toggle.get($(el));
    t.checked = value;
  },

  // see updateF7Toggle
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("checked")) {
      this.setValue(el, data.checked);
    }
    if (data.hasOwnProperty("color")) {
      $(el).removeClass (function (index, className) {
    return (className.match (/(^|\s)color-\S+/g) || []).join(' ');
});
      $(el).addClass("color-" + data.color);
    }
  },

  subscribe: function(el, callback) {
    $(el).on("toggle:change.f7ToggleBinding", function(e) {
      // no need to debounce here
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7ToggleBinding");
  }
});

Shiny.inputBindings.register(f7ToggleBinding, 'f7.toggle');
