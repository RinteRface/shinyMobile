#' Create a Framework7 card
#'
#' Build a Framework7 card
#'
#' @param ... Card content.
#' @param img Card image if any. Displayed in the header.
#' @param title Card title.
#' @param footer Footer content, if any. Must be wrapped in a tagList.
#' @param outline Outline style. FALSE by default.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Cards",
#'     f7Init(theme = "auto"),
#'     f7Card("This is a simple card with plain text,
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
#'      img = "http://lorempixel.com/1000/600/nature/3/",
#'      "This is a simple card with plain text,
#'      but cards can also contain their own header,
#'      footer, list view, image, or any other element.",
#'      footer = tagList(
#'       f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
#'       f7Badge("Badge", color = "green")
#'      )
#'     )
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Card <- function(..., img = NULL, title = NULL, footer = NULL, outline = FALSE) {

  cardCl <- "card"
  if (!is.null(img)) cardCl <- paste0(cardCl, " demo-card-header-pic")
  if (outline) cardCl <- paste0(cardCl, " card-outline")

  # content
  contentTag <- shiny::tags$div(
    class = "card-content card-content-padding",
    style = "max-height: 600px; overflow-y: auto;",
    ...
  )

  # header
  headerTag <- if (!is.null(title)) {
    if (!is.null(img)) {
      shiny::tags$div(
        style = paste0("background-image:url(", img, ")"),
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
  mainTag <- if (!is.null(img)) {
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


#' Create a Framework7 social card
#'
#' Build a Framework7 social card
#'
#' @param ... Card content.
#' @param author_img Author img.
#' @param author Author.
#' @param date Date.
#' @param footer Footer content, if any. Must be wrapped in a tagList.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Social Card",
#'     f7Init(theme = "auto"),
#'     f7SocialCard(
#'      author_img = "http://lorempixel.com/68/68/people/1/",
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
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7SocialCard <- function(..., author_img = NULL, author = NULL, date = NULL,
                         footer = NULL) {

  headerTag <- shiny::tags$div(
    class = "card-header",
    shiny::tags$div(
      class = "demo-facebook-avatar",
      shiny::img(src = author_img, width = "34", height = "34")
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



#' Create a Framework7 list card
#'
#' Build a Framework7 list card
#'
#' @param ... Slot for \link{f7ListCardItem}.
#'
#' @note The link does not work.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "List Card",
#'     f7Init(theme = "auto"),
#'     f7ListCard(
#'      f7ListCardItem(
#'       url = "https://www.google.com",
#'       title = "Item 1"
#'      ),
#'      f7ListCardItem(
#'       url = "https://www.google.com",
#'       title = "Item 2"
#'      )
#'     )
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7ListCard <- function(...) {
  shiny::tags$div(
    class = "card",
    shiny::tags$div(
      class = "card-content",
      shiny::tags$div(
        class = "list links-list",
        shiny::tags$ul(...)
      )
    )
  )
}



#' Create a Framework7 list card item
#'
#' Build a Framework7 list card item
#'
#' @param url Item url.
#' @param title item title.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7ListCardItem <- function(url = NULL, title = NULL) {
  shiny::tags$li(
    shiny::tags$a(
      href = url,
      title
    )
  )
}



#' Create a Framework7 media card
#'
#' Build a Framework7 media card
#'
#' @param ... Slot for \link{f7MediaCardItem}.
#' @param title Card title.
#' @param footer Footer content, if any. Must be wrapped in a tagList.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Media Card",
#'     f7Init(theme = "auto"),
#'     f7MediaCard(
#'      title = "New Releases:",
#'      f7MediaCardItem(
#'       src = "http://lorempixel.com/88/88/fashion/4",
#'       title = "Yellow Submarine",
#'       subtitle = "Beatles"
#'      ),
#'      f7MediaCardItem(
#'       src = "http://lorempixel.com/88/88/fashion/5",
#'       title = "Don't Stop Me Now",
#'       subtitle = "Queen"
#'      ),
#'      footer = tagList(
#'       span("January 20", 2015),
#'       span(5, "comments")
#'      )
#'     )
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7MediaCard <- function(..., title = NULL, footer = NULL) {

  headerTag <- if (!is.null(title)) shiny::tags$div(class = "card-header", title)

  contentTag <- shiny::tags$div(
    class = "card-content",
    shiny::tags$div(
      class = "list media-list",
      shiny::tags$ul(...)
    )
  )

  footerTag <- if(!is.null(footer)) shiny::tags$div(class = "card-footer", footer)

  mainTag <- shiny::tags$div(
    class = "card",
    headerTag,
    contentTag,
    footerTag
  )

}


#' Create a Framework7 media card item
#'
#' Build a Framework7 media card item
#'
#' @param src Item image url or path.
#' @param title Item title.
#' @param subtitle Item subtitle.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7MediaCardItem <- function(src = NULL, title = NULL, subtitle = NULL) {
  shiny::tags$li(
    class = "item-content",
    # side image
    shiny::tags$div(
      class = "item-media",
      shiny::tags$img(src = src, width = "44")
    ),
    #inner
    shiny::tags$div(
      class = "item-inner",
      shiny::tags$div(
        class = "item-title-row",
        shiny::tags$div(class = "item-title", title)
      ),
      shiny::tags$div(class = "item-subtitle", subtitle)
    )
  )
}





#' Create a Framework7 expandable card
#'
#' Build a Framework7 expandable card
#'
#' @param id Unique card id. Useful to handle multiple cards in the DOM.
#' @param ... Card content.
#' @param title Card title.
#' @param subtitle Card subtitle.
#' @param color Card background color. See \url{http://framework7.io/docs/cards.html}.
#' Not compatible with the img argument.
#' @param img Card background image url. Tje JPG format is prefered. Not compatible
#' with the color argument.
#' @param fullBackground Whether the image should cover the entire card.
#'
#' @note img and color are not compatible. Choose one of them.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
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
#'        img = "https://i.pinimg.com/originals/73/38/6e/73386e0513d4c02a4fbb814cadfba655.jpg",
#'        "Framework7 - is a free and open source HTML mobile framework
#'         to develop hybrid mobile apps or web apps with iOS or Android
#'         native look and feel. It is also an indispensable prototyping apps tool
#'         to show working app prototype as soon as possible in case you need to."
#'       ),
#'       f7ExpandableCard(
#'        id = "card4",
#'        title = "Expandable Card 4",
#'        fullBackground = TRUE,
#'        img = "https://i.ytimg.com/vi/8q_kmxwK5Rg/maxresdefault.jpg",
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
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7ExpandableCard <- function(..., id = NULL, title = NULL,
                             subtitle = NULL, color = NULL,
                             img = NULL, fullBackground = FALSE) {

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
      style = if (!is.null(img) & !fullBackground) "height: 60px",
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
    shiny::tags$i(class = "icon f7-icons", "close_round_fill")
  )


  # background image if any
  backgroundImg <- if (!is.null(img)) {
    if (fullBackground) {
      shiny::tags$div(
        style = paste0(
          "background: url('", img, "') no-repeat center top;
                background-size: cover;
                height: 400px"
        ),
        closeCard,
        cardHeader
      )
    } else {
      shiny::tags$div(
        style = paste0(
          "background: url('", img, "') no-repeat center bottom;
                background-size: cover;
                height: 240px"
        )
      )
    }
  }


  # card content
  cardContent <- shiny::tags$div(class = "card-content-padding", shiny::p(...))


  # javascript events
  #cardJS <- shiny::singleton(
  #  shiny::tags$head(
  #    shiny::tags$script(
  #      paste0(
  #        "$(function() {
  #          $('#", id,"').on('click', function(e) {
  #            $(this).addClass('card-open');
  #            $(this).css({ 'transform': 'translate3d(-0.00000038268472479785487px, -34.00000245360718px, 0px) scale(1.1428571428571428, 2)'});
  #            $(this).children('.card-content').css({'width': '320px', 'height': '600px', 'transform': 'translate3d(-20px, 0px, 0px) scale(0.875, 0.5)'});
  #          });
  #        });
  #      "
  #      )
  #    )
  #  )
  #)




  # main wrapper
  shiny::tagList(
    #cardJS,
    shiny::tags$div(
      class = "card card-expandable",
      `data-card` = paste0("#", id),
      id = id,
      shiny::tags$div(
        class = "card-content",
        if (!is.null(img)) {
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
      )#,
      #shiny::tags$div(class="card-expandable-size")
    )
  )
}
