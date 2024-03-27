import { getAppInstance } from "../init.js";

var f7ColorPickerBinding = new Shiny.InputBinding();

$.extend(f7ColorPickerBinding, {
  instances: [],
  initialize: function(el) {
    this.app = getAppInstance();
    var inputEl = $(el)[0];

    var config = $(el).parent().find("script[data-for='" + el.id + "']");
    config = JSON.parse(config.html());

    config.inputEl = el;
    config.targetEl = "#" + $(el).attr("id") + '-value';

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
    this.instances[el.id] = this.app.colorPicker.create(config);

  },

  find: function(scope) {
    return $(scope).find(".color-picker-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return this.instances[el.id].getValue();
  },

  // see updateF7ColorPicker
  setValue: function(el, value) {

  },

  // see updateF7ColorPicker
  receiveMessage: function(el, data) {

  },

  subscribe: function(el, callback) {
    $(el).on("change.f7ColorPickerBinding ", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7ColorPickerBinding ");
  }
});

Shiny.inputBindings.register(f7ColorPickerBinding, 'f7.colorpicker');
