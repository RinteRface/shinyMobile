import { getAppInstance } from "../init.js";

// Input binding
var f7PanelBinding = new Shiny.InputBinding();

$.extend(f7PanelBinding, {
  instances: [],
  initialize: function(el) {
    this.app = getAppInstance();
    var id = $(el).attr('id');
    var config = JSON.parse($(el)
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

    if ($(el).parent().hasClass('split-layout')) {

      // if parent class is split-layout, add visibleBreakpoint
      // makes the left panel always visible on tablets and desktop
      if ($(el).hasClass('panel-left')) {
        if (!config.visibleBreakpoint) {
          config.visibleBreakpoint = 1024;
        }
      }

      // add event listener on backdrop click that closes the panel
      // this is a necessary workaround because the panel does not close
      // in the split layout when clicking on the backdrop
      $(el).parent().find('.panel-backdrop').on('click', function() {
        app.panel.get(config.el).close();
      });
    }

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
