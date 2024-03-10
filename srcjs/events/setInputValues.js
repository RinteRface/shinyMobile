import Framework7 from 'framework7/bundle'

$(function() {
  // TO DO: remove?
  // From this we can recover the workerId and the sessionId. sessionId
  // is the same recovered on the server side with session$token.
  $(document).on("shiny:sessioninitialized", function(event) {
    Shiny.setInputValue("shinyInfo", Shiny.shinyapp.config);
  });

  // Returns the last input changed (name, value, type, ...)
  $(document).on("shiny:inputchanged", function(event) {
    var type;
    if (event.binding !== null) {
      type =
        event.binding.name !== undefined
          ? event.binding.name.split(".")[1]
          : "NA";
      Shiny.setInputValue("lastInputChanged", {
        name: event.name,
        value: event.value,
        type: type
      });
    }
  });

  // Framework7.device is extremely useful to set up custom design
  $(document).on("shiny:connected", function(event) {
    Shiny.setInputValue("deviceInfo", Framework7.device);
  });
});
