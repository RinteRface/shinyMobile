#' Framework7 card
#'
#' \link{f7Card} creates a simple card container.
#'
#' @rdname card
#'
#' @param ... Card content.
#' @param image Card image if any. Displayed in the header.
#' @param title Card title.
#' @param footer Footer content, if any. Must be wrapped in a tagList.
#' @param outline Outline style. FALSE by default.
#' @param height Card height. NULL by default.
#'
#' @examples
#' # Simple card
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Cards",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Card"),
#'      f7Card("This is a simple card with plain text,
#'     but cards can also contain their own header,
#'     footer, list view, image, or any other element."),
#'     f7Card(
#'      title = "Card header",
#'      "This is a simple card with plain text,
#'      but cards can also contain their own header,
#'      footer, list view, image, or any other element.",
#'      footer = tagList(
#'       f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
#'       f7Badge("Badge", color = "green")
#'      )
#'     ),
#'     f7Card(
#'      title = "Card header",
#'      image = "https://lorempixel.com/1000/600/nature/3/",
#'      "This is a simple card with plain text,
#'      but cards can also contain their own header,
#'      footer, list view, image, or any other element.",
#'      footer = tagList(
#'       f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
#'       f7Badge("Badge", color = "green")
#'      )
#'     )
#'     )
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Card <- function(..., image = NULL, title = NULL, footer = NULL, outline = FALSE,
                   height = NULL) {

  cardCl <- "card"
  if (!is.null(image)) cardCl <- paste0(cardCl, " demo-card-header-pic")
  if (outline) cardCl <- paste0(cardCl, " card-outline")

  cardStyle <- NULL
  if (!is.null(height)) {
    style <- paste0("height: ", shiny::validateCssUnit(height), " overflow-y: auto;")
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
        class = "card-header align-items-flex-end",
        title
      )
    } else {
      shiny::tags$div(class = "card-header", title)
    }
  }

  #footer
  footerTag <- if (!is.null(footer)) {
    shiny::tags$div(class = "card-footer", footer)
  }

  # main tag
  mainTag <- if (!is.null(image)) {
    shiny::tags$div(
      class = "card demo-card-header-pic",
      headerTag,
      contentTag,
      footerTag
    )
  } else {
    shiny::tags$div(
      class = cardCl,
      headerTag,
      contentTag,
      footerTag
    )
  }

  return(mainTag)
}


#' Framework7 social card
#'
#' \link{f7SocialCard} is a special card for social content.
#'
#' @rdname card
#'
#' @param ... Card content.
#' @param image Author img.
#' @param author Author.
#' @param date Date.
#' @param footer Footer content, if any. Must be wrapped in a tagList.
#'
#' @examples
#' # Social card
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Social Card",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7SocialCard"),
#'      f7SocialCard(
#'      image = "http://lorempixel.com/68/68/people/1/",
#'      author = "John Doe",
#'      date = "Monday at 3:47 PM",
#'      "What a nice photo i took yesterday!",
#'      img(src = "http://lorempixel.com/1000/700/nature/8/", width = "100%"),
#'      footer = tagList(
#'       f7Badge("1", color = "yellow"),
#'       f7Badge("2", color = "green"),
#'       f7Badge("3", color = "blue")
#'      )
#'     )
#'     )
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @export
f7SocialCard <- function(..., image = NULL, author = NULL, date = NULL,
                         footer = NULL) {

  headerTag <- shiny::tags$div(
    class = "card-header",
    shiny::tags$div(
      class = "demo-facebook-avatar",
      shiny::img(src = image, width = "34", height = "34")
    ),
    shiny::tags$div(class = "demo-facebook-name", author),
    shiny::tags$div(class = "demo-facebook-date", date)
  )
  contentTag <- shiny::tags$div(
    class = "card-content card-content-padding",
    ...
  )

  footerTag <- if (!is.null(footer)) shiny::tags$div(class = "card-footer", footer)

  shiny::tags$div(
    class = "card demo-facebook-card",
    headerTag,
    contentTag,
    footerTag
  )
}





