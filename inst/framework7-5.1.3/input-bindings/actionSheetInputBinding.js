// Input binding
var f7ActionSheetBinding = new Shiny.InputBinding();

$.extend(f7ActionSheetBinding, {

  find: function(scope) {
    //return $(scope).find(".actions-modal");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    //var s = app.actions.get($(el));
    //console.log(s);
    //return s.opened;
  },

  // see updateF7Sheet
  receiveMessage: function(el, data) {
    //var s = app.actions.get($(el));
    //if (s.opened) {
    //  s.close();
    //} else {
    //  s.open();
    //}
  },

  subscribe: function(el, callback) {
    // need to subscribe after open and close
    // therefore we listen to opened and closed, respectively
    //$(el).on("actions:open.f7ActionSheetBinding actions:close.f7ActionSheetBinding", function(e) {
    //  callback();
    //});
  },

  unsubscribe: function(el) {
    //$(el).off(".f7ActionSheetBinding");
  }
});

Shiny.inputBindings.register(f7ActionSheetBinding);

