#' Create a Framework7 messages container
#'
#' @param ... Slot for \link{f7Message}.
#' @param id Container id.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'  shinyApp(
#'    ui = f7Page(
#'      preloader = FALSE,
#'      color = "pink",
#'      title = "My app",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7Messages"),
#'        f7Messages(
#'          id = "messagelist",
#'          f7Message(
#'            "Lorem ipsum dolor sit amet,
#'            consectetur adipiscing elit.
#'            Duo Reges: constructio interrete",
#'            src = "https://cdn.framework7.io/placeholder/people-100x100-7.jpg",
#'            author = "David",
#'            date = "2019-09-12",
#'            state = "received",
#'            type = "text"
#'          ),
#'          f7Message(
#'            "https://cdn.framework7.io/placeholder/cats-200x260-4.jpg",
#'            src = "https://cdn.framework7.io/placeholder/people-100x100-9.jpg",
#'            author = "Lia",
#'            date = NULL,
#'            state = "sent",
#'            type = "img"
#'          ),
#'          f7Message(
#'            "Hi Bro",
#'            src = "https://cdn.framework7.io/placeholder/people-100x100-9.jpg",
#'            author = NULL,
#'            date = "2019-08-15",
#'            state = "sent",
#'            type = "text"
#'          )
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'    }
#'  )
#' }
f7Messages <- function(..., id) {
  messagesJS <- shiny::singleton(
    shiny::tags$script(
      paste0(
        "$(function() {
          var messages = app.messages.create({
            el: '#", id, "',
         });
         $('.page-content').addClass('messages-content');
        });
        "
      )
    )
  )

  messages <- list(...)
  for (i in seq_along(messages)) {
    messages[[i]][[2]]$attribs$class <- paste0(
      messages[[i]][[2]]$attribs$class,
      " message-first message-last message-tail"
    )
  }

  messagesTag <- shiny::tags$div(class = "messages",  messages)
  shiny::tagList(messagesJS, messagesTag)
}




#' Create a framework7 message
#'
#' @param content Message content. If type is ing, content must
#' be an url or path.
#' @param src Message author avatar
#' @param author Message author
#' @param date Message date
#' @param state Whether it is a received or sent message.
#' @param type Whether it is a text or image.
#'
#' @export
f7Message <- function(content, src = NULL, author = NULL,
                      date = NULL, state = c("sent", "received"),
                      type = c("text", "img")) {

  state <- match.arg(state)
  type <- match.arg(type)

  shiny::tagList(
    if (!is.null(date)) {
      shiny::tags$div(class = "messages-title", shiny::tags$b(date))
    },
    shiny::tags$div(
      class = paste0("message message-", state),
      if (!is.null(src)) {
        shiny::tags$div(
          class = "message-avatar",
          style = paste0("background-image:url(", src, ");")
        )
      },
      shiny::tags$div(
        class = "message-content",
        if (!is.null(author)) {
          shiny::tags$div(class = "message-name", author)
        },
        shiny::tags$div(
          class = "message-bubble",
          if (type == "text") {
            shiny::tags$div(class = "message-text", content)
          } else {
            shiny::tags$div(
              class = "message-image",
              shiny::img(
                src = content,
                style = "width:200px; height: 260px;"
              )
            )
          }
        )
      )
    )
  )
}
