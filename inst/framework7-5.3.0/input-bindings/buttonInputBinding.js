var f7ButtonInputBinding = new Shiny.InputBinding();
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
  subscribe: function(el, callback) {
    $(el).on("click.f7ButtonInputBinding", function(e) {
      var $el = $(this);
      var val = $el.data('val') || 0;
      $el.data('val', val + 1);

      callback();
    });
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

    // update fill
    if (data.hasOwnProperty("fill")) {
      var isFilled = $(el).hasClass("button-fill");
      if (data.fill) {
        if (!isFilled) $(el).addClass("button-fill");
      } else {
        if (isFilled) $(el).removeClass("button-fill");
      }
    }

    // update outline
    if (data.hasOwnProperty("outline")) {
      var isOutline = $(el).hasClass("button-outline");
      if (data.outline) {
        if (!isOutline) $(el).addClass("button-outline");
      } else {
        if (isOutline) $(el).removeClass("button-outline");
      }
    }

    // update raided
    if (data.hasOwnProperty("shadow")) {
      var isRaised = $(el).hasClass("button-raised");
      if (data.shadow) {
        if (!isRaised) $(el).addClass("button-raised");
      } else {
        if (isRaised) $(el).removeClass("button-raised");
      }
    }

    // update rounded
    if (data.hasOwnProperty("rounded")) {
      var isRounded = $(el).hasClass("button-round");
      if (data.rounded) {
        if (!isRounded) $(el).addClass("button-round");
      } else {
        if (isRounded) $(el).removeClass("button-round");
      }
    }

    // update size
    if (data.hasOwnProperty("size")) {
      var isLarge = $(el).hasClass("button-large");
      var isSmall = $(el).hasClass("button-small");
      if (!isLarge & !isSmall) $(el).addClass("button-" + data.size);
      if (!isLarge & isSmall) {
        $(el).removeClass("button-small");
        $(el).addClass("button-" + data.size);
      }
      if (isLarge & !isSmall) {
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
  unsubscribe: function(el) {
    $(el).off(".f7ButtonInputBinding");
  }
});
Shiny.inputBindings.register(f7ButtonInputBinding);


$(document).on('click', 'a.f7-action-button', function(e) {
  e.preventDefault();
});
