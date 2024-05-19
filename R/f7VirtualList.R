#' Framework7 virtual list
#'
#' \code{f7VirtualList} is a high performance list container.
#' Use if you have too many components in \link{f7List}.
#'
#' @param id Unique id for list or item.
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

  listCl <- f7List(
    inset = inset,
    outline = outline,
    dividers = dividers,
    strong = strong,
    mode = mode
  )

  listCl <- paste(listCl$attribs$class, "virtual-list searchbar-found")

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
#' @param ... Item text.
#' @param id Optional id for item.
#' @param title Item title.
#' @param subtitle Item subtitle.
#' @param header Item header.
#' @param footer Item footer.
#' @param href Item external link.
#' @param media Expect \link{f7Icon} or \code{img}.
#' @param right Right content if any.
#' @param routable Works when href is not NULL. Default to FALSE. If TRUE,
#' the list item may point to another page, but we recommend using \link{f7List}
#' and \link{f7ListItem} instead. See \link{f7MultiLayout}. Can also be used in
#' combination with href = "#" to make items appear as links, but not actually
#' navigate anywhere, which is useful for custom click events.
#'
#' @rdname virtuallist
#' @export
f7VirtualListItem <- function(..., id = NULL, title = NULL, subtitle = NULL, header = NULL, footer = NULL,
                              href = NULL, media = NULL, right = NULL, routable = FALSE) {

  if (is.null(href) && routable) {
    stop("href can't be NULL when routable is TRUE.")
  }

  # avoid to have crazy large images
  if (!is.null(media)) {
    if (!is.null(media$name)) {
      if (media$name == "img") {
        # if width is not given, set it to 50
        if (is.null(media$attribs$width)) {
          media$attribs$width <- "50"
        }
      }
    }
  }

  dropNulls(
    list(
      content = ...,
      id = id,
      title = title,
      subtitle = subtitle,
      header = header,
      footer = footer,
      url = href,
      media = as.character(media), # avoid issue on JS side
      right = right,
      routable = routable
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

updateF7VirtualList <- function(
    id, action = c(
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
