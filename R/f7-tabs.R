#' Create a Framework7 tabs
#'
#' Build a Framework7 tabs
#'
#' @param ... Slot for \link{f7Tab}.
#' @param .items Slot for other items that could be part of the toolbar such as
#' buttons or \link{f7Sheet}.
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
#'         f7Tab(tabName = "Tab 3", "tab 3 text"),
#'         .items = shiny::tags$a(
#'          class = "tab-link",
#'          href = "#",
#'          f7Icon("bolt_fill"),
#'          shiny::span(class = "tabbar-label", "Optional Item")
#'         )
#'       )
#'     )
#'   ),
#'   server = function(input, output) {
#'     output$selected <- renderText(input$tabdemo)
#'   }
#'  )
#' }
f7Tabs <- function(..., .items = NULL, id = NULL, swipeable = FALSE, animated = TRUE) {

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
    }),
    .items
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

  shiny::tagList(f7InputsDeps(), toolbarTag, contentTag)

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
  session$sendInputMessage(id, message)
}




#' Insert a \link{f7Tab} in a \link{f7Tabs}
#'
#' @param inputId  \link{f7Tabs} id.
#' @param tab \link{f7Tab} to insert.
#' @param target \link{f7Tab} after of before which the new tab will be inserted.
#' @param position Insert before or after: \code{c("before", "after")}.
#' @param select Whether to select the newly inserted tab. FALSE by default.
#' @param session Shiny session object.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "Insert a tab Before the target",
#'      f7TabLayout(
#'        panels = tagList(
#'          f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", effect = "cover"),
#'          f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", effect = "cover")
#'        ),
#'        navbar = f7Navbar(
#'          title = "Tabs",
#'          hairline = FALSE,
#'          shadow = TRUE,
#'          left_panel = TRUE,
#'          right_panel = TRUE
#'        ),
#'        f7Tabs(
#'          animated = TRUE,
#'          id = "tabs",
#'          f7Tab(
#'            tabName = "Tab 1",
#'            icon = f7Icon("email"),
#'            active = TRUE,
#'            "Tab 1",
#'            f7Button(inputId = "go", label = "Go")
#'          ),
#'          f7Tab(
#'            tabName = "Tab 2",
#'            icon = f7Icon("today"),
#'            active = FALSE,
#'            "Tab 2"
#'          )
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      observeEvent(input$go, {
#'        f7InsertTab(
#'          inputId = "tabs",
#'          position = "before",
#'          target = "Tab 2",
#'          tab = f7Tab (tabName = paste0("tab_", input$go), "Test"),
#'          select = TRUE
#'        )
#'      })
#'    }
#'  )
#' }
#'
f7InsertTab <- function(inputId, tab, target, position = c("before", "after"),
                        select = FALSE, session = shiny::getDefaultReactiveDomain()) {

  # in shinyF7, f7Tab returns a list of 3 elements:
  # - 1 is the tag\
  # - 2 is the icon name
  # - 3 is the tabName
  # Below we check if the tag is really a shiny tag...
  if (!(class(tab[[1]]) %in% c("shiny.tag" , "shiny.tag.list"))) stop("tab must be a shiny tag")

  ns <- inputId

  # we need to create a new id not to overlap with the updateF7Tab id
  # prefix by insert_ makes sense
  inputId <- paste0("insert_", inputId)

  position <- match.arg(position)

  # create the corresponding tablink
  tabId <- gsub(" ", "", tab[[1]]$attribs$id, fixed = TRUE)

  tabLink <- shiny::a(
    class = "tab-link",
    href = paste0("#", tab[[1]]$attribs$id),
    tab[[3]]
  )
  tabLink <- as.character(force(tabLink))

  # force to render shiny.tag and convert it to character
  # since text does not accept anything else
  tab <- as.character(force(tab[[1]]))

  # remove all whitespace from the target name
  target <- gsub(" ", "", target, fixed = TRUE)

  message <- dropNulls(
    list(
      value = tab,
      id = tabId,
      link = tabLink,
      target = target,
      position = position,
      select = tolower(select),
      ns = ns
    )
  )

  session$sendCustomMessage(type = inputId, message)
}
