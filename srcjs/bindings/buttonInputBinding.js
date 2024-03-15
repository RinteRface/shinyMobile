var f7ButtonInputBinding = new Shiny.InputBinding();

const btnStyle = ["tonal", "raised", "round", "fill", "outline"];

$.extend(f7ButtonInputBinding, {
  find: function(scope) {
    return $(scope).find(".f7-action-button");
  },
  getValue: function(el) {
    return $(el).data('val') || 0;
  },
  setValue: function(el, value) {
    $(el).data('val', value);
  },
  getType: function(el) {
    return 'shiny.action';
  },
  getState: function(el) {
    return { value: this.getValue(el) };
  },
  receiveMessage: function(el, data) {
    var $el = $(el);

    // update color
    if (data.hasOwnProperty("color")) {
      $(el).removeClass (function (index, className) {
    return (className.match (/(^|\s)color-\S+/g) || []).join(' ');
});
      $(el).addClass("color-" + data.color);
    }

    // update style props
    var self = this;
    btnStyle.map((s) => {
      self._updateStyleProp(el, data, s);
    })

    // update size
    if (data.hasOwnProperty("size")) {
      var isLarge = $(el).hasClass("button-large");
      var isSmall = $(el).hasClass("button-small");
      if (!isLarge && !isSmall) $(el).addClass("button-" + data.size);
      if (!isLarge && isSmall) {
        $(el).removeClass("button-small");
        $(el).addClass("button-" + data.size);
      }
      if (isLarge && !isSmall) {
        $(el).removeClass("button-large");
        $(el).addClass("button-" + data.size);
      }
    }

    // retrieve current label and icon
    var label = $el.text();

    // update the requested properties
    if (data.hasOwnProperty('label')) label = data.label;
    // produce new html
    $el.html(label);
  },
  subscribe: function(el, callback) {
    $(el).on("click.f7ButtonInputBinding", function(e) {
      var $el = $(this);
      var val = $el.data('val') || 0;
      $el.data('val', val + 1);

      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".f7ButtonInputBinding");
  },
  // Internal method to update button prop
  _updateStyleProp: function(el, data, prop) {
    if (data.hasOwnProperty(prop)) {
      var cl = "button-" + prop;
      var cond = $(el).hasClass(cl);
      if (data[prop]) {
        if (!cond) $(el).addClass(cl);
      } else {
        if (cond) $(el).removeClass(cl);
      }
    }
  }
});
Shiny.inputBindings.register(f7ButtonInputBinding, 'f7.button');

$(document).on('click', 'a.f7-action-button', function(e) {
  e.preventDefault();
});
