// Input binding
var f7DateBinding = new Shiny.InputBinding();

$.extend(f7DateBinding, {

  initialize: function(el) {
    var today = new Date();
    app.calendar.create({
      inputEl: el,
      value: [today]
    });
  },

  find: function(scope) {
    return $(scope).find(".calendar-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    //return app.calendar.get($(el)).value;
  },

  // see updateF7Calendar
  setValue: function(el, value) {
    //var val = $(".calendar-day-selected").attr("data-date");
    //$(el).attr("value", val);
    //console.log($(el).value);
    //$(el).data('immediate', true);
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
