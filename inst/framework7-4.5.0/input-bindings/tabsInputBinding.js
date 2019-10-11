// Input binding
var f7TabsBinding = new Shiny.InputBinding();

$.extend(f7TabsBinding, {

  find: function(scope) {
    return $(scope).find(".tabs");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var activeTab = $(el).find(".tab-active").attr("data-value");
    return activeTab;
  },

  // see updateF7Tabs
  receiveMessage: function(el, data) {
    // create a variable to update the active tab
    console.log(data.selected);
    if (data.hasOwnProperty('selected')) {
      app.tab.show('#' + data.selected);
    }
  },

  subscribe: function(el, callback) {
    $(el).on("tab:show.f7TabsBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7TabsBinding");
  }
});

Shiny.inputBindings.register(f7TabsBinding);
