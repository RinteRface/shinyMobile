// Input binding
var f7MessageBarBinding = new Shiny.InputBinding();

$.extend(f7MessageBarBinding, {

  initialize: function(el) {
    app.messagebar.create({
      el: '#' + $(el).attr('id')
    });
  },

  find: function(scope) {
    return $(scope).find(".messagebar");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return app.messagebar.get($(el)).getValue();
  },

  // see updatef7MessageBar
  setValue: function(el, value) {
    app.messagebar.get($(el)).setValue(value);
  },

  // see updatef7MessageBar
  receiveMessage: function(el, data) {
    this.setValue(el, data);
  },

  subscribe: function(el, callback) {
    $(el).on("change.f7MessageBarBinding focus.f7MessageBarBinding blur.f7MessageBarBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7MessageBarBinding");
  }
});

Shiny.inputBindings.register(f7MessageBarBinding);
