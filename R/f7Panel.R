#' Framework7 panel
#'
#' \code{f7Panel} is a sidebar element. It may be used as a simple
#' sidebar or as a container for \link{f7PanelMenu} in case of
#' \link{f7SplitLayout}.
#'
#' @param ... Panel content. Slot for \link{f7PanelMenu}, if used as a sidebar.
#' @param id Panel unique id. This is to access the input$id giving the panel
#' state, namely open or closed.
#' @param title Panel title.
#' @param side Panel side: "left" or "right".
#' @param theme Panel background color: "dark" or "light".
#' @param effect Whether the panel should behave when opened: "cover" or "reveal".
#' @param resizable Whether to enable panel resize. FALSE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @rdname panel
#'
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Panels",
#'      f7SingleLayout(
#'        navbar = f7Navbar(
#'          title = "Single Layout",
#'          hairline = FALSE,
#'          shadow = TRUE,
#'          leftPanel = TRUE,
#'          rightPanel = TRUE
#'        ),
#'        panels = tagList(
#'          f7Panel(side = "left", id = "mypanel1"),
#'          f7Panel(side = "right", id = "mypanel2")
#'        ),
#'        toolbar = f7Toolbar(
#'          position = "bottom",
#'          icons = TRUE,
#'          hairline = FALSE,
#'          shadow = FALSE,
#'          f7Link(label = "Link 1", href = "https://www.google.com"),
#'          f7Link(label = "Link 2", href = "https://www.google.com")
#'        ),
#'        # main content
#'        f7Shadow(
#'          intensity = 10,
#'          hover = TRUE,
#'          f7Card(
#'            title = "Card header",
#'            sliderInput("obs", "Number of observations", 0, 1000, 500),
#'            h1("You only see me by opening the left panel"),
#'            plotOutput("distPlot"),
#'            footer = tagList(
#'              f7Button(color = "blue", label = "My button", href = "https://www.google.com"),
#'              f7Badge("Badge", color = "green")
#'            )
#'          )
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      observeEvent(input$mypanel2, {
#'
#'        state <- if (input$mypanel2) "open" else "closed"
#'
#'        f7Toast(
#'          text = paste0("Right panel is ", state),
#'          position = "center",
#'          closeTimeout = 1000,
#'          closeButton = FALSE
#'        )
#'      })
#'
#'      output$distPlot <- renderPlot({
#'        if (input$mypanel1) {
#'          dist <- rnorm(input$obs)
#'          hist(dist)
#'        }
#'      })
#'    }
#'  )
#' }
f7Panel <- function(..., id = NULL, title = NULL,
                    side = c("left", "right"), theme = c("dark", "light"),
                    effect = c("reveal", "cover"), resizable = FALSE) {

  side <- match.arg(side)
  effect <- match.arg(effect)
  theme <- match.arg(theme)
  panelCl <- sprintf("panel panel-%s panel-%s theme-%s", side, effect, theme)
  if (resizable) panelCl <- paste0(panelCl, " panel-resizable")

  items <- list(...)
  items <- lapply(seq_along(items), function(i) {
    if (length(items[[i]]) > 1) {
      item <- items[[i]][[1]]
      if (class(item) == "shiny.tag") items[[i]] else f7Block(items[[i]])
    } else {
      if (class(items[[i]]) == "shiny.tag") items[[i]] else f7Block(items[[i]])
    }

  })

  panelTag <- shiny::tags$div(
    class = panelCl,
    id = id,
    shiny::tags$div(
      class = "page",
      # Panel Header
      shiny::tags$div(
        class = "navbar",
        shiny::tags$div(
          class = "navbar-inner",
          shiny::tags$div(class = "title", title)
        )
      ),
      # Panel content
      shiny::tags$div(
        class = "panellayout page-content",
        items
      )
    )
  )

  f7Shadow(panelTag, intensity = 24)

}



#' Framework7 sidebar menu
#'
#' \code{f7PanelMenu} creates a menu for \link{f7Panel}. It may contain
#' multiple \link{f7PanelItem}.
#'
#' @param ... Slot for \link{f7PanelItem}.
#' @param id Unique id to access the currently selected item.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @rdname panelmenu
#'
#' @export
f7PanelMenu <- function(..., id = NULL) {

  if (is.null(id)) id <- paste0("panelMenu_", round(stats::runif(1, min = 0, max = 1e9)))

  panelMenuJS <- shiny::singleton(
    shiny::tags$script(
      paste0(
        "
        // This function is necessary to activate the good tab at start.
        // If one tab is active, it has a data-active attribute set to true.
        // We then trigger the show function on that tab.
        // If no tab is active at start, the first tab is shown by default.
        $(function() {
          var firstPanel = $('#", id," li:eq(0)');
          var panelActiveId = $('#", id," a.tab-link-active').attr('data-tab');
          if (panelActiveId != undefined) {
            app.tab.show(panelActiveId);
          } else {
            app.tab.show('#' + firstPanelId);
          }
        });

        // Below is necessary to set the input value for shiny
        $(document).on('shiny:sessioninitialized', function() {
          // trigger a click on the window at start
          // to be sure that the input value is setup
          setTimeout(function() {
            $(window).trigger('click');
          }, 10);

          // Below is to handle the case where tabs are swipeable
          // Swiping left or right does not trigger any click by default.
          // Therefore, we need to trigger a click to update the shiny input.
          app.on('tabShow', function() {
           $(window).trigger('click');
          });

          // update the input value
          $(window).on('click', function(e) {
           var selectedPanelVal = $('#", id," a.tab-link-active').attr('data-tab');
           var selectedPanelVal = selectedPanelVal.split('#')[1];
           Shiny.setInputValue('", id, "', selectedPanelVal);
          });
        });
        "
      )
    )
  )

  shiny::tagList(
    panelMenuJS,
    shiny::tags$div(
      class = "list links-list",
      shiny::tags$ul(..., id = id)
    )
  )
}




#' Framework7 sidebar menu item
#'
#' \code{f7PanelItem} creates a Framework7 sidebar menu item for \link{f7SplitLayout}.
#'
#' @param title Item name.
#' @param tabName Item unique tabName. Must correspond to what is passed to
#' \link{f7Item}.
#' @param icon Item icon.
#' @param active Whether the item is active at start. Default to FALSE.
#'
#' @rdname panelmenu
#'
#' @export
f7PanelItem <- function(title, tabName, icon = NULL, active = FALSE) {
  shiny::tags$li(
    # generate the link
    if (!is.null(icon)) {
      shiny::a(
        `data-tab`= paste0("#", tabName),
        class = if (active) "tab-link tab-link-active" else "tab-link",
        icon,
        shiny::span(class = "tabbar-label", title)
      )
    } else {
      shiny::a(
        `data-tab` = paste0("#", tabName),
        class = if (active) "tab-link tab-link-active" else "tab-link",
        title
      )
    }
  )
}





#' Update Framework7 panel
#'
#' \code{updateF7Panel} toggles an \link{f7Panel} from the server.
#'
#' @param id Panel unique id.
#' @param session Shiny session object.
#' @rdname panel
#'
#' @export
#'
#' @examples
#' # Toggle panel
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Update panel menu",
#'      f7SingleLayout(
#'        navbar = f7Navbar(
#'          title = "Single Layout",
#'          hairline = FALSE,
#'          shadow = TRUE,
#'          leftPanel = TRUE,
#'          rightPanel = TRUE
#'        ),
#'        panels = tagList(
#'          f7Panel(side = "left", id = "mypanel1", theme = "light", effect = "cover"),
#'          f7Panel(side = "right", id = "mypanel2", theme = "light")
#'        ),
#'        toolbar = f7Toolbar(
#'          position = "bottom",
#'          icons = TRUE,
#'          hairline = FALSE,
#'          shadow = FALSE,
#'          f7Link(label = "Link 1", href = "https://www.google.com"),
#'          f7Link(label = "Link 2", href = "https://www.google.com")
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      observe({
#'        print(
#'          list(
#'            panel1 = input$mypanel1,
#'            panel2 = input$mypanel2
#'          )
#'        )
#'      })
#'
#'      observe({
#'        invalidateLater(2000)
#'        updateF7Panel(id = "mypanel1")
#'      })
#'
#'    }
#'  )
#' }
updateF7Panel <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(id, NULL)
}
