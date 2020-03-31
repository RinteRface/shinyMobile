// Input binding
var f7SmartSelectBinding = new Shiny.InputBinding();

$.extend(f7SmartSelectBinding, {

  initialize: function(el) {
    var id = $(el).children().eq(0).attr('id');
    var config = $(el).children().eq(2);
    config = JSON.parse(config.html());
    config.el = '#' + id;
    // feed the create method
    var ss = app.smartSelect.create(config);
    this["smart-select-" + el.id] = ss;
  },

  find: function(scope) {
    return $(scope).find(".smart-select");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return this["smart-select-" + el.id].getValue();
  },

  // see updateF7SmartSelect
  setValue: function(el, value) {
    this["smart-select-" + el.id].setValue(value);
  },

  // see updateF7SmartSelect
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("config")) {
      this["smart-select-" + el.id].destroy();
      data.config.inputEl = el;
      this["smart-select-" + el.id] = app.smartSelect.create(data.config);
    }
  },

  subscribe: function(el, callback) {
    $(el).on("change.f7SmartSelectBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7SmartSelectBinding");
  }
});

Shiny.inputBindings.register(f7SmartSelectBinding);
