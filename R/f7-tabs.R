#' Create a Framework7 tabs
#'
#' Build a Framework7 tabs
#'
#' @param ... Slot for \link{f7Tab}.
#' @param id Optional to get the id of the currently selected \link{f7Tab}.
#' @param swipeable Whether to allow finger swip. FALSE by default. Only for touch-screens.
#' Not compatible with animated.
#' @param animated Whether to show transition between tabs. TRUE by default.
#' Not compatible with swipeable.
#'
#' @note Animated does not work when set to FALSE and swipeable is FALSE.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Tab Layout",
#'     f7TabLayout(
#'       navbar = f7Navbar(title = HTML(paste("Currently selected:", textOutput("selected")))),
#'       f7Tabs(
#'         id = "tabdemo",
#'         swipeable = TRUE,
#'         animated = FALSE,
#'         f7Tab(tabName = "Tab 1", "tab 1 text"),
#'         f7Tab(tabName = "Tab 2", "tab 2 text"),
#'         f7Tab(tabName = "Tab 3", "tab 3 text")
#'       )
#'     )
#'   ),
#'   server = function(input, output) {
#'     output$selected <- renderText(input$tabdemo)
#'   }
#'  )
#' }
f7Tabs <- function(..., id = NULL, swipeable = FALSE, animated = TRUE) {

  if (swipeable && animated) stop("Cannot use two effects at the same time")
  if (is.null(id)) id <- paste0("tabs_", round(stats::runif(1, min = 0, max = 1e9)))

  toolbarItems <- list(...)
  len <- length(toolbarItems)
  found_active <- FALSE

  # toolbar items
  toolbarTag <- f7Toolbar(
    position = "bottom",
    hairline = TRUE,
    shadow = TRUE,
    icons = TRUE,
    scrollable = FALSE,
    lapply(1:len, FUN = function(i) {

      item <- toolbarItems[[i]][[1]]
      itemIcon <- toolbarItems[[i]][[2]]
      itemName <- toolbarItems[[i]][[3]]
      itemClass <- item$attribs$class
      itemId <- item$attribs$id

      # make sure that if the user set 2 tabs active at the same time,
      # only the first one is selected
      if (!found_active) {
        active <- sum(grep(x = itemClass, pattern = "active")) == 1
        if (active) found_active <<- TRUE
        # if there is already an active panel, set all other to inactive
      } else {
        active <- FALSE
      }

      # generate the link
      if (!is.null(itemIcon)) {
        shiny::a(
          href = paste0("#", itemId),
          class = if (active) "tab-link tab-link-active" else "tab-link",
          itemIcon,
          shiny::span(class = "tabbar-label", itemName)
        )
      } else {
        shiny::a(
          href = paste0("#", itemId),
          class = if (active) "tab-link tab-link-active" else "tab-link",
          itemName
        )
      }
    })
  )

  # related page content
  contentTag <- shiny::tags$div(
    # ios-edges necessary to have
    # the good ios rendering
    class = "tabs ios-edges",
    lapply(1:len, function(i) { toolbarItems[[i]][[1]]}),
    # needed for the input binding
    shiny::tags$div(class = "tabsBindingTarget")
  )

  contentTag$attribs$id <- id

  # handle swipeable tabs
  if (swipeable) {
    contentTag <- shiny::tags$div(
      class = "tabs-swipeable-wrap",
      contentTag
    )
  }

  if (animated) {
    contentTag <- shiny::tags$div(
      class = "tabs-animated-wrap",
      contentTag
    )
  }

  tabsJS <- shiny::singleton(
    shiny::tags$script(
      paste0(
        "
        // This function is necessary to activate the good tab at start.
        // If one tab is active, it has a data-active attribute set to true.
        // We then trigger the show function on that tab.
        // If no tab is active at start, the first tab is shown by default.
        $(function() {
          var firstTabId = $('#", id," div:eq(0)').attr('id');
          var tabActiveId = $('#", id," div[data-active = \"true\"]').attr('id');
          if (tabActiveId != undefined) {
            app.tab.show('#' + tabActiveId);
          } else {
            app.tab.show('#' + firstTabId);
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
           var selectedTab = $('#", id, "').find('.tab-active');
           var selectedTabVal = $(selectedTab).attr('data-value');
           Shiny.setInputValue('", id, "', selectedTabVal);
          });
        });
        "
      )
    )
  )

  shiny::tagList(tabsJS, toolbarTag, contentTag)

}



#' Create a Framework7 tab item
#'
#' Build a Framework7 tab item
#'
#' @param ... Item content.
#' @param tabName Item id. Must be unique.
#' @param icon Item icon. Expect \link{f7Icon} function with the suitable lib argument
#' (either md or ios or NULL for native f7 icons).
#' @param active Whether the tab is active at start. Do not select multiple tabs, only
#' the first one will be set to active
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Tab <- function(..., tabName, icon = NULL, active = FALSE) {

  id <- tabName
  # handle punctuation
  id <- gsub(x = id, pattern = "[[:punct:]]", replacement = "")
  # handle tab names with space
  id <- gsub(x = id, pattern = " ", replacement = "")

  itemTag <- shiny::tags$div(
    class = "page-content tab",
    `data-active` = tolower(active),
    id = id,
    `data-value` = tabName,
    style = "background-color: gainsboro;",
    ...
  )
  return(list(itemTag, icon, tabName))
}




#' Update a Framework 7 tabsetPanel
#'
#' Update \link{f7Tabs}.
#'
#' @param session Shiny session object.
#' @param id Id of the \link{f7Tabs} to update.
#' @param selected Newly selected tab.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "Tab Layout",
#'      f7TabLayout(
#'        navbar = f7Navbar(
#'         title = HTML(paste("Currently selected:", textOutput("selected"))),
#'         subNavbar = f7SubNavbar(
#'          f7Flex(
#'           f7Toggle(inputId = "updateTab", label = "Update Tab", checked = TRUE),
#'           f7Toggle(inputId = "updateSubTab", label = "Update SubTab", checked = FALSE)
#'          )
#'         )
#'        ),
#'        f7Tabs(
#'          id = "tabdemo",
#'          swipeable = TRUE,
#'          animated = FALSE,
#'          f7Tab(
#'           tabName = "Tab 1",
#'           f7Tabs(
#'            id = "subtabdemo",
#'            animated = TRUE,
#'            f7Tab(tabName = "SubTab 1", "SubTab 1"),
#'            f7Tab(tabName = "SubTab 2", "SubTab 2", active = TRUE),
#'            f7Tab(tabName = "SubTab 3", "SubTab 3")
#'           )
#'          ),
#'          f7Tab(tabName = "Tab 2", "Tab 2"),
#'          f7Tab(tabName = "Tab 3", "Tab 3")
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      observeEvent(input$updateTab, {
#'        selected <- ifelse(input$updateTab, "Tab 1", "Tab 2")
#'        updateF7Tabs(session, id = "tabdemo", selected = selected)
#'      })
#'      observeEvent(input$updateSubTab, {
#'        selected <- ifelse(input$updateSubTab, "SubTab 1", "SubTab 2")
#'        updateF7Tabs(session, id = "subtabdemo", selected = selected)
#'      })
#'    }
#'  )
#' }
updateF7Tabs <- function(session, id, selected = NULL) {

  # remove the space in the tab name
  selected <- gsub(x = selected, pattern = " ", replacement = "")

  message <- dropNulls(list(selected = selected))
  session$sendCustomMessage(type = id, message = message)
}
