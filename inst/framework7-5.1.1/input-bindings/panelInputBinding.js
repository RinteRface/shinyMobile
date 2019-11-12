// Input binding
var f7PanelBinding = new Shiny.InputBinding();

$.extend(f7PanelBinding, {

  initialize: function(el) {
    app.panel.create({
      el: '#' + $(el).attr('id')
    });
  },

  find: function(scope) {
    return $(scope).find(".panel");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var p = app.panel.get($(el));
    return p.opened;
  },

  // see updateF7Panel
  receiveMessage: function(el, data) {
    // create a variable to update the panel
    var p = app.panel.get($(el));
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
