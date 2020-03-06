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

  setPlaceholder: function(el, value) {
    app.messagebar.get($(el)).setPlaceholder(value);
  },

  // see updatef7MessageBar
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty('value')) {
      this.setValue(el, data.value);
    }

    if (data.hasOwnProperty('placeholder')) {
      this.setPlaceholder(el, data.placeholder);
    }
  },

  subscribe: function(el, callback) {
    $(el).on("change.f7MessageBarBinding focus.f7MessageBarBinding blur.f7MessageBarBinding", function(e) {
      callback();
    });

    // reset message bar textarea content when click on it
    var sendLink = $(el).find('#' + el.id + '-send');
    $(sendLink).on('click', function() {
      var messagebar = app.messagebar.get($(el));
      var val = messagebar.getValue();
      // stop if no value in message bar
      if (!val.length) return;
      // add delay between link click and textarea reset in f7MessageBar.
      // Needed to give time so that f7Messages receives
      // the textarea input value before it is cleared.
      setTimeout(function() {
        messagebar.clear().focus();
      }, 10);
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7MessageBarBinding");
  }
});

Shiny.inputBindings.register(f7MessageBarBinding);
