// Input binding
var f7DateBinding = new Shiny.InputBinding();

$.extend(f7DateBinding, {

  initialize: function(el) {
    var date = $(el).data("data-date");
    // If initial_date is null, set to current date
    if (date === undefined || date === null) {
      // Get local date, but as UTC
      date = new Date();
    }

    app.calendar.create({
      inputEl: el,
      value: [date]
    });
  },

  find: function(scope) {
    return $(scope).find(".calendar-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    $(el).on("change", function(el) {
      console.log($(".calendar-day-selected").attr("data-date"));
      var val = $(".calendar-day-selected").attr("data-date");
      $(el).attr("value", val);
    });
    return app.calendar.get($(el)).value;
  },

  // see updateF7Calendar
  setValue: function(el, value) {
    //$(el).data('immediate', true);
    app.calendar.setValue($(el)).value;
  },

  // see updateF7Calendar
  receiveMessage: function(el, data) {

  },

  subscribe: function(el, callback) {
    $(el).on("calendar:change.f7DateBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7DateBinding");
  }
});

Shiny.inputBindings.register(f7DateBinding);
