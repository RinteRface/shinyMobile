#' Create a Framework7 messages container
#'
#' @param id Container id.
#' @param title Optional messages title.
#' @param autoLayout Enable Auto Layout to add all required additional classes
#' automatically based on passed conditions.
#' @param newMessagesFirst Enable if you want to use new messages on top,
#' instead of having them on bottom.
#' @param scrollMessages Enable/disable messages autoscrolling when adding new message.
#' @param scrollMessagesOnEdge If enabled then messages autoscrolling will happen only
#' when user is on top/bottom of the messages view.
#'
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     init = f7Init(skin = "ios", theme = "light"),
#'     f7SingleLayout(
#'       navbar = f7Navbar(
#'         title = "Messages",
#'         hairline = FALSE,
#'         shadow = TRUE
#'       ),
#'       toolbar = f7MessageBar(inputId = "mymessagebar", placeholder = "Message"),
#'       # main content
#'       f7Messages(id = "mymessages", title = "My message")
#'
#'     )
#'   ),
#'   server = function(input, output, session) {
#'     observe({
#'       print(input[["mymessagebar-send"]])
#'       print(input$mymessages)
#'     })
#'     observeEvent(input[["mymessagebar-send"]], {
#'       f7AddMessages(
#'         id = "mymessages",
#'         list(
#'          f7Message(
#'           text = input$mymessagebar,
#'           name = "David",
#'           type = "sent",
#'           header = "Message Header",
#'           footer = "Message Footer",
#'           textHeader = "Text Header",
#'           textFooter = "text Footer",
#'           avatar = "https://cdn.framework7.io/placeholder/people-100x100-7.jpg"
#'          )
#'         )
#'       )
#'     })
#'
#'     observe({
#'       invalidateLater(5000)
#'       names <- c("Victor", "John")
#'       name <- sample(names, 1)
#'
#'       f7AddMessages(
#'         id = "mymessages",
#'         list(
#'          f7Message(
#'           text = "Some message",
#'           name = name,
#'           type = "received",
#'           avatar = "https://cdn.framework7.io/placeholder/people-100x100-9.jpg"
#'          )
#'         )
#'       )
#'     })
#'
#'   }
#'  )
#' }
f7Messages <- function(id, title = NULL, autoLayout = TRUE, newMessagesFirst = FALSE,
                       scrollMessages = TRUE, scrollMessagesOnEdge = TRUE) {

  config <- dropNulls(list(
    autoLayout = autoLayout,
    newMessagesFirst = newMessagesFirst,
    scrollMessages = scrollMessages,
    scrollMessagesOnEdge = scrollMessagesOnEdge
  ))

  shiny::tagList(
    f7InputsDeps(),
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
      class = "messages",
      if (!is.null(title)) {
        shiny::tags$div(class = "messages-title", title)
      }
    )
  )

}




#' Create a f7MessageBar to add new messages
#'
#' Insert before \link{f7Messages}. See examples.
#'
#' @param inputId Unique id.
#' @param placeholder Textarea placeholder.
#'
#' @export
f7MessageBar <- function(inputId, placeholder = "Message") {

  ns <- shiny::NS(inputId)

  shiny::tagList(
    f7InputsDeps(),
    shiny::tags$div(
      id = inputId,
      # add this to be able to see the message bar in a f7TabLayout...
      #style = "margin-bottom: 100px;",
      class = "toolbar messagebar",
      shiny::tags$div(
        class = "toolbar-inner",
        shiny::tags$div(
          class = "messagebar-area",
          shiny::tags$textarea(
            class = "resizable",
            placeholder = placeholder
          )
        ),
        shiny::tags$a(
          id = ns("send"),
          href = "#",
          class = "link icon-only demo-send-message-link f7-action-button",
          f7Icon("arrow_up_circle_fill")
        )
      )
    )
  )
}




#' Update message bar on the server side
#'
#' @param inputId \link{f7MessageBar} unique id.
#' @param value New value.
#' @param placeholder New placeholder value.
#' @param session Shiny session object.
#'
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'       navbar = f7Navbar(
#'         title = "Message bar",
#'         hairline = FALSE,
#'         shadow = TRUE
#'       ),
#'       toolbar = f7Toolbar(
#'         position = "bottom",
#'         f7Link(label = "Link 1", src = "https://www.google.com"),
#'         f7Link(label = "Link 2", src = "https://www.google.com", external = TRUE)
#'       ),
#'       # main content
#'       f7Segment(
#'         container = "segment",
#'         f7Button("updateMessageBar", "Update value"),
#'         f7Button("updateMessageBarPlaceholder", "Update placeholder")
#'       ),
#'       f7MessageBar(inputId = "mymessagebar", placeholder = "Message"),
#'       uiOutput("messageContent")
#'     )
#'   ),
#'   server = function(input, output, session) {
#'
#'     output$messageContent <- renderUI({
#'       req(input$mymessagebar)
#'       tagList(
#'         f7BlockTitle("Message Content", size = "large"),
#'         f7Block(strong = TRUE, inset = TRUE, input$mymessagebar)
#'       )
#'     })
#'
#'     observeEvent(input$updateMessageBar, {
#'       updateF7MessageBar(
#'         inputId = "mymessagebar",
#'         value = "sjsjsj"
#'       )
#'     })
#'
#'     observeEvent(input$updateMessageBarPlaceholder, {
#'       updateF7MessageBar(
#'         inputId = "mymessagebar",
#'         placeholder = "Enter your message"
#'       )
#'     })
#'   }
#'  )
#' }
updateF7MessageBar <- function(inputId, value = NULL, placeholder = NULL,
                               session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(
    list(
      value = value,
      placeholder = placeholder
    )
  )

  session$sendInputMessage(inputId, message)
}





#' Create a f7Message
#'
#' @param text Message text.
#' @param name Sender name.
#' @param type Message type - sent or received.
#' @param header Single message header.
#' @param footer Single message footer.
#' @param avatar Sender avatar URL string.
#' @param textHeader Message text header.
#' @param textFooter Message text footer.
#' @param image Message image HTML string, e.g. <img src="path/to/image">. Can be used instead of imageSrc parameter.
#' @param imageSrc Message image URL string. Can be used instead of image parameter.
#' @param cssClass Additional CSS class to set on message HTML element.

#' @export
f7Message <- function(text, name, type = c("sent", "received"),
                      header = NULL, footer = NULL, avatar = NULL,
                      textHeader = NULL, textFooter = NULL, image = NULL,
                      imageSrc = NULL, cssClass = NULL) {

  type <- match.arg(type)
  dropNulls(
    list(
      text = text,
      header = header,
      footer = footer,
      name = name,
      avatar = avatar,
      type = type,
      textHeader = textHeader,
      textFooter = textFooter,
      image	= image,
      imageSrc = imageSrc
    )
  )
}



#' Update \link{f7Messages} on the server side.
#'
#' @param id Reference to link{f7Messages} container.
#' @param showTyping Show typing when a new message comes. Default to FALSE.
#' @param messages List of \link{f7Messages}.
#' @param session SHiny session object
#'
#' @export
f7AddMessages <- function(id, messages, showTyping = FALSE,
                          session = shiny::getDefaultReactiveDomain()) {

  message <- list(
    value = jsonlite::toJSON(
      messages,
      auto_unbox = TRUE,
      pretty = TRUE,
      json_verbatim = TRUE
    ),
    showTyping = showTyping
  )

  session$sendInputMessage(id, message)
}
