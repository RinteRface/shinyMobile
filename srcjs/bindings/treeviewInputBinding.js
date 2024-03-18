var f7TreeviewBinding = new Shiny.InputBinding();

$.extend(f7TreeviewBinding, {

  initialize: function(el) {
    var id = $(el).attr("id");
    var config = $(el).find("script[data-for='" + id + "']");

    // init config so we can store config for each treeview
    if (!this.config) {
      this.config = {};
    }

    this.config[id] = JSON.parse(config.html());

    if (this.config[id].selectable) {
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
        // trigger change so value gets updated
        $(el).trigger("change");
      });
    }

    if (this.config[id].withCheckbox) {
      $(el).find(".treeview-item-content").each(function() {
        var checkbox = $("<label class='checkbox'><input type='checkbox'><i class='icon-checkbox'></i></label>");
        $(this).prepend(checkbox);
      });

        // make sure child elements are automatically checked/unchecked
      $(el).find('input[type="checkbox"]').on('change', function (e) {
        var $rootEl = $(e.target).closest('.treeview-item-root');
        var $itemEl = $rootEl.parent('.treeview-item');
        var $childrenCheckboxes = $itemEl.find('.treeview-item-children input[type="checkbox"]');
        var $parentItemEl = $itemEl.parents('.treeview-item');
        var $parentCheckbox = $parentItemEl.children('.treeview-item-root').find('input[type="checkbox"]');
        if ($childrenCheckboxes.length) {
          $childrenCheckboxes.prop('checked', e.target.checked);
        }
        if ($parentItemEl) {
          var checkedChildren = $parentItemEl.find('.treeview-item-children input[type="checkbox"]:checked').length;
          $parentCheckbox.prop('checked', checkedChildren > 0);
          $parentCheckbox.prop('indeterminate', checkedChildren === 1);
        }
      });
    }

  },

  find: function(scope) {
    return $(scope).find(".treeview");
  },

  getValue: function(el) {
    var id = $(el).attr("id");

    if (this.config[id].selectable) {
      var selected = $(el).find(".treeview-item-selected");
      if (selected.length) {
        return selected.find(".treeview-item-label").text();
      }
    }

    if (this.config[id].withCheckbox) {
      // only return values of checked children (under treeview-item-children class)
      var checked = $(el).find(".treeview-item-children input[type='checkbox']:checked");
      var values = [];
      checked.each(function() {
        values.push($(this).closest(".treeview-item-content").find(".treeview-item-label").text());
      });
      return values;
    }
  },

  setValue: function(el, value) {
    // JS code to set value
  },

  receiveMessage: function(el, data) {
    // this.setValue(el, data);
  },

  subscribe: function(el, callback) {
    $(el).on("change.treeview", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".treeview");
  }

});

Shiny.inputBindings.register(f7TreeviewBinding, "shinyMobile.f7TreeviewBinding");
