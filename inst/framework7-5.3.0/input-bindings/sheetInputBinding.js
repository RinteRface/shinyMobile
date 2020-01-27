// Input binding
var f7SheetBinding = new Shiny.InputBinding();

$.extend(f7SheetBinding, {

  initialize: function(el) {

    // recover the inputId passed in the R function
    var id = $(el).attr("id");

    var data = {};
    [].forEach.call(el.attributes, function(attr) {
      if (/^data-/.test(attr.name)) {
        var camelCaseName = attr.name.substr(5).replace(/-(.)/g, function ($0, $1) {
          return $1.toUpperCase();
        });
        // convert "true" to true and "false" to false
        var isTrueSet = (attr.value == "true");
        data[camelCaseName] = isTrueSet;
      }
    });

    // add the id
    data.el = '#' + id;

    // this is to show shiny outputs in the sheet
    data.on = {
      opened: function () {
        $(el).trigger('shown');
      }
    };

    // feed the create method
    var s = app.sheet.create(data);
  },

  find: function(scope) {
    return $(scope).find(".sheet-modal");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var s = app.sheet.get($(el));
    return s.opened;
  },

  // see updateF7Sheet
  receiveMessage: function(el, data) {
    var s = app.sheet.get($(el));
    if (s.opened) {
      s.close();
    } else {
      s.open();
    }
  },

  subscribe: function(el, callback) {
    // need to subscribe after open and close
    // therefore we listen to opened and closed, respectively
    $(el).on("sheet:open.f7SheetBinding sheet:close.f7SheetBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7SheetBinding");
  }
});

Shiny.inputBindings.register(f7SheetBinding);

