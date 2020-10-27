library(shiny)
library(shinyMobile)

shinyApp(
  ui = f7Page(
    color = "pink",
    title = "Floating action buttons",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7Fabs"),
      tags$head(
        tags$script(
          "$(function() {
            // crash the socket
            $('#btn1').on('click', function(event) {
              Shiny.shinyapp.$sendMsg('plop');
            });

            var workerId = $('base').attr('href');
            // ensure that this code does not locally
            if (typeof workerId != 'undefined') {
              $(document).on('shiny:disconnected', function(event) {
                // remove shiny server stuff
                $('#ss-connect-dialog').hide();
                $('#ss-overlay').hide();
                // use Shiny internal tools
                Shiny.showReconnectDialog();
              });
            }
          });
        "
        )
      ),
      tags$a(
        type = "button",
        class = "f7-action-button",
        onclick = "Shiny.shinyapp.reconnect();",
        "Reconnect"
      ),

      f7Fabs(
        position = "center-center",
        color = "purple",
        sideOpen = "center",
        lapply(1:4, function(i) f7Fab(paste0("btn", i), i))
      ),
      lapply(1:4, function(i) verbatimTextOutput(paste0("res", i))),

    )
  ),
  server = function(input, output, session) {
    #session$allowReconnect("force")
    lapply(1:4, function(i) {
      output[[paste0("res", i)]] <- renderPrint(input[[paste0("btn", i)]])
    })
  }
)
