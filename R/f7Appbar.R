#' Framework7 appbar
#'
#' \link{f7Appbar} is displayed on top of \link{f7Navbar}. \link{f7Appbar} can also
#' trigger \link{f7Panel}.
#'
#' @param ... Any UI content such as \link{f7Searchbar}, \link{f7Next} and
#' \link{f7Back}. It is best practice to wrap \link{f7Next} and
#' \link{f7Back} in a \link{f7Flex}.
#' @param leftPanel Whether to enable the left panel. FALSE by default.
#' @param rightPanel Whether to enable the right panel. FALSE by default.
#'
#' @rdname appbar
#'
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  cities <- names(precip)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7Appbar(
#'        f7Flex(f7Back(targetId = "tabset"), f7Next(targetId = "tabset")),
#'        f7Searchbar(id = "search1", inline = TRUE)
#'      ),
#'      f7TabLayout(
#'        navbar = f7Navbar(
#'          title = "f7Appbar",
#'          hairline = FALSE,
#'          shadow = TRUE
#'        ),
#'        f7Tabs(
#'          animated = FALSE,
#'          swipeable = TRUE,
#'          id = "tabset",
#'          f7Tab(
#'            tabName = "Tab 1",
#'            icon = f7Icon("envelope"),
#'            active = TRUE,
#'            "Text 1"
#'          ),
#'          f7Tab(
#'            tabName = "Tab 2",
#'            icon = f7Icon("today"),
#'            active = FALSE,
#'            "Text 2"
#'          ),
#'          f7Tab(
#'            tabName = "Tab 3",
#'            icon = f7Icon("cloud_upload"),
#'            active = FALSE,
#'            "Text 3"
#'          )
#'        )
#'      )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
f7Appbar <- function(..., leftPanel = FALSE, rightPanel = FALSE) {

  panelToggle <- if (leftPanel || rightPanel) {
    shiny::tags$a(
      href = "#",
      class = "button button-small panel-toggle display-flex",
      `data-panel` = NA,
      f7Icon("bars")
    )
  }

  setPanelToggle <- function(item, side) {
    item$attribs$`data-panel` <- side
    return(item)
  }

  shiny::tags$div(
    class = "appbar",
    shiny::tags$div(
      class = "appbar-inner",
      if (leftPanel) {
        shiny::tags$div(
          class = "left",
          setPanelToggle(panelToggle, "left")
        )
      },
      ...,
      if (rightPanel) {
        shiny::tags$div(
          class = "right",
          setPanelToggle(panelToggle, "right")
        )
      }
    )
  )
}




#' Framework7 back button
#'
#' \link{f7Back} is a button to go back in \link{f7Tabs}.
#'
#' @param targetId \link{f7Tabs} id.
#' @rdname appbar
#' @export
f7Back <- function(targetId) {

  backJS <- shiny::singleton(
    shiny::tags$script(
      shiny::HTML(
        paste0(
          "$(function() {
            var firstTabId =  $('#", targetId," div:eq(0)').attr('id');
            var currentTab = null;
            var currentTabId = null;
            // need to update the current tab on each click
            $(window).on('click', function() {
              currentTab = $('#", targetId, "').find('.tab-active');
              currentTabId = $(currentTab).attr('data-value');
            });
            $('#back_", targetId, "').on('click', function(e) {
              currentTab = $('#", targetId, "').find('.tab-active');
              currentTabId = $(currentTab).attr('id');
              // if the first tab is already active, we cannot go back
              if (currentTabId !== firstTabId) {
                var backTab = $(currentTab).prev();
                var backTabId = $(backTab).attr('id');
                app.tab.show('#' + backTabId);
              }
            });
          });
          "
        )
      )
    )
  )

  backTag <- shiny::tags$a(
    href = "#",
    id = paste0("back_", targetId),
    class = "button button-small display-flex margin-left-half",
    f7Icon("arrowshape_turn_up_left_fill")
  )

  shiny::tagList(backJS, backTag)

}





#' Framework7 next button
#'
#' \link{f7Next} is a button to go next in \link{f7Tabs}.
#'
#' @param targetId \link{f7Tabs} id.
#' @rdname appbar
#' @export
f7Next <- function(targetId) {

  nextJS <- shiny::singleton(
    shiny::tags$script(
      shiny::HTML(
        paste0(
          "$(function() {
            var lastTabId =  $('#", targetId," div:last-child').attr('id');
            var currentTab = null;
            var currentTabId = null;
            // need to update the current tab on each click
            $(window).on('click', function() {
              currentTab = $('#", targetId, "').find('.tab-active');
              currentTabId = $(currentTab).attr('data-value');
            });
            $('#next_", targetId, "').on('click', function(e) {
              currentTab = $('#", targetId, "').find('.tab-active');
              currentTabId = $(currentTab).attr('id');
              // if the first tab is already active, we cannot go back
              if (currentTabId !== lastTabId) {
                var backTab = $(currentTab).next();
                var backTabId = $(backTab).attr('id');
                app.tab.show('#' + backTabId);
              }
            });
          });
          "
        )
      )
    )
  )

  nextTag <- shiny::tags$a(
    href = "#",
    id = paste0("next_", targetId),
    class = "button button-small display-flex margin-left-half",
    f7Icon("arrowshape_turn_up_right_fill")
  )

  shiny::tagList(nextJS, nextTag)

}
