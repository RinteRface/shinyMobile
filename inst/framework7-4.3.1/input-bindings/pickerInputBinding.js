// Input binding
var f7PickerBinding = new Shiny.InputBinding();

$.extend(f7PickerBinding, {

  initialize: function(el) {
    // vals is a global variable defined in the UI side.
    // It contains an array of choices to populate
    // the picker input.
    app.picker.create({
      inputEl: el,
      rotateEffect: true,
      cols: [
        {
          textAlign: 'center',
          values: vals
        }
      ]
    });
  },

  find: function(scope) {
    return $(scope).find(".picker-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var pickerval = $(".picker-item-selected").attr("data-picker-value");
    return pickerval;
  },

  // see updateF7Slider
  setValue: function(el, value) {
    //$(el).data('immediate', true);
    app.picker.setValue($(el)).value;
  },

  // see updateF7Slider
  receiveMessage: function(el, data) {

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

Shiny.inputBindings.register(f7PickerBinding);
