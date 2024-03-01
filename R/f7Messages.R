#' Framework7 messages container
#'
#' \code{f7Messages} is an empty container targeted by \link{updateF7Messages}
#' to include multiple \link{f7Message}.
#'
#' @param id Container id.
#' @param title Optional messages title.
#' @param autoLayout Enable Auto Layout to add all required additional classes
#' automatically based on passed conditions.
#' @param newMessagesFirst Enable if you want to use new messages on top,
#' instead of having them on bottom.
#' @param scrollMessages Enable/disable messages auto scrolling when adding new message.
#' @param scrollMessagesOnEdge If enabled then messages auto scrolling will happen only
#' when user is on top/bottom of the messages view.
#'
#' @rdname messages
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Messages",
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
#'       updateF7Messages(
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
#'       updateF7Messages(
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

  config <- dropNulls(
    list(
      autoLayout = autoLayout,
      newMessagesFirst = newMessagesFirst,
      scrollMessages = scrollMessages,
      scrollMessagesOnEdge = scrollMessagesOnEdge
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
    class = "messages",
    if (!is.null(title)) {
      shiny::tags$div(class = "messages-title", title)
    }
  )

}




#' Framework7 message bar.
#'
#' \code{f7MessageBar} creates a message text container to type new messages.
#' Insert before \link{f7Messages}. See examples.
#'
#' @param inputId Unique id.
#' @param placeholder Textarea placeholder.
#' @rdname messagebar
#' @export
f7MessageBar <- function(inputId, placeholder = "Message") {

  ns <- shiny::NS(inputId)

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
}




#' Update Framework7 message bar
#'
#' \code{updateF7MessageBar} updates message bar content on the server side.
#'
#' @param inputId \link{f7MessageBar} unique id.
#' @param value New value.
#' @param placeholder New placeholder value.
#' @param session Shiny session object.
#'
#' @rdname messagebar
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Update message bar",
#'     f7SingleLayout(
#'       navbar = f7Navbar(
#'         title = "Message bar",
#'         hairline = FALSE,
#'         shadow = TRUE
#'       ),
#'       toolbar = f7Toolbar(
#'         position = "bottom",
#'         f7Link(label = "Link 1", href = "https://www.google.com"),
#'         f7Link(label = "Link 2", href = "https://www.google.com")
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





#' Framework7 message element
#'
#' \code{f7Message} creates a message item to be inserted in
#' \link{f7Messages} with \link{updateF7Messages}.
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
#' @rdname messages
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



#' Update Framework7 message container
#'
#' \code{updateF7Messages} add messages to an \link{f7Messages} container.
#'
#' @param id Reference to \link{f7Messages} container.
#' @param showTyping Show typing when a new message comes. Default to FALSE.
#' Does not work yet...
#' @param messages List of \link{f7Messages}.
#' @param session Shiny session object
#'
#'
#' @rdname messages
#' @export
updateF7Messages <- function(id, messages, showTyping = FALSE,
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


#' Update Framework7 message container
#'
#' \code{f7AddMessages} adds messages to an \link{f7Messages} container.
#' Use \link{updateF7Messages} instead
#'
#' @rdname f7-deprecated
#' @inheritParams updateF7Messages
#' @keywords internal
#' @export
f7AddMessages <- function(id, messages, showTyping = FALSE,
                             session = shiny::getDefaultReactiveDomain()) {

  .Deprecated(
    "updateF7Messages",
    package = "shinyMobile",
    "f7AddMessages will be removed in future release. Please use
      updateF7Messages instead.",
    old = as.character(sys.call(sys.parent()))[1L]
  )
  updateF7Messages(id, messages, showTyping, session)
}
