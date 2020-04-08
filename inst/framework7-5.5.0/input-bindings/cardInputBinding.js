// Input binding
var f7CardBinding = new Shiny.InputBinding();

$.extend(f7CardBinding, {

  find: function(scope) {
    return $(scope).find(".card-expandable");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var open = $(el).hasClass('card-opened');
    return open;
  },

  // see updateF7Card
  receiveMessage: function(el, data) {
    app.card.toggle($(el));
  },

  subscribe: function(el, callback) {
    // need to subscribe after open and close
    // therefore we listen to opened and closed, respectively
    $(el).on("card:opened.f7CardBinding card:closed.f7CardBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7CardBinding");
  }
});

Shiny.inputBindings.register(f7CardBinding, 'f7.card');

