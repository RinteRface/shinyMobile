// Input binding
var f7AutoCompleteBinding = new Shiny.InputBinding();

$.extend(f7AutoCompleteBinding, {

  initialize: function(el) {

    // recover the inputId passed in the R function
    var id = $(el).attr("id");
    // function to convert a string to variable
    function SetTo5(inputId, varString) {
      var res = eval(inputId + "_" + varString);
      return res;
    }

    var vals = SetTo5(id, "vals");
    var initVal = SetTo5(id, "val");
    var type = SetTo5(id, "type");

    // special case where the autocomplete is standalone
    var inputEl;
    var openerEl;
    var closeOnSelect;
    var typeahead;
    var expandInput;
    var dropdownPlaceholderText;
    var multiple;
    if (type == "dropdown") {
      inputEl = '#' + id;
      typeahead = SetTo5(id, "typeahead");
      expandInput = SetTo5(id, "expandInput");
      dropdownPlaceholderText = SetTo5(id, "dropdownPlaceholderText");
      openerEl = undefined;
      closeOnSelect = undefined;
      multiple = undefined;
    } else {
      inputEl = undefined;
      openerEl = '#' + id;
      closeOnSelect = true;
      typeahead = undefined;
      expandInput = undefined;
      dropdownPlaceholderText = undefined;
      multiple = SetTo5(id, "multiple");
    }
    // vals is a global variable defined in the UI side.
    // It contains an array of choices to populate
    // the autocomplete input.
    app.autocomplete.create({
      inputEl: inputEl,
      openerEl: openerEl,
      closeOnSelect: closeOnSelect,
      openIn: SetTo5(id, "type"),
      value: initVal,
      typeahead: typeahead,
      expandInput: expandInput,
      dropdownPlaceholderText: dropdownPlaceholderText,
      multiple: multiple, //allow multiple values
      source: function (query, render) {
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
      },
      // necessary for standalone autocomplete
      on: {
        change: function (value) {
          // Add item text value to item-after
          $('#' + id).find('.item-after').text(value[0]);
          // Add item value to input value
          $('#' + id).find('input').val(value[0]);
          // important: trigger change so that the input value
          // is updated for Shiny
          $('#' + id).trigger('change');
        }
      }
    });
  },

  find: function(scope) {
    return $(scope).find(".autocomplete-input");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var a = app.autocomplete.get($(el));
    console.log(a);
    return a.value;
  },

  // see updateF7AutoComplete
  setValue: function(el, value) {
    var a= app.autocomplete.get($(el));
    a.value = value;
    $(el).trigger('change');
  },

  // see updateF7AutoComplete
  receiveMessage: function(el, data) {
    //var a = app.autocomplete.get($(el));
    // update choices
    //if (data.hasOwnProperty('choices')) {

    //}
    // Update value
    if (data.hasOwnProperty('value')) {
      this.setValue(el, data.value);
    }
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

Shiny.inputBindings.register(f7AutoCompleteBinding);
