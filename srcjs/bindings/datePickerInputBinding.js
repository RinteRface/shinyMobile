import { getAppInstance } from "../init.js";

var f7DatePickerBinding = new Shiny.InputBinding();

$.extend(f7DatePickerBinding, {
  instances: [],
  initialize: function(el) {
    this.app = getAppInstance();
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

    config.on = {
      open: function(target) {
        if (target.app.params.dark) {
          target
            .$el
            .closest(".modal-in")
            .addClass("theme-dark");
        }
      }
    }

    // feed the create method
    this.instances[el.id] = this.app.calendar.create(config);
  },

  find: function(scope) {
    return $(scope).find(".calendar-input");
  },

  getType: function(el) {
    return "f7DatePicker.date";
  },
  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var val = this.instances[el.id].getValue();
    var tmpDate;
    var getTime = this.instances[el.id].hasTimePicker;
    if (val.length == 1) {
      tmpDate = new Date(val);
      tmpDate = Date.UTC(
        tmpDate.getFullYear(),
        tmpDate.getMonth(),
        tmpDate.getDate(),
        tmpDate.getHours(),
        tmpDate.getMinutes(),
        tmpDate.getSeconds()
      );
      if (!getTime) {
        return new Date(tmpDate).toISOString().slice(0, 10);
      } else {
        return new Date(tmpDate);
      }
    } else {
      var dates = [];
      for (var i = 0; i < val.length; i++) {
        dates[i] = new Date(val[i]);
        dates[i] = Date.UTC(
          dates[i].getFullYear(),
          dates[i].getMonth(),
          dates[i].getDate(),
          dates[i].getHours(),
          dates[i].getMinutes(),
          dates[i].getSeconds()
        );
        if (!getTime) {
          dates[i] = new Date(dates[i]).toISOString().slice(0, 10);
        } else {
          dates[i] = new Date(dates[i]);
        }
      }
      return dates;
    }
  },

  // see updateF7DatePicker
  setValue: function(el, value) {
    this.instances[el.id].setValue(value);
  },

  // see updateF7DatePicker
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty("config")) {
      this.instances[el.id].destroy();
      data.config.inputEl = el;
      data.config.on = {
        open: function(target) {
          if (target.app.params.dark) {
            $(target.$el).addClass("theme-dark");
          }
        }
      }
      this.instances[el.id] = this.app.calendar.create(data.config);
    }
    if (data.hasOwnProperty("value")) {
      var tmpdate;
      for (var i = 0; i < data.value.length; i++) {
        tmpdate = new Date(data.value[i]);
        data.value[i] = new Date(tmpdate.getFullYear(), tmpdate.getMonth(), tmpdate.getDate());
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

Shiny.inputBindings.register(f7DatePickerBinding, 'f7.datepicker');
