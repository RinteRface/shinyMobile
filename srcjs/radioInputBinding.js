let $escape = Shiny.$escape;

function updateLabel(labelTxt, labelNode) {
  // Only update if label was specified in the update method
  if (typeof labelTxt === "undefined") return;
  if (labelNode.length !== 1) {
    throw new Error("labelNode must be of length 1");
  }

  // Should the label be empty?
  var emptyLabel = $.isArray(labelTxt) && labelTxt.length === 0;

  if (emptyLabel) {
    labelNode.addClass("shiny-label-null");
  } else {
    labelNode.text(labelTxt);
    labelNode.removeClass("shiny-label-null");
  }

}

var radioInputBinding = new Shiny.InputBinding();
$.extend(radioInputBinding, {
  find: function(scope) {
    return $(scope).find('.shiny-input-radiogroup');
  },
  getValue: function(el) {
    // Select the radio objects that have name equal to the grouping div's id
    var checked_items = $('input:radio[name="' + $escape(el.id) + '"]:checked');

    if (checked_items.length === 0) {
      // If none are checked, the input will return null (it's the default on load,
      // but it wasn't emptied when calling updateRadioButtons with character(0)
      return null;
    }

    return checked_items.val();
  },
  setValue: function(el, value) {
    if ($.isArray(value) && value.length === 0) {
      // Removing all checked item if the sent data is empty
      $('input:radio[name="' + $escape(el.id) + '"]').prop('checked', false);
    } else {
      $('input:radio[name="' + $escape(el.id) + '"][value="' + $escape(value) + '"]').prop('checked', true);
    }

  },
  getState: function(el) {
    var $objs = $('input:radio[name="' + $escape(el.id) + '"]');

    // Store options in an array of objects, each with with value and label
    var options = new Array($objs.length);
    for (var i = 0; i < options.length; i++) {
      options[i] = { value:   $objs[i].value,
                     label:   this._getLabel($objs[i]) };
    }

    return {
      label:    this._getLabelNode(el).text(),
      value:    this.getValue(el),
      options:  options
    };
  },
  receiveMessage: function(el, data) {
    var $el = $(el);
    // This will replace all the options
    if (data.hasOwnProperty('options')) {
      // Clear existing options and add each new one
      $el.find('ul').remove();
      $el.append(data.options);
    }

    if (data.hasOwnProperty('value'))
      this.setValue(el, data.value);

    updateLabel(data.label, this._getLabelNode(el));

    $(el).trigger('change');
  },
  subscribe: function(el, callback) {
    $(el).on('change.radioInputBinding', function(event) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off('.radioInputBinding');
  },
  // Get the DOM element that contains the top-level label
  _getLabelNode: function(el) {
      return $(el).siblings('div.block-title');
  },
  // Given an input DOM object, get the associated label. Handles labels
  // that wrap the input as well as labels associated with 'for' attribute.
  _getLabel: function(obj) {
    // If <label><input /><span>label text</span></label>
    if (obj.parentNode.tagName === "LABEL") {
      return $(obj.parentNode).find('div.item-title').text().trim();
    }

    return null;
  },
  // Given an input DOM object, set the associated label. Handles labels
  // that wrap the input as well as labels associated with 'for' attribute.
  _setLabel: function(obj, value) {
    // If <label><input /><span>label text</span></label>
    if (obj.parentNode.tagName === "LABEL") {
      $(obj.parentNode).find('div.item-title').text(value);
    }

    return null;
  }

});
Shiny.inputBindings.register(radioInputBinding, 'shiny.radioInput');

