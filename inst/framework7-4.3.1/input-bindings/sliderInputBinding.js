// Input binding
var f7SliderBinding = new Shiny.InputBinding();

$.extend(f7SliderBinding, {

  initialize: function(el) {
    app.range.create({el: el});
  },

  find: function(scope) {
    return $(scope).find(".range-slider");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return app.range.get($(el)).value;
  },

  // see updateF7Slider
  setValue: function(el, value) {
    //$(el).data('immediate', true);
    app.range.setValue($(el)).value;
  },

  // see updateF7Slider
  receiveMessage: function(el, data) {

  },

  subscribe: function(el, callback) {
    $(el).on("range:change.f7SliderBinding", function(e) {
      callback(true);
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7SliderBinding");
  },

  // The input rate limiting policy
  getRatePolicy: function() {
    return {
      // Can be 'debounce' or 'throttle'
      policy: 'debounce',
      delay: 250
    };
  }
});

Shiny.inputBindings.register(f7SliderBinding);
