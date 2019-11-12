// Input binding
var f7SheetBinding = new Shiny.InputBinding();

$.extend(f7SheetBinding, {

  initialize: function(el) {

    // recover the inputId passed in the R function
    var id = $(el).attr("id");
    // function to convert a string to variable
    function SetTo5(inputId, varString) {
      var res = eval(inputId + "_" + varString);
      return res;
    }

    app.sheet.create({
      el: '#' + id,
      swipeToClose: SetTo5(id, "swipeToClose"),
      swipeToStep: SetTo5(id, "swipeToStep"),
      backdrop: SetTo5(id, "backdrop"),
      closeByOutsideClick : SetTo5(id, "closeByOutsideClick"),
      on: {
        opened: function () {
          // tells shiny to show the content inside
          $(el).trigger('shown');
        }
      }
    });
  },

  find: function(scope) {
    return $(scope).find(".sheet-modal");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    var s = app.sheet.get($(el));
    return s.opened;
  },

  // see updateF7Sheet
  receiveMessage: function(el, data) {
    var s = app.sheet.get($(el));
    if (s.opened) {
      s.close();
    } else {
      s.open();
    }
  },

  subscribe: function(el, callback) {
    // need to subscribe after open and close
    // therefore we listen to opened and closed, respectively
    $(el).on("sheet:open.f7SheetBinding sheet:close.f7SheetBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7SheetBinding");
  }
});

Shiny.inputBindings.register(f7SheetBinding);

