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
    app.range.setValue(el, value);
  },

  // see updateF7Slider
  receiveMessage: function(el, data) {
    // create a variable to update the range
    var r = app.range.get($(el));
    if (data.hasOwnProperty('min')) {
      r.min = data.min;
    }
    if (data.hasOwnProperty('max')) {
      r.max = data.max;
    }
    if (data.hasOwnProperty('scale')) {
      if (data.scale == "true") {
        data.scale = true;
      } else {
        data.scale = false;
      }
      r.scale = data.scale;
    }
    r.updateScale();

    // important: need to update the scale before
    // updating the value. Otherwise the value will
    // be diplayed in the old scale, which is weird...
    if (data.hasOwnProperty('value')) {
      // handle the case where the updated slider
      // switch from a dual value to a single value slider.
      var val = data.value;
      if ($.isArray(val)) {
        this.setValue(el, val);
      } else {
        r.dual = false;
        r.updateScale();
        this.setValue(el, val);
      }
    }
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
