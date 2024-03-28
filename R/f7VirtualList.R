#' Framework7 virtual list
#'
#' \code{f7VirtualList} is a high performance list container.
#' Use if you have too many components in \link{f7List}.
#'
#' @param id Virtual list unique id.
#' @param items List items. Slot for \link{f7VirtualListItem}.
#' @param rowsBefore Amount of rows (items) to be rendered before current
#' screen scroll position. By default it is equal to double amount of
#' rows (items) that fit to screen.
#' @param rowsAfter Amount of rows (items) to be rendered after current
#' screen scroll position. By default it is equal to the amount of rows
#' (items) that fit to screen.
#' @param cache Disable or enable DOM cache for already rendered list items.
#' In this case each item will be rendered only once and all further
#' manipulations will be with DOM element. It is useful if your list
#' items have some user interaction elements (like form elements or swipe outs)
#' or could be modified.
#' @param mode List mode. NULL, "simple", "links", "media" or "contacts".
#' @param inset Whether to display a card border. FALSE by default.
#' @param outline Outline style. Default to FALSE.
#' @param dividers Dividers style. Default to FALSE.
#' @param strong Strong style. Default to FALSE.
#'
#' @example inst/examples/virtualList/app.R
#'
#' @rdname virtuallist
#'
#' @export

f7VirtualList <- function(id, items, rowsBefore = NULL, rowsAfter = NULL,
                          cache = TRUE, mode = NULL, inset = FALSE, outline = FALSE,
                          dividers = FALSE, strong = FALSE) {

  listCl <- "list virtual-list searchbar-found"
  if (strong) listCl <- paste(listCl, "list-strong")
  if (outline) listCl <- paste(listCl, "list-outline")
  if (dividers) listCl <- paste(listCl, "list-dividers")
  if (!is.null(mode)) listCl <- paste(listCl, sprintf("%s-list", mode))
  if (inset) listCl <- paste(listCl, "inset")

  config <- dropNulls(
    list(
      items = items,
      rowsBefore = rowsBefore,
      rowsAfter = rowsAfter,
      cache = cache
    )
  )

  shiny::tags$div(
    id = id,
    shiny::tags$script(
      type = "application/json",
      `data-for` = id,
      jsonlite::toJSON(
        x = config,
        auto_unbox = TRUE,
        json_verbatim = TRUE
      )
    ),
    class = listCl
  )
}


#' Framework7 virtual list item
#'
#' \code{f7VirtualListItem} is an item component for \link{f7VirtualList}.
#'
#' @inheritParams f7ListItem
#' @rdname virtuallist
#' @export
f7VirtualListItem <- function(..., title = NULL, subtitle = NULL, header = NULL, footer = NULL,
                              href = NULL, media = NULL, right = NULL) {
  dropNulls(
    list(
      content = ...,
      title = title,
      subtitle = subtitle,
      header = header,
      footer = footer,
      url = href,
      media = as.character(media), # avoid issue on JS side
      right = right
    )
  )
}




#' Update an \link{f7VirtualList} on the server side
#'
#' This function wraps all methods from \url{https://framework7.io/docs/virtual-list.html}
#'
#' @param id \link{f7VirtualList} to update.
#' @param action Action to perform. See \url{https://framework7.io/docs/virtual-list.html}.
#' @param item If action is one of appendItem, prependItem, replaceItem, insertItemBefore.
#' @param items If action is one of appendItems, prependItems, replaceAllItems.
#' @param index If action is one of replaceItem, insertItemBefore, deleteItem.
#' @param indexes If action if one of filterItems, deleteItems.
#' @param oldIndex If action is moveItem.
#' @param newIndex If action is moveItem.
#' @param session Shiny session.
#'
#' @example inst/examples/virtualList/app.R
#'
#' @export

updateF7VirtualList <- function(id, action = c(
  "appendItem", "appendItems", "prependItem",
  "prependItems", "replaceItem", "replaceAllItems",
  "moveItem", "insertItemBefore", "filterItems",
  "deleteItem", "deleteAllItems", "scrollToItem"
),
item = NULL, items = NULL, index = NULL, indexes = NULL,
oldIndex = NULL, newIndex = NULL,
session = shiny::getDefaultReactiveDomain()) {
  # JavaScript starts from 0!
  index <- index - 1
  indexes <- indexes - 1
  oldIndex <- oldIndex - 1
  newIndex <- newIndex - 1

  message <- dropNulls(
    list(
      action = action,
      item = item,
      items = items,
      index = index,
      indexes = indexes,
      oldIndex = oldIndex,
      newIndex = newIndex
    )
  )

  session$sendInputMessage(inputId = id, message)
}
