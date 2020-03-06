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
    var id = $(el).attr('id');
    var config = {};
    config.el = '#' + id;
    // First message rule
  config.firstMessageRule = function (message, previousMessage, nextMessage) {
    // Skip if title
    if (message.isTitle) return false;
    /* if:
      - there is no previous message
      - or previous message type (send/received) is different
      - or previous message sender name is different
    */
    if (!previousMessage || previousMessage.type !== message.type || previousMessage.name !== message.name) return true;
    return false;
  };

  // Last message rule
  config.lastMessageRule = function (message, previousMessage, nextMessage) {
    // Skip if title
    if (message.isTitle) return false;
    /* if:
      - there is no next message
      - or next message type (send/received) is different
      - or next message sender name is different
    */
    if (!nextMessage || nextMessage.type !== message.type || nextMessage.name !== message.name) return true;
    return false;
  };

  // Last message rule
  config.tailMessageRule = function (message, previousMessage, nextMessage) {
    // Skip if title
    if (message.isTitle) return false;
      /* if (bascially same as lastMessageRule):
      - there is no next message
      - or next message type (send/received) is different
      - or next message sender name is different
    */
    if (!nextMessage || nextMessage.type !== message.type || nextMessage.name !== message.name) return true;
    return false;
  };
    messages.destroy();
    var messages2 = app.messages.create(config);

    if (!data.text || !data.name || !data.type) return;

    messages2.showTyping({
      header: data.name + ' is typing',
      avatar: data.avatar
    });
    setTimeout(function() {
      messages2.addMessage(data);
      messages2.hideTyping();
    }, 1000);
  },

  subscribe: function(el, callback) {
    $(el).on("beforeDestroy.f7MessagesBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7MessagesBinding");
  }
});

Shiny.inputBindings.register(f7MessagesBinding);
