#' Create a framework 7 contact list
#'
#' @param ... Slot for \link{f7ListGroup} or \link{f7ListItem}.
#' @param mode List mode. NULL or "media" or "contacts".
#' @param inset Whether to display a card border. FALSE by default.
#' @export
#'
#' @examples
#' if (interactive()) {
#' library(shiny)
#' library(shinyMobile)
#'
#' shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'       navbar = f7Navbar(title = "f7List"),
#'
#'       # simple list
#'       f7List(
#'         lapply(1:3, function(j) f7ListItem(letters[j]))
#'       ),
#'
#'       # list with complex items
#'       f7List(
#'         lapply(1:3, function(j) {
#'           f7ListItem(
#'             letters[j],
#'             media = f7Icon("alarm_fill"),
#'             right = "Right Text",
#'             header = "Header",
#'             footer = "Footer"
#'           )
#'         })
#'       ),
#'
#'       # list with complex items
#'       f7List(
#'         mode = "media",
#'         lapply(1:3, function(j) {
#'           f7ListItem(
#'             title = letters[j],
#'             subtitle = "subtitle",
#'             "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#'             Nulla sagittis tellus ut turpis condimentum, ut dignissim
#'             lacus tincidunt. Cras dolor metus, ultrices condimentum sodales
#'             sit amet, pharetra sodales eros. Phasellus vel felis tellus.
#'             Mauris rutrum ligula nec dapibus feugiat. In vel dui laoreet,
#'             commodo augue id, pulvinar lacus.",
#'             media = tags$img(
#'              src = paste0(
#'              "https://cdn.framework7.io/placeholder/people-160x160-", j, ".jpg"
#'              )
#'             ),
#'             right = "Right Text"
#'           )
#'         })
#'       ),
#'
#'       # list with links
#'       f7List(
#'         lapply(1:3, function(j) {
#'           f7ListItem(url = "https://google.com", letters[j])
#'         })
#'       ),
#'
#'       # grouped lists
#'       f7List(
#'         mode = "contacts",
#'         lapply(1:3, function(i) {
#'           f7ListGroup(
#'             title = LETTERS[i],
#'             lapply(1:3, function(j) f7ListItem(letters[j]))
#'           )
#'         })
#'       )
#'     )
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
f7List <- function(..., mode = NULL, inset = FALSE) {

  listCl <- "list chevron-center"
  if (!is.null(mode)) listCl <- paste0(listCl, " ", mode, "-list")
  if (inset) listCl <- paste0(listCl, " inset")

  shiny::tags$div(
    class = listCl,
    if (is.null(mode)) {
      shiny::tags$ul(...)
    } else if (mode == "media") {
      shiny::tags$ul(...)
    } else {
      shiny::tagList(...)
    }
  )
}





