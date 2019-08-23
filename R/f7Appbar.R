#' Create a Framework 7 appbar
#'
#' Displayed on top of \link{f7Navbar}. Interestingly, \link{f7Appbar} can also
#' trigger \link{f7Panel}.
#'
#' @param ... Any UI content such as \link{f7Searchbar}, \link{f7Next} and
#' \link{f7Back}. It is best practice to wrap \link{f7Next} and
#' \link{f7Back} in a \link{f7Flex}.
#' @param left_panel Whether to enable the left panel. FALSE by default.
#' @param right_panel Whether to enable the right panel. FALSE by default.
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'
#'  cities <- names(precip)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      init = f7Init(theme = "ios"),
#'      f7Appbar(
#'        f7Flex(f7Back(targetId = "tabset"),f7Next(targetId = "tabset")),
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
#'            icon = f7Icon("email"),
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
f7Appbar <- function(..., left_panel = FALSE, right_panel = FALSE) {

  panelToggle <- if (left_panel | right_panel) {
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
      if (left_panel) {
        shiny::tags$div(
          class = "left",
          setPanelToggle(panelToggle, "left")
        )
      },
      ...,
      if (right_panel) {
        shiny::tags$div(
          class = "right",
          setPanelToggle(panelToggle, "right")
        )
      }
    )
  )
}




#' Create a framework 7 back button
#'
#' This buttons allows to switch between multiple \link{f7Tab}.
#'
#' @param targetId \link{f7Tabs} id.
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
              //console.log(currentTabId);
              // if the first tab is already active, we cannot go back
              if (currentTabId !== firstTabId) {
                var backTab = $(currentTab).prev();
                var backTabId = $(backTab).attr('id');
                console.log(backTab);
                console.log(backTabId);
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
    f7Icon("reply_fill")
  )

  shiny::tagList(backJS, backTag)

}





#' Create a framework 7 next button
#'
#' This buttons allows to switch between multiple \link{f7Tab}.
#'
#' @param targetId \link{f7Tabs} id.
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
                console.log(backTab);
                console.log(backTabId);
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
    f7Icon("forward_fill")
  )

  shiny::tagList(nextJS, nextTag)

}