#' Framework7 expandable card
#'
#' \link{f7ExpandableCard} is a card that can expand. Ideal for a
#' gallery.
#'
#' @rdname card
#'
#' @param id Unique card id. Useful to handle multiple cards in the DOM.
#' @param ... Card content.
#' @param title Card title.
#' @param subtitle Card subtitle.
#' @param color Card background color. See \url{http://framework7.io/docs/cards.html}.
#' Not compatible with the img argument.
#' @param image Card background image url. Tje JPG format is prefered. Not compatible
#' with the color argument.
#' @param fullBackground Whether the image should cover the entire card.
#'
#' @note For \link{f7ExpandableCard}, image and color are not compatible. Choose one of them.
#'
#' @examples
#' # Expandable card
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Expandable Cards",
#'     f7SingleLayout(
#'       navbar = f7Navbar(
#'        title = "Expandable Cards",
#'        hairline = FALSE,
#'        shadow = TRUE
#'       ),
#'       f7ExpandableCard(
#'        id = "card1",
#'        title = "Expandable Card 1",
#'        color = "blue",
#'        subtitle = "Click on me pleaaaaase",
#'        "Framework7 - is a free and open source HTML mobile framework
#'        to develop hybrid mobile apps or web apps with iOS or Android
#'        native look and feel. It is also an indispensable prototyping apps tool
#'        to show working app prototype as soon as possible in case you need to."
#'       ),
#'       f7ExpandableCard(
#'        id = "card2",
#'        title = "Expandable Card 2",
#'        color = "green",
#'        "Framework7 - is a free and open source HTML mobile framework
#'        to develop hybrid mobile apps or web apps with iOS or Android
#'        native look and feel. It is also an indispensable prototyping apps tool
#'        to show working app prototype as soon as possible in case you need to."
#'       ),
#'       f7ExpandableCard(
#'        id = "card3",
#'        title = "Expandable Card 3",
#'        image = "https://i.pinimg.com/originals/73/38/6e/73386e0513d4c02a4fbb814cadfba655.jpg",
#'        "Framework7 - is a free and open source HTML mobile framework
#'         to develop hybrid mobile apps or web apps with iOS or Android
#'         native look and feel. It is also an indispensable prototyping apps tool
#'         to show working app prototype as soon as possible in case you need to."
#'       ),
#'       f7ExpandableCard(
#'        id = "card4",
#'        title = "Expandable Card 4",
#'        fullBackground = TRUE,
#'        image = "https://i.ytimg.com/vi/8q_kmxwK5Rg/maxresdefault.jpg",
#'        "Framework7 - is a free and open source HTML mobile framework
#'               to develop hybrid mobile apps or web apps with iOS or Android
#'               native look and feel. It is also an indispensable prototyping apps tool
#'               to show working app prototype as soon as possible in case you need to."
#'       )
#'     )
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
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
#' \link{updateF7Card} maximizes a \link{f7ExpandableCard} on the client.
#'
#' @param id Card id.
#' @param session Shiny session object.
#'
#' @rdname card
#' @export
#'
#' @examples
#' # Update expandable card
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Expandable Cards",
#'      f7SingleLayout(
#'        navbar = f7Navbar(
#'          title = "Expandable Cards",
#'          hairline = FALSE,
#'          shadow = TRUE
#'        ),
#'        f7ExpandableCard(
#'          id = "card1",
#'          title = "Expandable Card 1",
#'          image = "https://i.pinimg.com/originals/73/38/6e/73386e0513d4c02a4fbb814cadfba655.jpg",
#'          "Framework7 - is a free and open source HTML mobile framework
#'          to develop hybrid mobile apps or web apps with iOS or Android
#'          native look and feel. It is also an indispensable prototyping apps tool
#'          to show working app prototype as soon as possible in case you need to."
#'        ),
#'
#'        hr(),
#'        f7BlockTitle(title = "Click below to expand the card!") %>% f7Align(side = "center"),
#'        f7Button(inputId = "go", label = "Go"),
#'        br(),
#'        f7ExpandableCard(
#'          id = "card2",
#'          title = "Expandable Card 2",
#'          fullBackground = TRUE,
#'          image = "https://i.ytimg.com/vi/8q_kmxwK5Rg/maxresdefault.jpg",
#'          "Framework7 - is a free and open source HTML mobile framework
#'                to develop hybrid mobile apps or web apps with iOS or Android
#'                native look and feel. It is also an indispensable prototyping apps tool
#'                to show working app prototype as soon as possible in case you need to."
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      observeEvent(input$go, {
#'        updateF7Card(id = "card2")
#'      })
#'
#'      observe({
#'        list(
#'          print(input$card1),
#'          print(input$card2)
#'        )
#'      })
#'    }
#'  )
#' }
updateF7Card <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(id, NULL)
}
