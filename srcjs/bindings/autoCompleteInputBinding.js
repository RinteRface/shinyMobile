// Input binding
function setSource(query, render) {
  var results = [];
  if (query.length === 0) {
    render(results);
    return;
  }
  // Find matched items
  for (var i = 0; i < vals.length; i++) {
    if (vals[i].toLowerCase().indexOf(query.toLowerCase()) >= 0) {
      results.push(vals[i]);
    }
  }
  // Render items by passing array with result items
  render(results);
};

var f7AutoCompleteBinding = new Shiny.InputBinding();

$.extend(f7AutoCompleteBinding, {
  // Store all widgets here
  instances: [],
  initialize: function(el) {

    // recover the inputId passed in the R function
    var id = $(el).attr("id");

    // convert data attributes to camelCase parameters
    // necessary in the create method
    var data = {};
    [].forEach.call(el.attributes, function(attr) {
      if (/^data-/.test(attr.name)) {
        var camelCaseName = attr.name.substr(5).replace(/-(.)/g, function ($0, $1) {
          return $1.toUpperCase();
        });
        // convert "true" to true and "false" to false only for booleans
        if (["openIn", "choices", "value", "dropdownPlaceholderText", "limit"].indexOf(camelCaseName) == -1) {
          var isTrueSet = (attr.value == 'true');
          data[camelCaseName] = isTrueSet;
        } else {
          data[camelCaseName] = attr.value;
        }
      }
    });

    data.value = JSON.parse(data.value);

    // special case where the autocomplete is standalone
    if (data.openIn == "dropdown") {
      data.inputEl = '#' + id;
    } else {
      data.openerEl = '#' + id;
    }

    var vals = JSON.parse(data.choices);
    data.source = function (query, render) {
      var results = [];
      if (query.length === 0) {
        render(results);
        return;
      }
      // Find matched items
      for (var i = 0; i < vals.length; i++) {
        if (vals[i].toLowerCase().indexOf(query.toLowerCase()) >= 0) {
          results.push(vals[i]);
        }
      }
      // Render items by passing array with result items
      render(results);
    };

    // for popup and page so that shiny is aware about input change
    data.on = {
      change: function (value) {
        // important: trigger change so that the input value
        // is updated for Shiny
        $('#' + id).trigger('change');
      }
    };

    data.popupPush = true;

    this.instances[id] = app.autocomplete.create(data);
  },

  find: function(scope) {
    return $(scope).find(".autocomplete-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var a = this.instances[el.id];
    // Set value in placeholder
    $(a.params.inputEl).val(a.value);
    return a.value;
  },

  // see updateF7AutoComplete
  setValue: function(el, value) {
    el.value = value;
    el.params.value = value;
    // needed to update the text input
    $(el.params.inputEl).val(el.value);
  },

  _setChoices: function(el, choices) {
    // vals is required by setSource as global var.
    vals = choices;
    el.params.source = setSource;
  },

  // see updateF7AutoComplete
  receiveMessage: function(el, data) {
    var a = this.instances[el.id];
    // update choices
    if (data.hasOwnProperty('choices')) {
      this._setChoices(a, data.choices);
    }
    // Update value
    if (data.hasOwnProperty('value')) {
      this.setValue(a, data.value);
    }
    $(el).trigger('change');
  },

  subscribe: function(el, callback) {
    $(el).on("change.f7AutoCompleteBinding", function(e) {
      // we need a delay since shiny is faster than
      // the f7AutoComplete animation
      setTimeout(function() {
        callback();
      }, 10);
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7AutoCompleteBinding");
  }
});

Shiny.inputBindings.register(f7AutoCompleteBinding, 'f7.autocomplete');