#' Create a Framework 7 contact item
#'
#' @param ... Item text.
#' @param title Item title.
#' @param subtitle Item subtitle.
#' @param header Item header. Do not use when \link{f7List} mode is not NULL.
#' @param footer Item footer. Do not use when \link{f7List} mode is not NULL.
#' @param href Item external link.
#' @param media Expect \link{f7Icon} or \code{img}.
#' @param right Right content if any.
#' @export
f7ListItem <- function(..., title = NULL, subtitle = NULL, header = NULL, footer = NULL,
                       href = NULL, media = NULL, right = NULL) {

  # avoid to have crazy large images
  if (!is.null(media)) {
    if (!is.null(media$name)) {
      if (media$name == "img") media$attribs$width <- "50"
    }
  }

  itemContent <- shiny::tagList(
    # left media
    if (!is.null(media)) {
      shiny::tags$div(
        class = "item-media",
        media
      )
    },

    # center content
    shiny::tags$div(
      class = "item-inner",

      if (is.null(title)) {
        shiny::tagList(
          shiny::tags$div(
            class = "item-title",
            if (!is.null(header)) {
              shiny::tags$div(
                class = "item-header",
                header
              )
            },
            ...,
            if (!is.null(footer)) {
              shiny::tags$div(
                class = "item-footer",
                footer
              )
            }
          ),

          # right content
          if (!is.null(right)) {
            shiny::tags$div(
              class = "item-after",
              right
            )
          }
        )
      } else {
        shiny::tagList(
          shiny::tags$div(
            class = "item-title-row",
            shiny::tags$div(
              class = "item-title",
              if (!is.null(header)) {
                shiny::tags$div(
                  class = "item-header",
                  header
                )
              },
              title,
              if (!is.null(footer)) {
                shiny::tags$div(
                  class = "item-footer",
                  footer
                )
              }
            ),
            # right content
            if (!is.null(right)) {
              shiny::tags$div(
                class = "item-after",
                right
              )
            }
          ),

          # subtitle
          if (!is.null(subtitle)) {
            shiny::tags$div(
              class = "item-subtitle",
              subtitle
            )
          },

          # text
          shiny::tags$div(
            class = "item-text",
            ...
          )
        )
      }
    )
  )

  itemContentWrapper <- if (is.null(href)) {
    shiny::tags$div(
      class = "item-content",
      itemContent
    )
  } else {
    shiny::tags$a(
      class = "item-link item-content external",
      href = href,
      itemContent
    )
  }

  shiny::tags$li(itemContentWrapper)
}




#' Create a framework 7 group of contacts
#'
#' @param ... slot for \link{f7ListItem}.
#' @param title Group title.
#' @export
f7ListGroup <- function(..., title) {
  shiny::tags$div(
    class = "list-group",
    shiny::tags$ul(
      shiny::tags$li(class = "list-group-title", title),
      ...
    )
  )
}



#' Create a Framework 7 list index
#'
#' @param ... Slot for \link{f7ListGroup}.
#' @param id Unique id.
#' @export
#'
#' @note For some reason, unable to get more than 1 list index working. See
#' example below. The second list does not work.
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "List Index",
#'      f7TabLayout(
#'        navbar = f7Navbar(
#'          title = "f7ListIndex",
#'          hairline = FALSE,
#'          shadow = TRUE
#'        ),
#'        f7Tabs(
#'          f7Tab(
#'            tabName = "List 1",
#'            f7ListIndex(
#'              id = "listIndex1",
#'              lapply(seq_along(LETTERS), function(i) {
#'                f7ListGroup(
#'                  title = LETTERS[i],
#'                  lapply(1:3, function(j) {
#'                    f7ListIndexItem(letters[j])
#'                  })
#'                )
#'              })
#'            )
#'          ),
#'          f7Tab(
#'            tabName = "List 2",
#'            f7ListIndex(
#'              id = "listIndex2",
#'              lapply(seq_along(LETTERS), function(i) {
#'                f7ListGroup(
#'                  title = LETTERS[i],
#'                  lapply(1:3, function(j) {
#'                    f7ListIndexItem(letters[j])
#'                  })
#'                )
#'              })
#'            )
#'          )
#'        )
#'      )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
f7ListIndex <- function(..., id) {

  listIndexJS <- shiny::singleton(
    shiny::tags$script(
      shiny::HTML(
        paste0(
          "$(function() {
          // We first insert the HTML <div class=\"list-index\"></div> before
          // the page content div.
          $('<div class=\"list-index\" id=\"", id, "\"></div>').insertAfter($('.navbar'));

          // init the listIndex once we inserted the
          app.listIndex.create({
            // '.list-index' element
            el: '#", id, "',
            // List el where to look indexes and scroll for
            listEl: '#", id, "_contacts-list',
            // Generate indexes automatically based on '.list-group-title' and '.item-divider'
            indexes: 'auto',
            // Scroll list on indexes click and touchmove
            scrollList: true,
            // Enable bubble label when swiping over indexes
            label: true,
          });
        });
        "
        )
      )
    )
  )

  listIndexTag <- shiny::tags$div(
    class = "list simple-list contacts-list",
    # listEl
    id = paste0(id, "_contacts-list"),
    ...
  )

  shiny::tagList(listIndexJS, listIndexTag)

}



