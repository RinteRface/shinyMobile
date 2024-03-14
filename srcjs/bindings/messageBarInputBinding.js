// Input binding
import { getAppInstance } from "../init.js";

var f7MessageBarBinding = new Shiny.InputBinding();

$.extend(f7MessageBarBinding, {

  initialize: function(el) {
    this.app = getAppInstance();
    this.app.messagebar.create({
      el: '#' + $(el).attr('id')
    });
  },

  // method to insert in the getValue method.
  // This will automatically enable/disable the
  // send button based on the current value.
  // It also returns the text area value
  setState: function(el) {
    var val = this.app.messagebar.get(el).getValue();
    var sendLink = $(el).find('#' + el.id + '-send');
    if (!val.length) {
      $(sendLink).addClass('disabled');
    } else {
      $(sendLink).removeClass('disabled');
    }
    return val;
  },

  find: function(scope) {
    return $(scope).find(".messagebar");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return this.setState(el);
  },

  // see updatef7MessageBar
  setValue: function(el, value) {
    this.app.messagebar.get(el).setValue(value);
  },

  setPlaceholder: function(el, value) {
    this.app.messagebar.get(el).setPlaceholder(value);
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
    $(el).on("input.f7MessageBarBinding change.f7MessageBarBinding focus.f7MessageBarBinding blur.f7MessageBarBinding", function(e) {
      // reset message bar textarea content when click on it
      $(el).find('#' + el.id + '-send').on('click', function() {
        // add delay between link click and textarea reset in f7MessageBar.
        // Needed to give time so that f7Messages receives
        // the textarea input value before it is cleared.
        setTimeout(function() {
          this.app.messagebar.get(el).clear().focus();
        }, 1000);
      });
      callback(true);
    });
  },

  getRatePolicy: function() {
    return {
      policy: 'debounce',
      delay: 250
    };
  },

  unsubscribe: function(el) {
    $(el).off(".f7MessageBarBinding");
  }
});

Shiny.inputBindings.register(f7MessageBarBinding, 'f7.messagebar');
