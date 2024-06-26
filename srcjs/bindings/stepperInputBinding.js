import { getAppInstance } from "../init.js";

// Input binding
var f7StepperBinding = new Shiny.InputBinding();

$.extend(f7StepperBinding, {
  instances: [],
  initialize: function(el) {

    this.app = getAppInstance();

    // recover the inputId passed in the R function
    var id = $(el).attr("id");

    var config = JSON.parse($(el)
      .find("script[data-for='" + id + "']")
      .html());

    // add the id
    config.el = '#' + id;

    // feed the create method
    var s = this.app.stepper.create(config);

    // add readonly attr if the stepper is initially
    // not in manual mode
    if (!config.manualInputMode) {
      var inputTarget = $(el).find('input');
      $(inputTarget).attr('readonly', '');
    }

    // Store in global app
    this.instances[el.id] = s;
  },

  find: function(scope) {
    return $(scope).find(".stepper");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return this.instances[el.id].getValue();
  },

  // see updateF7Stepper
  setValue: function(el, value) {
    this.instances[el.id].setValue(value);
  },

  // see updateF7Stepper
  receiveMessage: function(el, data) {
    // create a variable to update the stepper
    var s = this.instances[el.id];

    // for some reason, we need to update both
    // min and params.min fields
    if (data.hasOwnProperty('min')) {
      s.min = data.min;
      s.params.min = data.min;
    }
    // for some reason, we need to update both
    // max and params.max fields
    if (data.hasOwnProperty('max')) {
      s.max = data.max;
      s.params.max = data.max;
    }
    if (data.hasOwnProperty('wraps')) {
      s.params.wraps = data.wraps;
    }
    if (data.hasOwnProperty('decimalPoint')) {
      s.decimalPoint = data.decimalPoint;
      s.params.decimalPoint = data.decimalPoint;
    }

    // handle the readOnly property
    if (data.hasOwnProperty('manual')) {
      s.params.manualInputMode = data.manual;
      var inputTarget = $(el).find('input');
      if (data.manual) {
        if (typeof $(inputTarget).attr('readonly') !== typeof undefined) {
          $(inputTarget).removeAttr('readonly');
        }
      } else {
        $(inputTarget).attr('readonly', '');
      }
    }
    // for some reason, we need to update both
    // step and params.step fields
    if (data.hasOwnProperty('step')) {
      s.step = data.step;
      s.params.step = data.step;
    }

    // this does not work
    if (data.hasOwnProperty('autorepeat')) {
      s.params.autorepeat = data.autorepeat;
      s.params.autorepeatDynamic = data.autorepeat;
    }

    // CSS properties
    if (data.hasOwnProperty('rounded')) {
      if (data.rounded) {
        $(el).addClass("stepper-round");
      } else {
        $(el).removeClass("stepper-round");
      }
    }
    if (data.hasOwnProperty('raised')) {
      if (data.raised) {
        $(el).addClass('stepper-raised');
      } else {
        $(el).removeClass('stepper-raised');
      }
    }
    if (data.hasOwnProperty('color')) {
      $(el).removeClass (function (index, className) {
        return (className.match (/(^|\s)color-\S+/g) || []).join(' ');
      });
      $(el).addClass('color-' + data.color);
    }

    // stepper size
    if (data.hasOwnProperty('size')) {
      if ($(el).hasClass('stepper-small') || $(el).hasClass('stepper-large')) {
        if ($(el).hasClass('stepper-small') && data.size == "large") {
          $(el).removeClass('stepper-small');
          $(el).addClass('stepper-large');
        } else if ($(el).hasClass('stepper-large') && data.size == "small") {
          $(el).addClass('stepper-small');
          $(el).removeClass('stepper-large');
        }
      } else {
        if (data.size == "small") {
          $(el).addClass('stepper-small');
        } else if (data.size == "large") {
          $(el).addClass('stepper-large');
        }
      }
    }

    // Update value
    if (data.hasOwnProperty('value')) {
      this.setValue(el, data.value);
      s.params.value = data.value;
    }

    $(el).trigger("change");
  },

  subscribe: function(el, callback) {
    // lexical scoping
    // 'this' changes within the context of the event listener callback
    // so we need to capture the outer 'this'
    var self = this;
    $(el).on('stepper:change.f7StepperBinding', function(e) {
      // no need to debounce here
      // except if autorepeat is set
      // then we send the value once
      // the + or - buttons is released
      var s = self.instances[el.id];
      if (s.params.autorepeat) {
        callback(true);
      } else {
        callback();
      }
    });
  },

  unsubscribe: function(el) {
    $(el).off('.f7StepperBinding');
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

Shiny.inputBindings.register(f7StepperBinding, 'f7.stepper');
