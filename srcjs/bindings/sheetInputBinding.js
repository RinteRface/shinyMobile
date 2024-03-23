import { getAppInstance } from "../init.js";

// Input binding
var f7SheetBinding = new Shiny.InputBinding();

$.extend(f7SheetBinding, {
  instances: [],
  initialize: function(el) {

    this.app = getAppInstance();

    // recover the inputId passed in the R function
    var id = $(el).attr("id");
    var config = JSON.parse($(el)
      .find("script[data-for='" + id + "']")
      .html());

    // add the id
    config.el = '#' + id;

    // this is to show shiny outputs in the sheet
    config.on = {
      open: function(target) {
        if (target.app.params.dark) {
          $(target.el).addClass("theme-dark");
        }
      },
      opened: function () {
        $(el).trigger('shown');
      }
    };

    // feed the create method
    this.instances[el.id] = this.app.sheet.create(config);
  },

  find: function(scope) {
    return $(scope).find(".sheet-modal");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return this.instances[el.id].opened;
  },

  // see updateF7Sheet
  receiveMessage: function(el, data) {
    var s = this.instances[el.id];
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

Shiny.inputBindings.register(f7SheetBinding, 'f7.sheet');

