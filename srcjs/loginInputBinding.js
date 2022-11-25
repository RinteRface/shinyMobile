// Input binding
var f7LoginBinding = new Shiny.InputBinding();

$.extend(f7LoginBinding, {

  initialize: function(el) {
    // feed the create method
    var data = {};
    data.el = '#' + $(el).attr("id");
    // specify animate false since true involves
    // a significant delay before the modal shows up
    data.animate = false;
    data.on = {
      open: function(target) {
        if (target.app.params.dark) {
          $(target.el).addClass("theme-dark");
        }
      },
      opened: function () {
        $(el).trigger('shown');
      }
    };
    var l = app.loginScreen.create(data);
    // the login page should automatically open when inserted
    // unless the start-open property is disable. This may happen
    // for instance when one wants to trigger authentication only
    // for a specific section of the app.
    var startOpen = JSON.parse($(el).attr("data-start-open"))[0];
    if (startOpen) l.open();
  },

  find: function(scope) {
    return $(scope).find(".login-screen");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var l = app.loginScreen.get($(el));
    return l.opened;
  },

  // see updateF7Login
  receiveMessage: function(el, data) {
    var l = app.loginScreen.get($(el));
    if (l.opened) {
      // only close if valid password and user
      if (data.user.length > 0 && data.password.length > 0) {
        l.close();
      } else {
        app.dialog.alert('Please enter a valid password and user.');
      }
    } else {
      l.open();
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
