#' Create a Framework7 tab list
#'
#' Build a Framework7 tab list
#'
#' @inheritParams f7Toolbar
#' @param mode Tab animation mode. Either "animated" or "swipeable".
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7TabList(
#'      tabs = TRUE,
#'      mode = "swipeable",
#'      f7Tab(
#'       active = TRUE,
#'       id = "tab1",
#'       "Tab 1"
#'      ),
#'      f7Tab(
#'       id = "tab2",
#'       "Tab 2"
#'      ),
#'      f7Tab(
#'       id = "tab3",
#'       "Tab 3"
#'      )
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @inheritParams f7Toolbar
#'
#' @export
f7TabList <- function(..., bottom = FALSE, hairline = TRUE, shadow = TRUE,
                      tabs = TRUE, labels = FALSE, scrollable = FALSE,
                      mode = c("animated", "swipeable")){

  mode <- match.arg(mode)

  # we are in tab mode
  tabs <- TRUE

 items <- list(...)
 len <- length(items)

 # create as much f7ToolbarItems as f7Tab
 tabsList <- lapply(1:len, FUN = function(i) {

   tabName <- items[[i]]$children[[1]]
   tabTag <- items[[i]][[2]]

   id <- tabTag$id
   active <- sum(grep(x = tabTag$class, pattern = "active")) == 1

   itemTag <- f7ToolbarItem(
     name = tabName,
     href = paste0("#", id)
   )

   # if we are in tab mode which is always the case
   if (tabs) {
     # remove the link class
     itemTag$attribs$class <- NULL
     # replace it by tab-link
     shiny::tagAppendAttributes(
       itemTag,
       class = if (active == 1) "tab-link tab-link-active" else "tab-link"
     )
   }
 })

 # create the toolbar menu
 menu <- f7Toolbar(
   bottom = bottom,
   hairline = hairline,
   shadow = shadow,
   tabs = tabs,
   labels = labels,
   scrollable = scrollable,
   tabsList
  )

 tabsTag <- shiny::tagList(
   menu,
   shiny::tags$div(
     class = paste0("tabs-", mode, "-wrap"),
     shiny::tags$div(class = "tabs", ...)
   )
 )

 shiny::tags$div(class = "views tabs", tabsTag)

}



#' Create a Framework7 tab
#'
#' Build a Framework7 tab
#'
#' @param ... Any UI element.
#' @param id Unique tab id.
#' @param active Whether the tab is active at start.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Tab <- function(..., id, active = FALSE) {

  tabClass <- "view tab"
  if (active) tabClass <- paste0(tabClass, " view-main tab-active")

 shiny::tags$div(
   class = tabClass,
   id = id,
   ...
 )
}
