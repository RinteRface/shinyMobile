export const setCustomDisconnect = (app) => {
    // Custom disconnect screen
    $(document).on("shiny:connected", function(event) {
      Shiny.shinyapp.onDisconnected = function() {
        // Add gray-out overlay, if not already present
        let $overlay = $('#shiny-disconnected-overlay');
        if ($overlay.length === 0) {
          $(document.body).append('<div id="shiny-disconnected-overlay"></div>');
        }
      };
    });
  
    $(document).on("shiny:disconnected", function(event) {
      let reconnectToast = app.toast
        .create({
          position: "center",
          text:
            'Oups... disconnected </br> </br> <div class="row"><button onclick="Shiny.shinyapp.reconnect();" class="toast-button button color-green col">Reconnect</button><button onclick="location.reload();" class="toast-button button color-red col">Reload</button></div>'
        })
        .open();
  
      $('.toast').css("background-color", "#1c1c1d");
  
      // close toast whenever a choice is made ...
      $(".toast-button").on("click", function() {
        reconnectToast.close();
      });
    });
  }; 
