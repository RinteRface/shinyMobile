// Input binding
var f7PanelBinding = new Shiny.InputBinding();

$.extend(f7PanelBinding, {

  initialize: function(el) {

    // recover the inputId passed in the R function
    var id = $(el).attr("id");
    // function to convert a string to variable
    function SetTo5(inputId, varString) {
      var res = eval(inputId + "_" + varString);
      return res;
    }

    // create the stepper to access API
    app.panel.create({
      el: el,
      side: SetTo5(id, "side"),
      effect: SetTo5(id , "effect"),
      resizable: SetTo5(id, "resizable")
    });

  },
  find: function(scope) {
    return $(scope).find(".panel");
  },

  // Given the DOM element for the input, return the value
  getValue: function(el) {
    return $(el)[0].f7Panel.opened;
  },

  // see updateF7Slider
  setValue: function(el, value) {

  },

  // see updateF7Slider
  receiveMessage: function(el, data) {
    // create a variable to update the range
  },

  subscribe: function(el, callback) {
    $(el).on("panel:open.f7PanelBinding panel:close.f7PanelBinding", function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off(".f7PanelBinding");
  }
});

Shiny.inputBindings.register(f7PanelBinding);
