// Input binding
var f7SelectBinding = new Shiny.InputBinding();

$.extend(f7SelectBinding, {

  find: function(scope) {
    return $(scope).find(".input-select");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return $(el).val();
  },

  // see updateF7Select
  setValue: function(el, value) {
    // select the new item
    $(el).val(value);
  },

  // see updateF7Select
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("selected")) {
      this.setValue(el, data.selected);
    }
    $(el).trigger("change");
  },

  subscribe: function(el, callback) {
    $(el).on("change.f7SelectBinding", function(e) {
      // no need to debounce here
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7SelectBinding");
  }
});

Shiny.inputBindings.register(f7SelectBinding, 'f7.select');
