#' Create a Framework7 tabs
#'
#' Build a Framework7 tabs
#'
#' @param ... Slot for \link{f7Tab}.
#' @param position Tabs position: "top" or "bottom".
#' @param hairline Whether to display a thin border on the top of the toolbar. TRUE by default.
#' @param shadow Whether to display a shadow. TRUE by default.
#' @param icons Whether to use icons instead of text.
#' @param scrollable Whether to allow scrolling. FALSE by default.
#' @param swipeable Whether to allow finger swip. FALSE by default. Only for touch-screens.
#' Not compatible with animated.
#' @param animated Whether to show transition between tabs. FALSE by default.
#' Not compatible with swipeable.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Tabs <- function(..., position = c("top", "bottom"), hairline = TRUE, shadow = TRUE,
                     icons = FALSE, scrollable = FALSE,
                     swipeable = FALSE, animated = FALSE) {

  position <- match.arg(position)

  if (swipeable && animated) stop("Cannot use two effects at the same time")

  toolbarItems <- list(...)
  len <- length(toolbarItems)
  found_active <- FALSE

  toolbarClass <- if (icons) "toolbar" else "toolbar tabbar"
  if (!hairline) toolbarClass <- paste0(toolbarClass, " no-hairline")
  if (!shadow) toolbarClass <- paste0(toolbarClass, " no-shadow")
  if (icons) toolbarClass <- paste0(toolbarClass, " tabbar-labels")
  if (scrollable) toolbarClass <- paste0(toolbarClass, " tabbar-scrollable")
  if (position == "bottom") toolbarClass <- paste0(toolbarClass, " toolbar-bottom-md")


  # toolbar items
  toolbarTag <- shiny::tags$div(
    class = toolbarClass,
    shiny::tags$div(
      class = "toolbar-inner",
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
            shiny::tags$i(class = "icon f7-icons ios-only", itemIcon),
            shiny::tags$i(class = "icon material-icons md-only", itemIcon),
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
  )

  # related page content
  contentTag <- shiny::tags$div(
    class = "tabs ios-edges",
    lapply(1:len, function(i) { toolbarItems[[i]][[1]]})
  )

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

  shiny::tagList(toolbarTag, contentTag)

}



#' Create a Framework7 tab item
#'
#' Build a Framework7 tab item
#'
#' @param ... Item content.
#' @param tabName Item id. Must be unique.
#' @param icon Item icon.
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
    class = if (active) "page-content tab tab-active" else "page-content tab",
    id = id,
    f7Block(...)
  )
  return(list(itemTag, icon, tabName))
}
