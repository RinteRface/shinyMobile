// Input binding
var f7MessagesBinding = new Shiny.InputBinding();

$.extend(f7MessagesBinding, {

  initialize: function(el) {
    // for a proper layout!
    $('.page-content').addClass('messages-content');

    var id = $(el).attr('id');
    var config = $(el).find("script[data-for='" + id + "']");
    config = JSON.parse(config.html());

    config.el = '#' + id;
    // feed the create method
    var messages = app.messages.create(config);
    console.log(messages);
  },

  find: function(scope) {
    return $(scope).find(".messages");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return app.messages.get($(el)).messages;
  },

  // see updatef7Messages
  setValue: function(el, value) {

  },

  // see updatef7Messages
  receiveMessage: function(el, data) {
    var messages = app.messages.get($(el));
  },

  subscribe: function(el, callback) {
    $(el).on("change.f7MessagesBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7MessagesBinding");
  }
});

Shiny.inputBindings.register(f7MessagesBinding);
