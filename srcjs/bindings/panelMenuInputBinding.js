import { getAppInstance } from "../init.js";

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
    this.app = getAppInstance();
    var firstPanelId = $(el).find("a").first().data('tab');
    var panelActiveId = $(el).find("a.tab-link-active").data('tab');
    if (panelActiveId !== undefined) {
      this.app.tab.show(panelActiveId);
    } else {
      this.app.tab.show(firstPanelId);
    }
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var activeTab = $(el)
      .find("a.tab-link-active")
      .data('tab');

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
      this.app.tab.show('#' + data.ns + '-' + data.selected);
    }
  },

  subscribe: function(el, callback) {
    $(el).find("a").on("click.f7PanelMenuBinding", function(e) {
      // make sure the clicked element has a tab-link-active class
      // if not, add it, and remove tab-link-active from other tabs
      // this hapens when f7PanelMenu is inside f7Panel
      if (!$(this).hasClass("tab-link-active")) {
        $(el).find("a").removeClass("tab-link-active");
        $(this).addClass("tab-link-active");
      }

      $($(this).data("tab")).trigger("shown");
        callback(false);
    });

    this.app.on("tabShow.f7PanelMenuBinding", function(tab) {
      callback(false);
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7PanelMenuBinding");
  }
});

Shiny.inputBindings.register(f7PanelMenuBinding, 'f7.tabsMenu');
