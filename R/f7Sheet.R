#' Create an f7 sheet modal
#'
#' @param ... Sheet content. If wipeToStep is TRUE, these items will be visible at start.
#' @param hiddenItems Put items you want to hide inside. Only works when
#' swipeToStep is TRUE. Default to NULL.
#' @param id Sheet unique id.
#' @param label Trigger label.
#' @param orientation "top" or "bottom".
#' @param swipeToClose If TRUE, it can be closed by swiping down.
#' @param swipeToStep If TRUE then sheet will be opened partially,
#' and with swipe it can be further expanded.
#' @param backdrop Enables Sheet backdrop (dark semi transparent layer
#' behind). By default it is TRUE for MD and Aurora themes and
#' FALSE for iOS theme.
#' @param closeByOutsideClick When enabled, sheet will be closed on
#' when click outside of it.
#' @param swipeHandler Whether to display a swipe handler. TRUE by default.
#' Need either swipeToClose or swipeToStep set to TRUE to work.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shiny::shinyApp(
#'     ui = f7Page(
#'        title = "My app",
#'        f7SingleLayout(
#'           navbar = f7Navbar(title = "f7Sheet"),
#'           f7Sheet(
#'              id = "sheet1",
#'              label = "More",
#'              orientation = "bottom",
#'              swipeToClose = TRUE,
#'              swipeToStep = TRUE,
#'              backdrop = TRUE,
#'              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#'              Quisque ac diam ac quam euismod porta vel a nunc. Quisque sodales
#'              scelerisque est, at porta justo cursus ac",
#'              hiddenItems = tagList(
#'                 f7Segment(
#'                    container = "segment",
#'                    rounded = TRUE,
#'                    f7Button(color = "blue", label = "My button 1", rounded = TRUE),
#'                    f7Button(color = "green", label = "My button 2", rounded = TRUE),
#'                    f7Button(color = "yellow", label = "My button 3", rounded = TRUE)
#'                 ),
#'                 f7Flex(
#'                    f7Gauge(
#'                       id = "mygauge",
#'                       type  = "semicircle",
#'                       value = 10,
#'                       borderColor = "#2196f3",
#'                       borderWidth = 10,
#'                       valueFontSize = 41,
#'                       valueTextColor = "#2196f3",
#'                       labelText = "amount of something"
#'                    )
#'                 ),
#'                 f7Slider(
#'                    inputId = "obs",
#'                    label = "Number of observations",
#'                    max = 100,
#'                    min = 0,
#'                    value = 10,
#'                    scale = TRUE
#'                 ),
#'                 plotOutput("distPlot")
#'              )
#'           )
#'        )
#'     ),
#'     server = function(input, output, session) {
#'        observe({print(input$sheet1)})
#'        output$distPlot <- renderPlot({
#'           hist(rnorm(input$obs))
#'        })
#'        observeEvent(input$obs, {
#'           updateF7Gauge(session, id = "mygauge", value = input$obs)
#'        })
#'     }
#'  )
#' }
f7Sheet <- function(..., hiddenItems = NULL, id, label = "Open", orientation = c("top", "bottom"),
                    swipeToClose = FALSE, swipeToStep = FALSE, backdrop = FALSE,
                    closeByOutsideClick = TRUE, swipeHandler = TRUE) {

  orientation <- match.arg(orientation)

  sheetCl <- "sheet-modal"
  if (orientation == "top") sheetCl <- paste0(sheetCl, " sheet-modal-top")

 # props
 sheetProps <- dropNulls(
    list(
       class = sheetCl,
       id = id,
       style = if (swipeToStep | swipeToClose) "height: auto; --f7-sheet-bg-color: #fff;",
       `data-swipe-to-close` = tolower(swipeToClose),
       `data-swipe-to-step` = tolower(swipeToStep),
       `data-close-by-outside-click` = tolower(closeByOutsideClick),
       `data-backdrop` = tolower(backdrop)
    )
 )

 sheetTag <- do.call(shiny::tags$div, sheetProps)

 # inner sheet elements
 sheetTag <- shiny::tagAppendChildren(
    sheetTag,
    if (!(swipeToStep | swipeToClose)) {
       shiny::tags$div(
          class = if (orientation == "top") "toolbar toolbar-bottom" else "toolbar",
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
       if (swipeToStep | swipeToClose) {
          if (swipeHandler) {
             shiny::tags$div(class = "swipe-handler")
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

 # custom css for sheet
 sheetStyle <- shiny::tags$style(
    if (orientation == "bottom") {
       paste0(
          "
            /* sheet-modal will have top rounded corners */
            .sheet-modal {
               border-radius: 15px 15px 0 0;
               overflow: hidden;
            }

            .swipe-handler {
               height: 16px;
               position: absolute;
               left: 0;
               width: 100%;
               top: 0;
               background: #fff;
               cursor: pointer;
               z-index: 10;
            }
            "
       )
    } else {
       paste0(
          "
            /* sheet-modal will have bottom rounded corners */
            .sheet-modal {
               border-radius: 0 0 15px 15px;
               overflow: hidden;
            }

            .swipe-handler {
               height: 16px;
               position: absolute;
               left: 0;
               width: 100%;
               bottom: 0;
               background: #fff;
               cursor: pointer;
               z-index: 10;
            }
            "
       )
    }
 )

 shiny::tagList(
   # javascript initialization
   f7InputsDeps(),
   # custom css
   sheetStyle,
   # sheet trigger
   shiny::a(
      class = "button button-fill sheet-open",
      href = "#",
      `data-sheet` = paste0("#", id),
      label
   ),
   sheetTag
 )
}




#' update a framework 7 sheet modal
#'
#' @param inputId Sheet id.
#' @param session Shiny session object
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shiny::shinyApp(
#'     ui = f7Page(
#'        color = "pink",
#'        title = "My app",
#'        f7SingleLayout(
#'           navbar = f7Navbar(title = "f7Sheet"),
#'           f7Button(inputId = "go", label = "Go"),
#'           f7Sheet(
#'              id = "sheet1",
#'              label = "More",
#'              orientation = "bottom",
#'              swipeToClose = TRUE,
#'              swipeToStep = TRUE,
#'              backdrop = TRUE,
#'              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#'          Quisque ac diam ac quam euismod porta vel a nunc. Quisque sodales
#'          scelerisque est, at porta justo cursus ac"
#'           )
#'        )
#'     ),
#'     server = function(input, output, session) {
#'        observe({print(input$sheet1)})
#'        observeEvent(input$go, {
#'           updateF7Sheet(inputId = "sheet1", session = session)
#'        })
#'     }
#'  )
#' }
updateF7Sheet <- function(inputId, session) {
   message <- NULL
   session$sendInputMessage(inputId, NULL)
}
