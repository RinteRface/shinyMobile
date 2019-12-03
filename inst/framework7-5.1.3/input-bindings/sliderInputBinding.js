// Input binding
var f7SliderBinding = new Shiny.InputBinding();

$.extend(f7SliderBinding, {

  initialize: function(el) {

    // recover the inputId passed in the R function
    var id = $(el).attr("id");

    var data = {};
    [].forEach.call(el.attributes, function(attr) {
      if (/^data-/.test(attr.name)) {
        var camelCaseName = attr.name.substr(5).replace(/-(.)/g, function ($0, $1) {
          return $1.toUpperCase();
        });
        // convert "true" to true and "false" to false
        if (["min", "max", "step", "value",
        "scaleSteps", "scaleSubSteps",
        "valueLeft", "valueRight"].indexOf(camelCaseName) == -1) {
          var isTrueSet = (attr.value == "true");
          data[camelCaseName] = isTrueSet;
        } else {
          // convert strings to numeric
          data[camelCaseName] = parseFloat(attr.value);
        }

      }
    });

     // add the id
    data.el = '#' + id;

    // feed the create method
    var r = app.range.create(data);
    console.log(r);

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
