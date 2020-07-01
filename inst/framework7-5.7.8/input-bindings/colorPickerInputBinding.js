// Input binding
var f7ColorPickerBinding = new Shiny.InputBinding();

$.extend(f7ColorPickerBinding, {

  initialize: function(el) {
    app.colorPicker.create({
      inputEl: el,
      targetEl: $(el).attr("id") + '-value',
      targetElSetBackgroundColor: true,
      modules: colorPickerModules,
      // I keep openIn default to auto since
      // it is better to be automatically optimized
      // based on the currently selected device.
      openIn: 'auto',
      sliderValue: colorPickerSliderValue,
      sliderValueEditable: colorPickerSliderValueEditable,
      sliderLabel: colorPickerSliderLabel,
      hexLabel: colorPickerHexLabel,
      hexValueEditable: colorPickerHexValueEditable,
      groupedModules: colorPickerGroupedModules,
      // Same thing here. For now, we use predefined
      // palettes. latter, maybe add user defined palettes
      palette: colorPickerPalettes,
      //formatValue: function (value) {
      //  return 'rgba(' + value.rgba.join(', ') + ')';
      //},
      value: {
        hex: colorPickerValue,
      },
    });
  },

  find: function(scope) {
    return $(scope).find(".color-picker-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var ID = $(el).attr("id");
    // below we get the hidden value field using
    // vanilla JS
    return document.getElementById(ID).value;
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
