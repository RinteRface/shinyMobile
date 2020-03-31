// Input binding
var f7SmartSelectBinding = new Shiny.InputBinding();

$.extend(f7SmartSelectBinding, {

  initialize: function(el) {
    var id = $(el).attr('id');
    var config = $(el).find("script[data-for='" + id + "']");
    config = JSON.parse(config.html());
    console.log(config);

    config.el = '#' + id;
    // feed the create method
    var ss = app.smartSelect.create(config);
    this["smart-select-" + el.id] = ss;
    console.log(ss);
    console.log(this["smart-select-" + el.id]);
  },

  find: function(scope) {
    return $(scope).find(".smart-select-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return this["smart-select-" + el.id].getValue();
  },

  // see updateF7VirtualList
  setValue: function(el, value) {
    //this["smart-select-" + el.id].setValue(value);
  },

  // see updateF7VirtualList
  receiveMessage: function(el, data) {
    //this.setValue(el, data);
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
