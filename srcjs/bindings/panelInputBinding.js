import { getAppInstance } from "../init.js";

// Input binding
var f7PanelBinding = new Shiny.InputBinding();

$.extend(f7PanelBinding, {
  instances: [],
  initialize: function(el) {
    this.app = getAppInstance();
    var id = $(el).attr('id');
    var config = {};
    config = JSON.parse($(el)
      .find("script[data-for='" + id + "']")
      .html());
    // add id
    config.el = '#' + id;

    // this is to show shiny outputs in the sheet
    config.on = {
      opened: function () {
        $(el).trigger('shown');
      }
    };
    this.instances[el.id] = this.app.panel.create(config);
  },

  find: function(scope) {
    return $(scope).find(".panel");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return this.instances[el.id].opened;
  },

  // see updateF7Panel
  receiveMessage: function(el, data) {
    // create a variable to update the panel
    var p = this.instances[el.id];
    p.toggle(p.side);
  },

  subscribe: function(el, callback) {
    $(el).on("panel:open.f7PanelBinding panel:close.f7PanelBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7PanelBinding");
  }
});

Shiny.inputBindings.register(f7PanelBinding, 'f7.panel');
