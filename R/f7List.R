#' Create a framework 7 list view
#'
#' @param ... Slot for \link{f7ListGroup} or \link{f7ListItem}.
#' @param mode List mode. NULL, "simple", "links", "media" or "contacts".
#' @param inset Whether to display a card border. FALSE by default.
#' @param outline Outline style. Default to FALSE.
#' @param dividers Dividers style. Default to FALSE.
#' @param strong Strong style. Default to FALSE.
#' @param id Optional id, which can be used as a target for \link{f7ListIndex}.
#'
#' @example inst/examples/list/app.R
#'
#' @export
f7List <- function(
    ..., mode = NULL, inset = FALSE, outline = FALSE,
    dividers = FALSE, strong = FALSE, id = NULL) {
  listCl <- "list chevron-center"
  if (strong) listCl <- paste(listCl, "list-strong")
  if (outline) listCl <- paste(listCl, "list-outline")
  if (dividers) listCl <- paste(listCl, "list-dividers")
  if (!is.null(mode)) listCl <- paste(listCl, sprintf("%s-list", mode))
  if (inset) listCl <- paste(listCl, "inset")

  # Modify item call so that we can inject the list mode
  # and get the correct layout
  if (!is.null(mode)) {
    items_call_list <- as.list(substitute(c(...)))[-1]
    # Modify any f7ListItem call by injecting the mode of the
    # parent f7List element
    for (i in seq_along(items_call_list)) {
      tmp <- deparse1(items_call_list[[i]])
      if (any(grepl("f7ListItem", tmp))) {
        parm <- sprintf("f7ListItem(mode = \"%s\", ", mode)
        items_call_list[[i]] <- str2lang(
          sub("f7ListItem\\(", parm, tmp)
        )
      }
    }
    # Calling in the parent environment
    items <- lapply(items_call_list, eval, envir = parent.frame(1))
  } else {
    items <- list(...)
  }

  shiny::tags$div(
    class = listCl,
    id = id,
    if (!is.null(mode) && mode == "contacts") {
      shiny::tagList(items)
    } else {
      shiny::tags$ul(items)
    }
  )
}

#' Create a Framework 7 contact item
#'
#' @param ... Item text.
#' @param title Item title.
#' @param subtitle Item subtitle. Only work if the \link{f7List} mode is media.
#' @param header Item header. Do not use when \link{f7List} mode is not NULL.
#' @param footer Item footer. Do not use when \link{f7List} mode is not NULL.
#' @param href Item external link.
#' @param media Expect \link{f7Icon} or \code{img}.
#' @param right Right content if any.
#' @param routable Works when href is not NULL. Default to FALSE. If TRUE,
#' the list item may point to another page. See \link{f7MultiLayout}.
#' @export
f7ListItem <- function(..., title = NULL, subtitle = NULL, header = NULL, footer = NULL,
                       href = NULL, media = NULL, right = NULL, routable = FALSE) {
  # avoid to have crazy large images
  if (!is.null(media)) {
    if (!is.null(media$name)) {
      if (media$name == "img") media$attribs$width <- "50"
    }
  }

  pars <- list(...)
  mode <- pars$mode
  pars$mode <- NULL
  if (is.null(mode)) mode <- "undefined"

  if (mode != "media" && !is.null(subtitle)) {
    stop("subtitle is only supported for media list. Call f7List(mode = \"media\", ...).")
  }

  if (is.null(href) && routable) {
    stop("href can't be NULL when routable is TRUE.")
  }

  if (is.null(title) && !is.null(right)) {
    stop("Can't set right when title is NULL.")
  }

  if (mode == "media" && (!is.null(header) ||
  !is.null(footer))) {
    stop("header and footer can't be used with media list.")
  }

  if (mode == "simple" && is.null(title)) {
    stop("Use a title in a simple list.")
  }

  if (mode == "simple") {
    return(shiny::tags$li(title))
  }

  itemSubtitle <- if (!is.null(subtitle)) {
    shiny::tags$div(
      class = "item-subtitle",
      subtitle
    )
  }

  itemText <- shiny::tags$div(
    class = "item-text",
    pars
  )

  itemTitle <- if (
    !is.null(header) ||
      !is.null(footer) ||
      !is.null(itemText) ||
      !is.null(title)
  ) {
    shiny::tags$div(
      class = "item-title",
      if (!is.null(header)) {
        shiny::tags$div(
          class = "item-header",
          header
        )
      },
      title,
      if (mode != "media") itemText,
      if (!is.null(footer)) {
        shiny::tags$div(
          class = "item-footer",
          footer
        )
      }
    )
  }

  itemAfter <- if (!is.null(right)) {
    shiny::tags$div(
      class = "item-after",
      right
    )
  }

  itemInner <- shiny::tags$div(
    class = "item-inner",
    if (mode == "media") {
      shiny::tagList(
        shiny::tags$div(
          class = "item-title-row",
          itemTitle,
          itemAfter
        ),
        itemSubtitle,
        itemText
      )
    } else {
      shiny::tagList(
        itemTitle,
        itemAfter
      )
    }
  )

  itemContent <- shiny::tags$div(
    class = "item-content",
    if (!is.null(media)) {
      shiny::tags$div(
        class = "item-media",
        media
      )
    },
    itemInner
  )

  if (!is.null(href)) {
    itemContent$name <- "a"
    itemContent$attribs$class <- paste(
      itemContent$attribs$class,
      # Don't show extra link chevron icon
      if (mode != "links") "item-link",
      if (!routable) "external"
    )
    itemContent$attribs$href <- href
    if (!routable) itemContent$attribs$target <- "_blank"
  }

  shiny::tags$li(itemContent)
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
#' List index must be attached to an existing list view.
#'
#' @param id Unique id.
#' @param target Related list element. CSS selector like .class, #id, ...
#' @param ... Other options (see \url{https://framework7.io/docs/list-index#list-index-parameters}).
#' @param session Shiny session object.
#'
#' @example inst/examples/list/app.R
#'
#' @export
#'
#' @note While you can also supply a class as target, we advise to use an id to avoid conflicts.
f7ListIndex <- function(id, target, ..., session = shiny::getDefaultReactiveDomain()) {
  message <- list(el = id, listEl = target, ...)
  sendCustomMessage("listIndex", message, session)
}
