// Input binding
var f7MenuBinding = new Shiny.InputBinding();

$.extend(f7MenuBinding, {
  find: function(scope) {
    return $(scope).find(".menu-item-dropdown");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return $(el).hasClass("menu-item-dropdown-opened");
  },

  // see updateF7Popup
  receiveMessage: function(el, data) {
    var isOpened = $(el).hasClass("menu-item-dropdown-opened");
    if (!isOpened) {
      app.menu.open($(el));
    }
  },

  subscribe: function(el, callback) {
    $(el).on("menu:opened.f7MenuBinding menu:closed.f7MenuBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7MenuBinding");
  }
});

Shiny.inputBindings.register(f7MenuBinding, 'f7.menu');
