// Input binding
var f7DateBinding = new Shiny.InputBinding();

$.extend(f7DateBinding, {

  initialize: function(el) {
    var date = $(el).attr("placeholder");
    if (date === undefined) {
      date = new Date();
    }
    app.calendar.create({
      //containerEl: ".container-calendar",
      //inputReadOnly: false,
      multiple: false,
      dateFormat: 'yyyy-mm-dd',
      inputEl: el,
      value: [date]
    });
    $(el).click();
    app.calendar.close();
  },

  find: function(scope) {
    return $(scope).find(".calendar-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    // below we have an issue with the returned month. Apparently,
    // months start from 0 so when august is selected, it actually
    // returns july. Need to increment by 1.
    var value = $(".calendar-day-selected").attr("data-date");
    value = value.split("-");
    n = parseInt(value[1]) + 1;
    if (value[2] < 10) {
      value = value[0] + "-0" + n + "-0" + value[2];
    } else {
      value = value[0] + "-0" + n + "-" + value[2];
    }
    return value;
    //return app.calendar.get($(el)).value;
  },

  // see updateF7Calendar
  setValue: function(el, value) {
    app.calendar.setValue($(el)).value;
  },

  // see updateF7Calendar
  receiveMessage: function(el, data) {

  },

  subscribe: function(el, callback) {
    $(el).on("change.f7DateBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7DateBinding");
  }
});

Shiny.inputBindings.register(f7DateBinding);
