// Input binding
var f7PanelBinding = new Shiny.InputBinding();

$.extend(f7PanelBinding, {

  find: function(scope) {
    return $(scope).find(".panel");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var p = $(el)[0];
    return p.f7Panel.opened;
  },

  // see updateF7Panel
  receiveMessage: function(el, data) {
    // create a variable to update the panel
    var p = $(el)[0].f7Panel;
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

Shiny.inputBindings.register(f7PanelBinding);
