// Input binding
var f7SmartSelectBinding = new Shiny.InputBinding();

$.extend(f7SmartSelectBinding, {

  initialize: function(el) {
    var id = $(el).attr('id');
    var config = $(el).children().eq(2);
    config = JSON.parse(config.html());
    config.el = '#' + id;
    // feed the create method
    config.on = {
      open: function(target) {
        if (target.app.params.dark) {
          $(target.$containerEl).addClass("theme-dark");
        }
      }
    }
    var ss = app.smartSelect.create(config);
    this["smart-select-" + el.id] = ss;
  },

  find: function(scope) {
    return $(scope).find(".smart-select");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return this["smart-select-" + el.id].getValue();
  },

  // see updateF7SmartSelect
  setValue: function(el, value) {
    this["smart-select-" + el.id].setValue(value);
  },

  // see updateF7SmartSelect
  receiveMessage: function(el, data) {
    // update config
    data.config.on = {
      open: function(target) {
        if (target.app.params.dark) {
          $(target.$containerEl).addClass("theme-dark");
        }
      }
    }
    if (data.hasOwnProperty("config")) {
      this["smart-select-" + el.id].destroy();
      data.config.el = '#' + $(el).attr('id');
      this["smart-select-" + el.id] = app.smartSelect.create(data.config);
    }

    // ad multiple property
    if (data.hasOwnProperty("multiple")) {
      // we need to destroy the input, modify the tag and create the instance
      if (data.multiple) {
        this["smart-select-" + el.id].destroy();
        $(el).find('select').attr('multiple', '');
        data.config.el = '#' + $(el).attr('id');
        this["smart-select-" + el.id] = app.smartSelect.create(data.config);
      }
    }

    // max length
    if (data.hasOwnProperty("maxLength")) {
      this["smart-select-" + el.id].destroy();
      $(el).find('select').attr('maxLength', data.maxLength);
      data.config.el = '#' + $(el).attr('id');
      this["smart-select-" + el.id] = app.smartSelect.create(data.config);
    }

    // update choices
    var setOption = function(value) {
      return "<option value = '" + value + "'>" + value + "</option>";
    };

    if (data.hasOwnProperty("choices")) {
      // clear all previous options
      $(el).find("select").empty();
      // add new choices
      $.each(data.choices, function (index) {
        var temp = data.choices[index];
        $(el).find("select").append(setOption(temp));
      });
    }

    // update selected
    if (data.hasOwnProperty("selected")) {
      this.setValue(el, data.selected);
    }
  },

  subscribe: function(el, callback) {
    $(el).on("change.f7SmartSelectBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7SmartSelectBinding");
  }
});

Shiny.inputBindings.register(f7SmartSelectBinding, 'f7.smartselect');
