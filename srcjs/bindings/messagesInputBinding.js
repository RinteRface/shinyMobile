// Input binding
import { getAppInstance } from "../init.js";

var f7MessagesBinding = new Shiny.InputBinding();

$.extend(f7MessagesBinding, {

  initialize: function(el) {
    this.app = getAppInstance();
    // for a proper layout!
    $('.page-content').addClass('messages-content');

    var id = $(el).attr('id');
    var config = $(el).find("script[data-for='" + id + "']");
    config = JSON.parse(config.html());

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

    // feed the create method
    this.app.messages.create(config);
  },

  find: function(scope) {
    return $(scope).find(".messages");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var messages = this.app.messages.get(el).messages;
    // Ignore the first message as it is set by the template
    messages = messages.slice(1);
    // Return an object of objects: will be a list of lists in R
    return messages.length > 0 ? { ...messages } : null;
  },

  // see updatef7Messages
  setValue: function(el, value) {
    var messages = this.app.messages.get(el);
    var message = value.value;
    // TO DO: does not work if TRUE
    if (value.showTyping) {
      // Show typing indicator
      var who = message.pop().name;
      messages.showTyping({
        header: who + ' is typing'
      });
      setTimeout(function () {
        messages.addMessages(message);
        // Hide typing indicator
        messages.hideTyping();
      }, 1000);
    } else {
      messages.addMessages(message);
    }
  },

  // see updatef7Messages
  receiveMessage: function(el, data) {
    this.setValue(el, data);
    $(el).trigger('change');
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

Shiny.inputBindings.register(f7MessagesBinding, 'f7.messages');
