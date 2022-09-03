// Input binding
var f7PanelMenuBinding = new Shiny.InputBinding();

$.extend(f7PanelMenuBinding, {

  find: function(scope) {
    return $(scope).find(".panel-menu");
  },

  // This is necessary to activate the good tab at start.
  // If one tab is active, it has a tab-link-active class.
  // We then trigger the show function on that tab.
  // If no tab is active at start, the first tab is shown by default.
  initialize: function(el) {
    var firstPanelId = $(el).find("a").first().attr('data-tab');
    var panelActiveId = $(el).find("a.tab-link-active").attr('data-tab');
    if (panelActiveId !== undefined) {
      app.tab.show(panelActiveId);
    } else {
      app.tab.show(firstPanelId);
    }
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var activeTab = $(el)
      .find("a.tab-link-active")
      .attr('data-tab');

    if (activeTab !== undefined) {
      return activeTab.split('#')[1];
    } else {
      return null;
    }
  },

  // see updateF7Tabs
  receiveMessage: function(el, data) {
    // update the active tab
    if (data.hasOwnProperty('selected')) {
      app.tab.show('#' + data.ns + '-' + data.selected);
    }
  },

  subscribe: function(el, callback) {
    $(el).find("a").on("click.f7PanelMenuBinding", function(e) {
      $(this).trigger("shown");
        callback();
    });

    app.on("tabShow.f7PanelMenuBinding", function(tab) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7PanelMenuBinding");
  }
});

Shiny.inputBindings.register(f7PanelMenuBinding, 'f7.tabsMenu');
