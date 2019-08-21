// Input binding
var f7TabsBinding = new Shiny.InputBinding();

$.extend(f7TabsBinding, {

  find: function(scope) {
    return $(scope).find(".tabsBindingTarget").siblings();
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    console.log($(el).filter(".tab-active").attr("data-value"));
    return $(el).filter(".tab-active").attr("data-value");
  },

  // see updateF7Slider
  setValue: function(el, value) {

  },

  // see updateF7Slider
  receiveMessage: function(el, data) {
    // create a variable to update the range
  },

  subscribe: function(el, callback) {
    $(el).on("change.f7TabsBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7TabsBinding");
  }
});

Shiny.inputBindings.register(f7TabsBinding);
