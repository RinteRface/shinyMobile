#' Framework7 card
#'
#' \code{f7Card} creates a simple card container.
#'
#' @rdname card
#'
#' @param ... Card content.
#' @param image Card image if any. Displayed in the header.
#' @param title Card title.
#' @param footer Footer content, if any. Must be wrapped in a tagList.
#' @param outline Outline style. FALSE by default.
#' @param height Card height. NULL by default.
#' @param raised Card shadow. FALSE by default.
#' @param divider Card header/footer dividers. FALSE by default.
#'
#' @examples
#' # Simple card
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Cards",
#'       options = list(dark = FALSE),
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Card"),
#'         f7Card("This is a simple card with plain text,
#'       but cards can also contain their own header,
#'       footer, list view, image, or any other element."),
#'         f7Card(
#'           title = "Card header",
#'           raised = TRUE,
#'           outline = TRUE,
#'           divider = TRUE,
#'           div(class = "date", "March 16, 2024"),
#'           "This is a simple card with plain text,
#'        but cards can also contain their own header,
#'        footer, list view, image, or any other element.",
#'           footer = "Card footer"
#'         ),
#'         f7Card(
#'           title = "Card header",
#'           image = "https://cdn.framework7.io/placeholder/nature-1000x600-3.jpg",
#'           "This is a simple card with plain text,
#'        but cards can also contain their own header,
#'        footer, list view, image, or any other element.",
#'           footer = tagList(
#'             f7Link("Link 1", href = "https://google.com"),
#'             f7Badge("Badge", color = "green")
#'           )
#'         )
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Card <- function(..., image = NULL, title = NULL, footer = NULL, outline = FALSE,
                   height = NULL, raised = FALSE, divider = FALSE) {
  cardCl <- "card"
  if (!is.null(image)) cardCl <- paste(cardCl, "demo-card-header-pic")
  if (outline) cardCl <- paste(cardCl, "card-outline")
  if (raised) cardCl <- paste(cardCl, "card-raised")
  if (divider) cardCl <- paste(cardCl, "card-header-divider card-footer-divider")

  cardStyle <- NULL
  if (!is.null(height)) {
    cardStyle <- paste0("height: ", shiny::validateCssUnit(height), "; overflow-y: auto;")
  }

  # content
  contentTag <- shiny::tags$div(
    class = "card-content card-content-padding",
    style = cardStyle,
    ...
  )

  # header
  headerTag <- if (!is.null(title)) {
    if (!is.null(image)) {
      shiny::tags$div(
        style = paste0("background-image:url(", image, ")"),
        class = "card-header",
        valign = "bottom",
        title
      )
    } else {
      shiny::tags$div(class = "card-header", title)
    }
  }

  # footer
  footerTag <- if (!is.null(footer)) {
    shiny::tags$div(class = "card-footer", footer)
  }

  # main tag
  shiny::tags$div(
    class = cardCl,
    headerTag,
    contentTag,
    footerTag
  )
}

#' Framework7 social card
#'
#' `r lifecycle::badge("deprecated")`.
#' \code{f7SocialCard} is a special card for social content.
#'
#' @param ... Card content.
#' @param image Author img.
#' @param author Author.
#' @param date Date.
#' @param footer Footer content, if any. Must be wrapped in a tagList.
#'
#' @keywords internal
#' @export
f7SocialCard <- function(..., image = NULL, author = NULL, date = NULL,
                         footer = NULL) {
  lifecycle::deprecate_warn("1.1.0", "f7SocialCard()", "f7Card()")

  headerTag <- shiny::tags$div(
    class = "card-header",
    shiny::tags$div(
      shiny::img(src = image, width = "34", height = "34")
    ),
    shiny::tags$div(author),
    shiny::tags$div(date)
  )
  contentTag <- shiny::tags$div(
    class = "card-content card-content-padding",
    ...
  )

  footerTag <- if (!is.null(footer)) shiny::tags$div(class = "card-footer", footer)

  shiny::tags$div(
    class = "card",
    headerTag,
    contentTag,
    footerTag
  )
}

#' Framework7 expandable card
#'
#' \code{f7ExpandableCard} is a card that can expand. Ideal for a
#' gallery.
#'
#' @rdname card
#'
#' @param id Unique card id. Useful to handle multiple cards in the DOM.
#' @param ... Card content.
#' @param title Card title.
#' @param subtitle Card subtitle.
#' @param color Card background color. See \url{https://framework7.io/docs/cards.html}.
#' Not compatible with the img argument.
#' @param image Card background image url. Tje JPG format is prefered. Not compatible
#' with the color argument.
#' @param fullBackground Whether the image should cover the entire card.
#'
#' @note For \link{f7ExpandableCard}, image and color are not compatible. Choose one of them.
#'
#' @example inst/examples/card/app.R
#' @export
f7ExpandableCard <- function(..., id = NULL, title = NULL,
                             subtitle = NULL, color = NULL,
                             image = NULL, fullBackground = FALSE) {
  cardColorCl <- if (!is.null(color)) paste0("bg-color-", color)

  # card header if any
  cardHeader <- if (!is.null(title)) {
    shiny::tags$div(
      class = if (fullBackground) {
        paste0("card-header text-color-white")
      } else {
        paste0("card-header display-block")
      },
      title,
      style = if (!is.null(image) & !fullBackground) "height: 60px",
      if (!is.null(subtitle)) {
        shiny::tagList(
          shiny::br(),
          shiny::tags$small(style = "opacity: 0.7", subtitle)
        )
      }
    )
  }

  # trigger to close the card
  closeCard <- shiny::tags$a(
    href = "#",
    class = paste0("link card-close card-opened-fade-in color-white"),
    style = "position: absolute; right: 15px; top: 15px;",
    f7Icon("xmark_circle_fill")
  )


  # background image if any
  backgroundImg <- if (!is.null(image)) {
    if (fullBackground) {
      shiny::tags$div(
        style = paste0(
          "background: url('", image, "') no-repeat center top;
                background-size: cover;
                height: 400px"
        ),
        closeCard,
        cardHeader
      )
    } else {
      shiny::tags$div(
        style = paste0(
          "background: url('", image, "') no-repeat center bottom;
                background-size: cover;
                height: 240px"
        )
      )
    }
  }


  # card content
  cardContent <- shiny::tags$div(class = "card-content-padding", shiny::p(...))

  # main wrapper
  shiny::tags$div(
    class = "card card-expandable",
    `data-card` = paste0("#", id),
    id = id,
    shiny::tags$div(
      class = "card-content",
      if (!is.null(image)) {
        if (!fullBackground) {
          shiny::tagList(
            backgroundImg,
            closeCard,
            cardHeader
          )
        } else {
          backgroundImg
        }
      } else {
        shiny::tags$div(
          class = cardColorCl,
          style = "height: 300px;",
          cardHeader,
          closeCard
        )
      },
      cardContent
    )
  )
}

#' Update Framework7 expandable card
#'
#' \code{updateF7Card} maximizes an \link{f7ExpandableCard} on the client.
#'
#' @param id Card id.
#' @param session Shiny session object.
#'
#' @rdname card
#' @export
updateF7Card <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(id, NULL)
}
