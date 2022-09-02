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

    data.on = {
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
    var p = app.picker.create(data);
    inputEl.f7Picker = p;
  },

  find: function(scope) {
    return $(scope).find(".picker-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var p = app.picker.get($(el));
    return p.value;
  },

  // see updateF7Picker
  setValue: function(el, value) {
    var p = app.picker.get($(el));
    p.value = value;
    p.displayValue = value;
    p.open();
    setTimeout(function() {p.close();}, 10);
  },

  // see updateF7Picker
  receiveMessage: function(el, data) {
    var p = app.picker.get($(el));
    // Update value
    if (data.hasOwnProperty('value')) {
      this.setValue(el, data.value);
    }
    // update choices
    if (data.hasOwnProperty('choices')) {
      p.cols[0].values = data.choices;
    }
    // update other properties
    if (data.hasOwnProperty('rotateEffect')) {
      p.params.rotateEffect = data.rotateEffect;
    }
    if (data.hasOwnProperty('openIn')) {
      p.params.openIn = data.openIn;
    }
    if (data.hasOwnProperty('scrollToInput')) {
      p.params.scrollToInput = data.scrollToInput;
    }
    if (data.hasOwnProperty('closeByOutsideClick')) {
      p.params.closeByOutsideClick = data.closeByOutsideClick;
    }
    if (data.hasOwnProperty('toolbar')) {
      p.params.toolbar = data.toolbar;
    }
    if (data.hasOwnProperty('toolbarCloseText')) {
      p.params.toolbarCloseText = data.toolbarCloseText;
    }
    if (data.hasOwnProperty('sheetSwipeToClose')) {
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

Shiny.inputBindings.register(f7PickerBinding, 'f7.picker');
