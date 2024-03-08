// Input binding
var f7CollapsibleBinding = new Shiny.InputBinding();

$.extend(f7CollapsibleBinding, {

  find: function(scope) {
    return $(scope).find(".collapsible");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var accordionId = $($(el)[0]).attr('id');
    var items = $('#' + accordionId + ' li.accordion-item-opened');
    if (items.length > 0) {
     // find title
     if (items.length === 1) {
      var val = $(items[0]).find('.item-title').html();
      return {state: true, value: val};
     } else {
       var titles = [];
       $(items).each(function(i) {
         titles.push($(items[i]).find('.item-title').html());
       });
       return {state: true, value: titles};
     }
    } else {
      return {state: false, value: null};
    }
  },

  // see updateF7Collapsible
  receiveMessage: function(el, data) {
    if (data.hasOwnProperty('selected')) {
      var accordionId = $($(el)[0]).attr('id');
      var items = $('#' + accordionId + ' .accordion-item');
      var idx = data.selected - 1;
      var target = $(items[idx])[0];
      app.accordion.toggle(target);
    }
  },

  subscribe: function(el, callback) {
    // need to subscribe after open and close
    // therefore we listen to opened and closed, respectively
    $(el).on("accordion:opened.f7CollapsibleBinding accordion:closed.f7CollapsibleBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7CollapsibleBinding");
  }
});

Shiny.inputBindings.register(f7CollapsibleBinding, 'f7.collapsible');
