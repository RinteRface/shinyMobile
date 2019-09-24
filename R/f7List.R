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
#' library(shinyF7)
#'
#' shiny::shinyApp(
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
#' @param url Item url.
#' @param media Expect \link{f7Icon} or \link[shiny]{img}.
#' @param right Right content if any.
#' @export
f7ListItem <- function(..., title = NULL, subtitle = NULL, header = NULL, footer = NULL,
                       url = NULL, media = NULL, right = NULL) {

  # avoid to have crazy large images
  if (!is.null(media)) {
    if (media$name == "img") media$attribs$width <- "50"
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

  itemContentWrapper <- if (is.null(url)) {
    shiny::tags$div(
      class = "item-content",
      itemContent
    )
  } else {
    shiny::tags$a(
      class = "item-link item-content external",
      href = url,
      target = "_blank",
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
#'  library(shinyF7)
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "My app",
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
#' @inheritParams shiny::tags
#' @export
f7ListIndexItem <- shiny::tags$li
