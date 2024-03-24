import { getAppInstance } from "../init.js";

// Input binding
var f7PickerBinding = new Shiny.InputBinding();

$.extend(f7PickerBinding, {
  instances: [],
  initialize: function(el) {
    this.app = getAppInstance();
    var id = $(el).attr("id");
    var config = JSON.parse(
      $(el)
      .parent()
      .find(`script[data-for="${id}"]`)
      .html());

    // add the id
    config.inputEl = "#" + id;
    config.cols = [
      {
        textAlign: "center",
        values: config.values
      }
    ];
    if (config.displayValues !== undefined) {
      config.cols.displayValues = config.displayValues
    }

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
    this.instances[el.id] = this.app.picker.create(config);
  },

  find: function(scope) {
    return $(scope).find(".picker-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return this.instances[el.id].value;
  },

  // see updateF7Picker
  setValue: function(el, value) {
    var p = this.instances[el.id];
    p.value = value;
    p.displayValue = value;
    p.open();
    setTimeout(function() {p.close();}, 10);
  },

  // see updateF7Picker
  receiveMessage: function(el, data) {
    var p = this.instances[el.id];
    // Update value
    if (data.hasOwnProperty("value")) {
      this.setValue(el, data.value);
    }
    // update choices
    if (data.hasOwnProperty("choices")) {
      p.cols[0].values = data.choices;
    }
    // update other properties
    if (data.hasOwnProperty("rotateEffect")) {
      p.params.rotateEffect = data.rotateEffect;
    }
    if (data.hasOwnProperty("openIn")) {
      p.params.openIn = data.openIn;
    }
    if (data.hasOwnProperty("scrollToInput")) {
      p.params.scrollToInput = data.scrollToInput;
    }
    if (data.hasOwnProperty("closeByOutsideClick")) {
      p.params.closeByOutsideClick = data.closeByOutsideClick;
    }
    if (data.hasOwnProperty("toolbar")) {
      p.params.toolbar = data.toolbar;
    }
    if (data.hasOwnProperty("toolbarCloseText")) {
      p.params.toolbarCloseText = data.toolbarCloseText;
    }
    if (data.hasOwnProperty("sheetSwipeToClose")) {
      p.params.sheetSwipeToClose = data.sheetSwipeToClose;
    }
  },

  subscribe: function(el, callback) {
    $(el).on("change.f7PickerBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7PickerBinding");
  }
});

Shiny.inputBindings.register(f7PickerBinding, "f7.picker");
