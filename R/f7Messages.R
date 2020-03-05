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
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      preloader = FALSE,
#'      title = "My app",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7Messages"),
#'        f7Messages(id = "messagelist")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'    }
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
      },
      HTML(
        '<div class="message">
  <div class="message-avatar" style="background-image:url(path/to/avatar)"></div>
  <div class="message-content">
    <div class="message-name">John Doe</div>
    <div class="message-header">Message header</div>
    <div class="message-bubble">
      <div class="message-text-header">Text header</div>
      <div class="message-image">
        <img src="path/to/image">
      </div>
      <div class="message-text">Hello world!</div>
      <div class="message-text-footer">Text footer</div>
    </div>
    <div class="message-footer">Message footer</div>
  </div>
</div>
        '
      )
    )
  )

}




#' Create a f7MessageBar to add new messages
#'
#' Insert before \link{f7Messages}. See examples.
#'
#' @param inputId Unique id.
#' @param label Submit button label.
#' @param placeholder Textarea placeholder.
#'
#' @export
f7MessageBar <- function(inputId, label = "Send", placeholder = "Message") {

  ns <- shiny::NS(inputId)

  shiny::tagList(
    f7InputsDeps(),
    shiny::tags$div(
      id = inputId,
      # add this to be able to see the message bar in a f7TabLayout...
      style = "margin-bottom: 100px;",
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
          id = ns("send-link"),
          href = "#",
          class = "link",
          label
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
#' @param id Reference to link{f7Messages} container.
#' @param text Message text.
#' @param name Sender name.
#' @param header Single message header.
#' @param footer Single message footer.
#' @param avatar Sender avatar URL string.
#' @param type Message type - sent or received.
#' @param textHeader Message text header.
#' @param textFooter Message text footer.
#' @param image Message image HTML string, e.g. <img src="path/to/image">. Can be used instead of imageSrc parameter.
#' @param imageSrc Message image URL string. Can be used instead of image parameter.
#' @param cssClass Additional CSS class to set on message HTML element.

#' @export
f7AddMessage <- function(id, text, name, header = NULL, footer = NULL,
                         avatar = NULL, type = c("sent", "received"),
                         textHeader = NULL, textFooter = NULL, image = NULL,
                         imageSrc = NULL, cssClass = NULL) {

  type <- match.arg(type)
  message <- dropNulls(
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

  message <- jsonlite::toJSON(
    message,
    auto_unbox = TRUE,
    pretty = TRUE
  )

  session$sendInputvalue(id, message)

  #

}
