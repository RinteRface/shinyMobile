// Input binding
var f7FabsBinding = new Shiny.InputBinding();

$.extend(f7FabsBinding, {

  find: function(scope) {
    return $(scope).find(".fab");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var open = $(el).hasClass('fab-opened');
    return(open);
  },

  // see updateF7Fabs
  receiveMessage: function(el, data) {
    // update Fabs
    app.fab.toggle('#' + $(el).attr('id'));
  },

  subscribe: function(el, callback) {
    $(el).on("fab:open.f7FabsBinding fab:close.f7FabsBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7FabsBinding");
  }
});

Shiny.inputBindings.register(f7FabsBinding);

//$(document).on('click', 'a.f7-action-button', function(event) {
//  event.stopPropagation();
//});
