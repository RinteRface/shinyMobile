// Input binding
var f7DatePickerBinding = new Shiny.InputBinding();

$.extend(f7DatePickerBinding, {

  initialize: function(el) {

    var inputEl = $(el)[0];

    var config = $(el).parent().find("script[data-for='" + el.id + "']");
    config = JSON.parse(config.html());

    if (!config.hasOwnProperty("value")) {
      config.value = [new Date()];
    } else {
      for (var i = 0; i < config.value.length; i++) {
        config.value[i] = new Date(config.value[i]);
      }
    }

    config.inputEl = inputEl;

    //data.timePicker = true;

    // feed the create method
    var calendar = app.calendar.create(config);
    calendar.setValue(config.value);
    this["calendar-" + el.id] = calendar;
  },

  find: function(scope) {
    return $(scope).find(".calendar-input");
  },

  getType: function(el) {
    return "f7DatePicker.date";
  },
  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return this["calendar-" + el.id].getValue();
  },

  // see updateF7DatePicker
  setValue: function(el, value) {
    this["calendar-" + el.id].setValue(value);
  },

  // see updateF7DatePicker
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("config")) {
      this["calendar-" + el.id].destroy();
      data.config.inputEl = el;
      this["calendar-" + el.id] = app.calendar.create(data.config);
    }
    if (data.hasOwnProperty("value")) {
      for (var i = 0; i < data.value.length; i++) {
        data.value[i] = new Date(data.value[i]);
      }
      this.setValue(el, data.value);
    }
  },

  subscribe: function(el, callback) {
    $(el).on("change.f7DatePickerBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7DatePickerBinding");
  }
});

Shiny.inputBindings.register(f7DatePickerBinding);
