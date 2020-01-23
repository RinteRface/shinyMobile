// Input binding
var f7DatePickerBinding = new Shiny.InputBinding();

$.extend(f7DatePickerBinding, {

  initialize: function(el) {

    var inputEl = $(el)[0];

    var data = {};
    [].forEach.call(el.attributes, function(attr) {
      if (/^data-/.test(attr.name)) {
        var camelCaseName = attr.name.substr(5).replace(/-(.)/g, function ($0, $1) {
          return $1.toUpperCase();
        });
        // convert "true" to true and "false" to false only for booleans
        if (["openIn", "toolbarCloseText", "dateFormat", "value", "direction", "headerPlaceholder"].indexOf(camelCaseName) == -1) {
          var isTrueSet = (attr.value == 'true');
          data[camelCaseName] = isTrueSet;
        } else {
          data[camelCaseName] = attr.value;
        }
      }
    });

    if (data.value === undefined) {
      date = new Date();
      data.value = date;
    } else {
      data.value = JSON.parse(data.value);
    }

    data.inputEl = inputEl;

    //data.timePicker = true;

    // feed the create method
    var d = app.calendar.create(data);
    inputEl.f7DatePicker = d;
  },

  find: function(scope) {
    return $(scope).find(".calendar-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    // below we have an issue with the returned month. Apparently,
    // months start from 0 so when august is selected, it actually
    // returns july. Need to increment by 1.
    // var d = app.calendar.get($(el));
    // console.log(d);
    var value = $(".calendar-day-selected").attr("data-date");
    if (typeof value === "undefined") {
      return JSON.parse($(el).attr("placeholder"));
    }
    value = value.split("-");
    n = parseInt(value[1]) + 1;
    if (n < 10) {
      if (value[2] < 10) {
       value = value[0] + "-0" + n + "-0" + value[2];
      } else {
        value = value[0] + "-0" + n + "-" + value[2];
      }
    } else {
      if (value[2] < 10) {
        value = value[0] + "-" + n + "-0" + value[2];
      } else {
        value = value[0] + "-" + n + "-" + value[2];
      }
    }
    return value;
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
