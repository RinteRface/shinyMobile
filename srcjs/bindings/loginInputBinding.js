import { getAppInstance } from "../init.js";

// Input binding
var f7LoginBinding = new Shiny.InputBinding();

$.extend(f7LoginBinding, {
  instances: [],
  initialize: function(el) {
    // feed the create method
    this.app = getAppInstance();
    var config = {};
    config.el = '#' + $(el).attr("id");
    // specify animate false since true involves
    // a significant delay before the modal shows up
    config.animate = false;
    config.on = {
      open: function(target) {
        if (target.app.params.dark) {
          $(target.el).addClass("theme-dark");
        }
      },
      opened: function () {
        $(el).trigger('shown');
      }
    };
    this.instances[el.id] = this.app.loginScreen.create(config);
    // the login page should automatically open when inserted
    // unless the start-open property is disable. This may happen
    // for instance when one wants to trigger authentication only
    // for a specific section of the app.
    var startOpen = JSON.parse($(el).attr("data-start-open"))[0];
    if (startOpen) this.instances[el.id].open();
  },

  find: function(scope) {
    return $(scope).find(".login-screen");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return this.instances[el.id].opened;
  },

  // see updateF7Login
  receiveMessage: function(el, data) {
    if (this.instances[el.id].opened) {
      // only close if valid password and user
      if (data.user.length > 0 && data.password.length > 0) {
        this.instances[el.id].close();
      } else {
        this.app.dialog.alert('Please enter a valid password and user.');
      }
    } else {
      this.instances[el.id].open();
    }
  },

  subscribe: function(el, callback) {
    $(el).on("loginscreen:opened.f7LoginBinding loginscreen:closed.f7LoginBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7LoginBinding");
  }
});

Shiny.inputBindings.register(f7LoginBinding, 'f7.login');
