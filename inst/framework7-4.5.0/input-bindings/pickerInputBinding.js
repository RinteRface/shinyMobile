// Input binding
var f7PickerBinding = new Shiny.InputBinding();

$.extend(f7PickerBinding, {

  initialize: function(el) {

    var inputEl = $(el)[0];

    // recover the inputId passed in the R function
    var id = $(el).attr("id");
    // function to convert a string to variable
    function SetTo5(inputId, varString) {
      var res = eval(inputId + "_" + varString);
      return res;
    }

    // vals is a global variable defined in the UI side.
    // It contains an array of choices to populate
    // the picker input.
    var p = app.picker.create({
      inputEl: inputEl,
      rotateEffect: true,
      cols: [
        {
          textAlign: 'center',
          values: SetTo5(id, "vals")
        }
      ],
      value: SetTo5(id, "val"),
      on: {
        // need to trigger a click
        // close the picker to initiate it properly but need Timeout
        // otherwise the picker cannot open anymore
        init: function(picker) {
          picker.open();
          setTimeout(function() {picker.close();}, 4);
        },
        open: function(picker) {

        },
        close: function(picker) {

        }
      }
    });
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
