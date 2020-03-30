// Input binding
var f7VirtualListBinding = new Shiny.InputBinding();

$.extend(f7VirtualListBinding, {

  initialize: function(el) {
    var id = $(el).attr('id');
    var config = $(el).find("script[data-for='" + id + "']");
    config = JSON.parse(config.html());

    config.el = '#' + id;

    var template;
    var media;
    if (config.items[0].media.length > 0) {
      media = `<div class="item-media"><img src='${config.items[0].media}'></div>`;
    } else {
      media = '';
    }
    if (config.items[0].url === undefined) {
        template = '<li>' +
  '<div class="item-content">' +
    media +
    '<div class="item-inner">' +
      '<div class="item-title-row">' +
        '<div class="item-title">' +
          '<div class="item-header">{{header}}</div>' +
          '{{title}}' +
          '<div class="item-footer">{{footer}}</div>' +
        '</div>' +
        '<div class="item-after">{{right}}</div>' +
      '</div>' +
      '<div class="item-subtitle">{{subtitle}}</div>' +
      '<div class="item-text">{{content}}</div>' +
    '</div>' +
  '</div>' +
'</li>';
      } else {
        template = '<li>' +
  '<a class="item-link item-content external" href="url" target="_blank">' +
    '<div class="item-media"><img src={{media}}></div>' +
    '<div class="item-inner">' +
      '<div class="item-title-row">' +
        '<div class="item-title">' +
          '<div class="item-header">{{header}}</div>' +
          '{{title}}' +
          '<div class="item-footer">{{footer}}</div>' +
        '</div>' +
        '<div class="item-after">{{right}}</div>' +
      '</div>' +
      '<div class="item-subtitle">{{subtitle}}</div>' +
      '<div class="item-text">{{content}}</div>' +
    '</div>' +
  '</a>' +
'</li>';
      }
    config.itemTemplate = template;

    // Custom search function for searchbar
    config.searchAll = function (query, items) {
      var found = [];
      for (var i = 0; i < items.length; i++) {
        if (items[i].title.toLowerCase().indexOf(query.toLowerCase()) >= 0 || query.trim() === '') found.push(i);
      }
      return found; //return array with mathced indexes
    };

    // Item height
  config.height = app.theme === 'ios' ? 63 : (app.theme === 'md' ? 73 : 46);

    // feed the create method
    app.virtualList.create(config);
  },

  find: function(scope) {
    return $(scope).find(".virtual-list");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    //return app.virtualList.get($(el)).items;
  },

  // see updatef7Messages
  setValue: function(el, value) {

  },

  // see updatef7Messages
  receiveMessage: function(el, data) {

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

Shiny.inputBindings.register(f7VirtualListBinding);
