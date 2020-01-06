// Input binding
var f7DateBinding = new Shiny.InputBinding();

$.extend(f7DateBinding, {
  find: function(scope) {
    return $(scope).find(".date-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    console.log($(el).attr("value"));
    return $(el).attr("value");
  },

  // see updateF7Calendar
  setValue: function(el, value) {

  },

  // see updateF7Calendar
  receiveMessage: function(el, data) {

  },

  subscribe: function(el, callback) {
    $(el).on('keyup.dateInputBinding input.dateInputBinding', function(event) {
      // Use normal debouncing policy when typing
      callback(true);
    });
    $(el).on("change.f7DateBinding", function(e) {
      callback(false);
    });
  },

  getRatePolicy: function() {
    return {
      policy: 'debounce',
      delay: 250
    };
  },

  unsubscribe: function(el) {
    $(el).off(".f7DateBinding");
  }
});

Shiny.inputBindings.register(f7DateBinding);
