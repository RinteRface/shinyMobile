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

Shiny.inputBindings.register(f7ToggleBinding);
