// Input binding
var f7DatePickerBinding = new Shiny.InputBinding();

$.extend(f7DatePickerBinding, {

  initialize: function(el) {

    var inputEl = $(el)[0];

    var config = $(el).parent().find('script[data-for="' + el.id + '"]');
    config = JSON.parse(config.html());

    if (!config.hasOwnProperty("value")) {
      config.value = new Date();
    } else {
      config.value = Date.parse(config.value);
    }

    config.inputEl = inputEl;

    //data.timePicker = true;

    // feed the create method
    var calendar = app.calendar.create(config);
    calendar.setValue([config.value]);
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

  },

  // see updateF7DatePicker
  receiveMessage: function(el, data) {
    //console.log(el);
    //var d = app.calendar.get(el);
    //console.log(d);
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
