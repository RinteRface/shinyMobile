#' Framework7 sheet
#'
#' \code{f7Sheet} creates an f7 sheet modal window.
#' The sheet modal has to be used in combination with \link{updateF7Sheet}.
#' If you need another trigger, simply add
#' \code{`data-sheet` = paste0("#", id)} to the tag of your choice (a button),
#' where id refers to the sheet unique id as well as the class "sheet-open".
#' Inversely, if you need a custom element to close a sheet, give it
#' the "sheet-close" class.
#'
#' @param ... Sheet content. If wipeToStep is TRUE, these items will be visible at start.
#' @param id Sheet unique id.
#' @param hiddenItems Put items you want to hide inside. Only works when
#' swipeToStep is TRUE. Default to NULL.
#' @param orientation "top" or "bottom".
#' @param swipeToClose If TRUE, it can be closed by swiping down.
#' @param swipeToStep If TRUE then sheet will be opened partially,
#' and with swipe it can be further expanded.
#' @param backdrop Enables Sheet backdrop (dark semi transparent layer
#' behind). By default it is true for MD theme and false for iOS theme.
#' @param closeByOutsideClick When enabled, sheet will be closed on
#' when click outside of it.
#' @param swipeHandler Whether to display a swipe handler. TRUE by default.
#' Need either swipeToClose or swipeToStep set to TRUE to work.
#' @param options Other parameters.
#' See \url{https://framework7.io/docs/sheet-modal#sheet-parameters}
#'
#' @rdname sheet
#'
#' @export
f7Sheet <- function(..., id, hiddenItems = NULL, orientation = c("top", "bottom"),
                    swipeToClose = FALSE, swipeToStep = FALSE, backdrop = FALSE,
                    closeByOutsideClick = TRUE, swipeHandler = TRUE, options = list()) {
  orientation <- match.arg(orientation)

  sheetCl <- "sheet-modal"
  if (orientation == "top" && !(swipeToStep || swipeToClose)) {
    sheetCl <- paste0(sheetCl, " sheet-modal-top")
  }

  sheetCSS <- "overflow: hidden;"
  sheetCSS <- if (orientation == "bottom") {
    paste(sheetCSS, "border-radius: 15px 15px 0 0;")
  } else {
    paste(sheetCSS, "border-radius: 0 0 15px 15px;")
  }

  # props
  sheetProps <- dropNulls(
    c(
      list(
        swipeToClose = swipeToClose,
        swipeToStep = swipeToStep,
        closeByOutsideClick = closeByOutsideClick,
        backdrop = backdrop
      ),
      options
    )
  )

  sheetConfig <- shiny::tags$script(
    type = "application/json",
    `data-for` = id,
    jsonlite::toJSON(
      x = sheetProps,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )

  sheetTag <- shiny::tags$div(
    class = sheetCl,
    id = id,
    style = if (swipeToStep || swipeToClose) "height: auto;",
    style = sheetCSS,
    sheetConfig
  )

  swiperHandlerCSS <- "height: 16px;
    position: absolute;
    left: 0;
    width: 100%;
    cursor: pointer;
    z-index: 10;"
  swiperHandlerCSS <- if (orientation == "bottom") {
    paste(swiperHandlerCSS, "top: 0;")
  } else {
    paste(swiperHandlerCSS, "bottom: 0;")
  }

  # inner sheet elements
  shiny::tagAppendChildren(
    sheetTag,
    if (!(swipeToStep || swipeToClose)) {
      shiny::tags$div(
        class = if (orientation == "top") {
          "toolbar toolbar-bottom"
        } else {
          "toolbar"
        },
        shiny::tags$div(
          class = "toolbar-inner",
          shiny::tags$div(class = "left"),
          shiny::tags$div(
            class = "right",
            shiny::a(class = "link sheet-close", href = "#", "Done")
          )
        )
      )
    },
    shiny::tags$div(
      class = "sheet-modal-inner",
      if (swipeToStep || swipeToClose) {
        if (swipeHandler) {
          shiny::tags$div(class = "swipe-handler", style = swiperHandlerCSS)
        }
      },
      # item shown
      shiny::tags$div(
        class = if (swipeToStep) {
          "block sheet-modal-swipe-step"
        } else {
          "block"
        },
        ...
      ),
      # hidden items
      hiddenItems
    )
  )
}

#' Update Framework7 sheet modal
#'
#' \code{updateF7Sheet} toggles an \link{f7Sheet} on the client.
#'
#' @param session Shiny session object
#' @export
#' @rdname sheet
#' @example inst/examples/sheet/app.R
updateF7Sheet <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(id, NULL)
}
