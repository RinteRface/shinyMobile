// Input binding
var f7VirtualListBinding = new Shiny.InputBinding();

$.extend(f7VirtualListBinding, {

  initialize: function(el) {
    var id = $(el).attr('id');
    var config = $(el).find("script[data-for='" + id + "']");
    config = JSON.parse(config.html());

    config.el = '#' + id;

    // Custom search function for searchbar
    config.searchAll = function (query, items) {
      var found = [];
      for (var i = 0; i < items.length; i++) {
        if (items[i].title.toLowerCase().indexOf(query.toLowerCase()) >= 0 || query.trim() === '') found.push(i);
      }
      return found; //return array with mathced indexes
    };

    // feed the create method
    app.virtualList.create(config);
  },

  find: function(scope) {
    return $(scope).find(".virtual-list");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return app.virtualList.get($(el));
  },

  // see updatef7Messages
  setValue: function(el, value) {

  },

  // see updatef7Messages
  receiveMessage: function(el, data) {

  },

  subscribe: function(el, callback) {
    $(el).on("change.f7VirtualListBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7VirtualListBinding");
  }
});

Shiny.inputBindings.register(f7VirtualListBinding);
