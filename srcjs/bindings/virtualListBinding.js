import { getAppInstance } from "../init.js";

// Input binding
var f7VirtualListBinding = new Shiny.InputBinding();

$.extend(f7VirtualListBinding, {

  // decode html so that images tag are converted to strings
  decodeHTML: function(html) {
    var txt = document.createElement("textarea");
    txt.innerHTML = html;
    return txt.value;
  },

  initialize: function(el) {
    this.app = getAppInstance();
    var id = $(el).attr("id");
    var config = $(el).find("script[data-for='" + id + "']");
    config = JSON.parse(config.html());

    config.el = "#" + id;

    var self = this; // Store reference to 'this'

    // treat all item images
    for (var item of config.items) {
      if (item.media.length > 0) {
        item.media =
          '<div class="item-media">' + self.decodeHTML(item.media) + "</div>";
      }
    }

    // Function to render each item
    function renderItem(item) {
      var media =
        item.media.length > 0
          ? '<div class="item-media">' + item.media + "</div>"
          : "";
      var template =
        media +
        '<div class="item-inner">' +
        '<div class="item-title-row">' +
        '<div class="item-title">' +
        '<div class="item-header">' +
        (item.header === undefined ? "" : item.header) +
        "</div>" +
        (item.title === undefined ? "" : item.title) +
        '<div class="item-footer">' +
        (item.footer === undefined ? "" : item.footer) +
        "</div>" +
        "</div>" +
        '<div class="item-after">' +
        (item.right === undefined ? "" : item.right) +
        "</div>" +
        "</div>" +
        '<div class="item-subtitle">' +
        (item.subtitle === undefined ? "" : item.subtitle) +
        "</div>" +
        '<div class="item-text">' +
        (item.content === undefined ? "" : item.content) +
        "</div>" +
        "</div>" +
        "</div>";

      if (item.url === undefined) {
        return (
          "<li>" +
          '<div class="item-content" id=' + (item.id === undefined ? "" : item.id) + '>' +
          template +
          "</li>"
        );
      } else {
        return (
          "<li>" +
          '<a class="item-link item-content external" href="' +
          item.url +
          '" target="_blank" id=' + (item.id === undefined ? "" : item.id) + '>' +
          template +
          "</a>" +
          "</li>"
        );
      }
    }

    config.renderItem = renderItem;

    // Custom search function for searchbar
    config.searchAll = function(query, items) {
      var found = [];
      for (var i = 0; i < items.length; i++) {
        if (
          items[i].title.toLowerCase().indexOf(query.toLowerCase()) >= 0 ||
          query.trim() === ""
        )
          found.push(i);
      }
      return found; //return array with mathced indexes
    };

    // Item height
    config.height =
      config.items[0].media !== undefined
        ? this.app.theme === "ios"
          ? 112
          : this.app.theme === "md"
          ? 132
          : 78
        : this.app.theme === "ios"
        ? 63
        : this.app.theme === "md"
        ? 73
        : 46;

    // feed the create method
    this.app.virtualList.create(config);
  },

  find: function(scope) {
    return $(scope).find(".virtual-list");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var vl = this.app.virtualList.get(el);
    return {
      length: vl.items.length,
      current_from: vl.currentFromIndex + 1,
      current_to: vl.currentToIndex + 1,
      reach_end: vl.reachEnd
    };
  },

  // see updateF7VirtualList
  setValue: function(el, value) {
    var vl = this.app.virtualList.get(el);
    vl.resetFilter();

    var addImageWrapper = function(items) {
      var temp;
      // handle single item
      if (items.length === undefined) {
        temp = `<div class="item-media">${items.media}</div>`;
        items.media = temp;
      } else {
        for (var i = 0; i < items.length; i++) {
          temp = `<div class="item-media">${items[i].media}</div>`;
          items[i].media = temp;
        }
      }
      return items;
    };

    switch (value.action) {
      case "appendItem":
        vl.appendItem(addImageWrapper(value.item));
        break;
      case "prependItem":
        vl.prependItem(addImageWrapper(value.item));
        break;
      case "appendItems":
        vl.appendItems(addImageWrapper(value.items));
        break;
      case "prependItems":
        vl.prependItems(addImageWrapper(value.items));
        break;
      case "replaceItem":
        vl.replaceItem(value.index, value.item);
        break;
      case "replaceAllItems":
        vl.replaceAllItems(value.items);
        break;
      case "moveItem":
        vl.moveItem(value.oldIndex, value.newIndex);
        break;
      case "insertItemBefore":
        vl.insertItemBefore(value.index, addImageWrapper(value.item));
        break;
      case "filterItems":
        vl.filterItems(value.indexes);
        break;
      case "deleteItem":
        vl.deleteItem(value.index);
        break;
      case "deleteAllItems":
        vl.deleteAllItems(value.indexes);
        break;
      case "scrollToItem":
        vl.scrollToItem(value.index);
        break;
      default:
    }

    $(el).trigger("change");
  },

  // see updateF7VirtualList
  receiveMessage: function(el, data) {
    this.setValue(el, data);
  },

  subscribe: function(el, callback) {
    $(el).on("change.f7VirtualListBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7VirtualListBinding");
  }
});

Shiny.inputBindings.register(f7VirtualListBinding, "f7.virtuallist");