#' Create a Framework 7 list index item
#'
#' @inheritParams htmltools::tags
#'
#' @export
f7ListIndexItem <- htmltools::tags$li




#' Framework7 virtual list
#'
#' \link{f7VirtualList} is a high performance list container.
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
#'
#' @export
#' @rdname virtuallist
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Virtual List",
#'     f7SingleLayout(
#'       navbar = f7Navbar(
#'         title = "Virtual Lists",
#'         hairline = FALSE,
#'         shadow = TRUE
#'       ),
#'       # main content
#'       f7VirtualList(
#'         id = "vlist",
#'         rowsBefore = 2,
#'         rowsAfter = 2,
#'         items = lapply(1:20000, function(i) {
#'           f7VirtualListItem(
#'             title = paste("Title", i),
#'             subtitle = paste("Subtitle", i),
#'             header = paste("Header", i),
#'             footer = paste("Footer", i),
#'             right = paste("Right", i),
#'             content = i,
#'             media = img(src = "https://cdn.framework7.io/placeholder/fashion-88x88-1.jpg")
#'           )
#'         })
#'       )
#'     )
#'   ),
#'   server = function(input, output) {
#'
#'   }
#'  )
#'
#'  # below example will not load with classic f7List
#'  shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7SingleLayout(
#'        navbar = f7Navbar(
#'          title = "Virtual Lists",
#'          hairline = FALSE,
#'          shadow = TRUE
#'        ),
#'        # main content
#'        f7List(
#'          lapply(1:20000, function(i) {
#'            f7ListItem(
#'              title = paste("Title", i),
#'              subtitle = paste("Subtitle", i),
#'              header = paste("Header", i),
#'              footer = paste("Footer", i),
#'              right = paste("Right", i),
#'              content = i
#'            )
#'          })
#'        )
#'      )
#'    ),
#'    server = function(input, output) {
#'
#'    }
#'  )
#' }
f7VirtualList <- function(id, items, rowsBefore = NULL, rowsAfter = NULL,
                          cache = TRUE) {

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
    class = "list virtual-list media-list searchbar-found"
  )
}


#' Framework7 virtual list item
#'
#' \link{f7VirtualListItem} is an item component for \link{f7VirtualList}.
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




