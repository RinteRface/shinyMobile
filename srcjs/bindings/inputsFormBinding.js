import { getAppInstance } from "../init.js";

// Input binding
var f7InputsFormBinding = new Shiny.InputBinding();

$.extend(f7InputsFormBinding, {

  find: function(scope) {
    return $(scope).find(".inputs-form");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var formData = getAppInstance()
      .form.convertToData('#' + el.id);
    return formData;
  },

  // see updateF7Card
  receiveMessage: function(el, data) {
    getAppInstance()
      .form
      .fillFromData('#' + el.id, data);;
  },

  subscribe: function(el, callback) {
    // need to subscribe after open and close
    // therefore we listen to opened and closed, respectively
    $(el).find(":input").on("edit.f7InputsFormBinding change.f7InputsFormBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7InputsFormBinding");
  }
});

Shiny.inputBindings.register(f7InputsFormBinding, 'f7.inputsform');

