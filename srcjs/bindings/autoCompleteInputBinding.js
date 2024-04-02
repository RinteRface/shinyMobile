import { getAppInstance } from "../init.js";

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
    this.app = getAppInstance();
    // recover the inputId passed in the R function
    var id = $(el).attr("id");

    var config = JSON.parse($(el)
      .parent()
      .find("script[data-for='" + id + "']")
      .html());

    // special case where the autocomplete is standalone
    if (config.openIn == "dropdown") {
      config.inputEl = '#' + id;
    } else {
      config.openerEl = '#' + id;
    }

    vals = config.choices;
    config.source = setSource;

    // for popup and page so that shiny is aware about input change
    config.on = {
      change: function (value) {
        // Add item text value to item-after
        if (config.openIn !== "dropdown") {
          $('#' + id).find('.item-after').text(value);
          // Add item value to input value
          $('#' + id).find('input').val(value);
        }
        // important: trigger change so that the input value
        // is updated for Shiny
        $('#' + id).trigger('change');
      }
    };

    this.instances[id] = this.app.autocomplete.create(config);
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