#' Update a \link{f7VirtualList} on the server side
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
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Update virtual list",
#'      f7SingleLayout(
#'        navbar = f7Navbar(
#'          title = "Virtual Lists",
#'          hairline = FALSE,
#'          shadow = TRUE
#'        ),
#'        # main content
#'        f7Segment(
#'          container = "segment",
#'
#'          f7Button(inputId = "appendItem", "Append Item"),
#'          f7Button(inputId = "prependItems", "Prepend Items"),
#'          f7Button(inputId = "insertBefore", "Insert before"),
#'          f7Button(inputId = "replaceItem", "Replace Item")
#'        ),
#'        f7Segment(
#'          container = "segment",
#'          f7Button(inputId = "deleteAllItems", "Remove All"),
#'          f7Button(inputId = "moveItem", "Move Item"),
#'          f7Button(inputId = "filterItems", "Filter Items")
#'        ),
#'        f7Flex(
#'          uiOutput("itemIndexUI"),
#'          uiOutput("itemNewIndexUI"),
#'          uiOutput("itemsFilterUI")
#'        ),
#'        f7VirtualList(
#'          id = "vlist",
#'          items = lapply(1:5, function(i) {
#'            f7VirtualListItem(
#'              title = paste("Title", i),
#'              subtitle = paste("Subtitle", i),
#'              header = paste("Header", i),
#'              footer = paste("Footer", i),
#'              right = paste("Right", i),
#'              content = i,
#'              media = img(src = "https://cdn.framework7.io/placeholder/fashion-88x88-3.jpg")
#'            )
#'          })
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      output$itemIndexUI <- renderUI({
#'        req(input$vlist$length > 2)
#'        f7Stepper(
#'          inputId = "itemIndex",
#'          label = "Index",
#'          min = 1,
#'          value = 2,
#'          max = input$vlist$length
#'        )
#'      })
#'
#'      output$itemNewIndexUI <- renderUI({
#'        req(input$vlist$length > 2)
#'        f7Stepper(
#'          inputId = "itemNewIndex",
#'          label = "New Index",
#'          min = 1,
#'          value = 1,
#'          max = input$vlist$length
#'        )
#'      })
#'
#'      output$itemsFilterUI <- renderUI({
#'        input$appendItem
#'        input$prependItems
#'        input$insertBefore
#'        input$replaceItem
#'        input$deleteAllItems
#'        input$moveItem
#'        isolate({
#'          req(input$vlist$length > 2)
#'          f7Slider(
#'            inputId = "itemsFilter",
#'            label = "Items to Filter",
#'            min = 1,
#'            max = input$vlist$length,
#'            value = c(1, input$vlist$length)
#'          )
#'        })
#'      })
#'
#'      observe(print(input$vlist))
#'
#'      observeEvent(input$appendItem, {
#'        updateF7VirtualList(
#'          id = "vlist",
#'          action = "appendItem",
#'          item = f7VirtualListItem(
#'            title = "New Item Title",
#'            right = "New Item Right",
#'            content = "New Item Content",
#'            media = img(src = "https://cdn.framework7.io/placeholder/fashion-88x88-1.jpg")
#'          )
#'        )
#'      })
#'
#'      observeEvent(input$prependItems, {
#'        updateF7VirtualList(
#'          id = "vlist",
#'          action = "prependItems",
#'          items = lapply(1:5, function(i) {
#'            f7VirtualListItem(
#'              title = paste("Title", i),
#'              right = paste("Right", i),
#'              content = i,
#'              media = img(src = "https://cdn.framework7.io/placeholder/fashion-88x88-1.jpg")
#'            )
#'          })
#'        )
#'      })
#'
#'      observeEvent(input$insertBefore, {
#'        updateF7VirtualList(
#'          id = "vlist",
#'          action = "insertItemBefore",
#'          index = input$itemIndex,
#'          item = f7VirtualListItem(
#'            title = "New Item Title",
#'            content = "New Item Content",
#'            media = img(src = "https://cdn.framework7.io/placeholder/fashion-88x88-1.jpg")
#'          )
#'        )
#'      })
#'
#'      observeEvent(input$replaceItem, {
#'        updateF7VirtualList(
#'          id = "vlist",
#'          action = "replaceItem",
#'          index = input$itemIndex,
#'          item = f7VirtualListItem(
#'            title = "Replacement",
#'            content = "Replacement Content",
#'            media = img(src = "https://cdn.framework7.io/placeholder/fashion-88x88-1.jpg")
#'          )
#'        )
#'      })
#'
#'      observeEvent(input$deleteAllItems, {
#'        updateF7VirtualList(
#'          id = "vlist",
#'          action = "deleteAllItems"
#'        )
#'      })
#'
#'      observeEvent(input$moveItem, {
#'        updateF7VirtualList(
#'          id = "vlist",
#'          action = "moveItem",
#'          oldIndex = input$itemIndex,
#'          newIndex = input$itemNewIndex
#'        )
#'      })
#'
#'      observeEvent(input$filterItems, {
#'        updateF7VirtualList(
#'          id = "vlist",
#'          action = "filterItems",
#'          indexes = input$itemsFilter[1]:input$itemsFilter[2]
#'        )
#'      })
#'
#'    }
#'  )
#' }
updateF7VirtualList <- function(id, action = c("appendItem", "appendItems", "prependItem",
                                               "prependItems", "replaceItem", "replaceAllItems",
                                               "moveItem", "insertItemBefore", "filterItems",
                                               "deleteItem", "deleteAllItems", "scrollToItem"),
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
