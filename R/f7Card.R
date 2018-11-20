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
#'     title = "My app",
#'     f7Card("This is a simple card with plain text,
#'     but cards can also contain their own header,
#'     footer, list view, image, or any other element."),
#'     f7Card(
#'      title = "Card header",
#'      "This is a simple card with plain text,
#'      but cards can also contain their own header,
#'      footer, list view, image, or any other element.",
#'      footer = tagList(
#'       f7Button(color = "blue", "My button", src = "https://www.google.com"),
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
#'       f7Button(color = "blue", "My button", src = "https://www.google.com"),
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
  if (outline) cardCl <- paste0(cardCl, " card-outline")

  # content
  contentTag <- shiny::tags$div(
    class = "card-content card-content-padding",
    ...
  )

  # header
  headerTag <- if (!is.null(title)) {
    if (!is.null(img)) {
      shiny::tags$div(
        class = "card demo-card-header-pic",
        shiny::tags$div(
          style = paste0("background-image:url(", img, ")"),
          class = "card-header align-items-flex-end",
          title
        )
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
#'     title = "My app",
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
#'     title = "My app",
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
#'     title = "My app",
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
