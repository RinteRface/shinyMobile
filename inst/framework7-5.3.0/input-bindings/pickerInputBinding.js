// Input binding
var f7PickerBinding = new Shiny.InputBinding();

$.extend(f7PickerBinding, {

  initialize: function(el) {

    var inputEl = $(el)[0];

    // convert data attributes to camelCase parameters
    // necessary in the create method
    var data = {};
    [].forEach.call(el.attributes, function(attr) {
      if (/^data-/.test(attr.name)) {
        var camelCaseName = attr.name.substr(5).replace(/-(.)/g, function ($0, $1) {
          return $1.toUpperCase();
        });
        // convert "true" to true and "false" to false only for booleans
        if (["openIn", "toolbarCloseText", "choices", "value"].indexOf(camelCaseName) == -1) {
          var isTrueSet = (attr.value == 'true');
          data[camelCaseName] = isTrueSet;
        } else {
          data[camelCaseName] = attr.value;
        }
      }
    });

    // add the id, value and choices
    data.inputEl = inputEl;
    data.value = JSON.parse(data.value);
    data.cols = [
      {
        textAlign: 'center',
        values: JSON.parse(data.choices)
      }
    ];

    // need to trigger a click
    // close the picker to initiate it properly but need Timeout
    // otherwise the picker cannot open anymore
    data.on = {
      init: function(picker) {
        picker.open();
        setTimeout(function() {picker.close();}, 4);
      }
    };

    // feed the create method
    var p = app.picker.create(data);
    inputEl.f7Picker = p;
  },

  find: function(scope) {
    return $(scope).find(".picker-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var p = app.picker.get($(el));
    return p.cols[0].value;
    //return app.picker.getValue(el);
  },

  // see updateF7Picker
  setValue: function(el, value) {
    var p = app.picker.get($(el));
    // value must of length 1
    if (value.length == 1) {
      p.cols[0].value = value;
      p.cols[0].displayValue = value;
      p.displayValue[0] = value;
      p.value[0] = value;
      p.open();
      setTimeout(function() {p.close();}, 10);
    }
  },

  // see updateF7Picker
  receiveMessage: function(el, data) {
    var p = app.picker.get($(el));
    // update placeholder
    if (data.hasOwnProperty('choices')) {
      p.cols[0].values = data.choices;
    }
    // Update value
    if (data.hasOwnProperty('value')) {
      this.setValue(el, data.value);
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

Shiny.inputBindings.register(f7PickerBinding);
