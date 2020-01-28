var f7ButtonInputBinding = new Shiny.InputBinding();
$.extend(f7ButtonInputBinding, {
  find: function(scope) {
    return $(scope).find(".f7-action-button");
  },
  getValue: function(el) {
    return $(el).data('val') || 0;
  },
  setValue: function(el, value) {
    $(el).data('val', value);
  },
  getType: function(el) {
    return 'shiny.action';
  },
  subscribe: function(el, callback) {
    $(el).on("click.f7ButtonInputBinding", function(e) {
      var $el = $(this);
      var val = $el.data('val') || 0;
      $el.data('val', val + 1);

      callback();
    });
  },
  getState: function(el) {
    return { value: this.getValue(el) };
  },
  receiveMessage: function(el, data) {
    var $el = $(el);

    // retrieve current label and icon
    var label = $el.text();

    // update the requested properties
    if (data.hasOwnProperty('label')) label = data.label;
    // produce new html
    $el.html(label);
  },
  unsubscribe: function(el) {
    $(el).off(".f7ButtonInputBinding");
  }
});
Shiny.inputBindings.register(f7ButtonInputBinding);


$(document).on('click', 'a.f7-action-button', function(e) {
  e.preventDefault();
});
