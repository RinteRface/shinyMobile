var f7TreeviewBinding = new Shiny.InputBinding();

$.extend(f7TreeviewBinding, {

  initialize: function(el) {
    var id = $(el).attr("id");
    var config = $(el).find("script[data-for='" + id + "']");
    this.config = JSON.parse(config.html());

    if (this.config.selectable) {
      // add class to treeview-item-root
      $(el).find(".treeview-item-root").addClass("treeview-item-selectable");

      // add click event to treeview-item-selectable class
      $(el).on("click", ".treeview-item-selectable", function(e) {
        var $targetEl = $(e.target);
        if ($targetEl.closest(".treeview-item-selected").length) return;
        if ($targetEl.is(".treeview-toggle")) return;
        $targetEl
          .parents(".treeview")
          .find(".treeview-item-selected")
          .removeClass("treeview-item-selected");
        $targetEl
          .closest(".treeview-item-selectable")
          .addClass("treeview-item-selected");
      });
    }
  },

  find: function(scope) {
    return $(scope).find(".treeview");
  },

  getValue: function(el) {
    if (this.config.selectable) {
      var selected = $(el).find(".treeview-item-selected");
      if (selected.length) {
        return selected.find(".treeview-item-label").text();
      }
    }
  },

  setValue: function(el, value) {
    // JS code to set value
  },

  receiveMessage: function(el, data) {
    // this.setValue(el, data);
  },

  subscribe: function(el, callback) {
    $(el).on("click.treeview", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".treeview");
  }

});

Shiny.inputBindings.register(f7TreeviewBinding, "shinyMobile.f7TreeviewBinding");
