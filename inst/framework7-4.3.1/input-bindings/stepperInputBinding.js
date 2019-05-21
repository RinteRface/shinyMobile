// Input binding
var f7StepperBinding = new Shiny.InputBinding();

$.extend(f7StepperBinding, {

  initialize: function(el) {
    app.stepper.create({el: el});
  },

  find: function(scope) {
    return $(scope).find(".stepper");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return app.stepper.get($(el)).value;
  },

  subscribe: function(el, callback) {
    $(el).on("stepper:change.f7StepperBinding", function(e) {
      // no need to debounce here
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7StepperBinding");
  },

  // The input rate limiting policy
  getRatePolicy: function() {
    return {
      // Can be 'debounce' or 'throttle'
      policy: 'debounce',
      delay: 500
    };
  }
});

Shiny.inputBindings.register(f7StepperBinding);
