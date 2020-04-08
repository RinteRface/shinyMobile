// Input binding
var f7TabsBinding = new Shiny.InputBinding();

$.extend(f7TabsBinding, {

  find: function(scope) {
    return $(scope).find(".tabs");
  },

  getId: function(el) {
    return Shiny.InputBinding.prototype.getId.call(this, el) || el.name;
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var activeTab;
    if ($(el).hasClass('standalone')) {
      activeTab = $(el).find(".tab-active");
    } else {
      activeTab = $(el).find(".page-content.tab-active");
    }
    // below to handle hidden tabs
    // the android highlight bar must not be
    // present since hidden tabs are not part of
    // the menu.
    if ($(activeTab).data('hidden')) {
      $('.tab-link-highlight').hide();
    } else {
      $('.tab-link-highlight').show();
    }
    return $(activeTab).attr("data-value");
  },

  // see updateF7Tabs
  receiveMessage: function(el, data) {
    // update the active tab
    if (data.hasOwnProperty('selected')) {
      app.tab.show('#' + data.ns + '-' + data.selected);
    }
  },

  subscribe: function(el, callback) {
    $(el).on("tab:show.f7TabsBinding", function(e) {
      $(el).trigger('shown');
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7TabsBinding");
  }
});

Shiny.inputBindings.register(f7TabsBinding, 'f7.tabs');
