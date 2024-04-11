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
            'Oops... disconnected </br> </br> <button onclick="Shiny.shinyapp.reconnect();" style="margin:0" class="toast-button button color-green col">Reconnect</button><button onclick="location.reload();" style="margin:0" class="toast-button button color-red col">Reload</button>'
        })
        .open();

      $('.toast').css("z-index", "99999");

      // close toast whenever a choice is made ...
      $(".toast-button").on("click", function() {
        reconnectToast.close();
      });
    });
  };
