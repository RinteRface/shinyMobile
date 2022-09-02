#' Framework7 sheet
#'
#' \code{f7Sheet} creates an f7 sheet modal window.
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
#' behind). By default it is TRUE for MD and Aurora themes and
#' FALSE for iOS theme.
#' @param closeByOutsideClick When enabled, sheet will be closed on
#' when click outside of it.
#' @param swipeHandler Whether to display a swipe handler. TRUE by default.
#' Need either swipeToClose or swipeToStep set to TRUE to work.
#'
#' @note The sheet modal has to be used in combination with \link{updateF7Sheet}.
#' Yet, if you need a specific trigger, simply add \code{`data-sheet` = paste0("#", id)},
#' to the tag of your choice (a button), where id refers to the sheet unique id.
#'
#' @rdname sheet
#'
#' @export
f7Sheet <- function(..., id, hiddenItems = NULL, orientation = c("top", "bottom"),
                    swipeToClose = FALSE, swipeToStep = FALSE, backdrop = FALSE,
                    closeByOutsideClick = TRUE, swipeHandler = TRUE) {

  orientation <- match.arg(orientation)

  sheetCl <- "sheet-modal"
  if (orientation == "top") sheetCl <- paste0(sheetCl, " sheet-modal-top")

  sheetCSS <- "overflow: hidden;"
  sheetCSS <- if (orientation == "bottom") {
    paste0(sheetCSS, " border-radius: 15px 15px 0 0;")
  } else {
    paste0(sheetCSS, "border-radius: 0 0 15px 15px;")
  }

 # props
 sheetProps <- dropNulls(
    list(
       class = sheetCl,
       id = id,
       style = if (swipeToStep | swipeToClose) "height: auto;",
       style = sheetCSS,
       `data-swipe-to-close` = tolower(swipeToClose),
       `data-swipe-to-step` = tolower(swipeToStep),
       `data-close-by-outside-click` = tolower(closeByOutsideClick),
       `data-backdrop` = tolower(backdrop)
    )
 )

 sheetTag <- do.call(shiny::tags$div, sheetProps)

 swiperHandlerCSS <- "height: 16px;
    position: absolute;
    left: 0;
    width: 100%;
    cursor: pointer;
    z-index: 10;"
 swiperHandlerCSS <- if (orientation == "bottom") {
   paste0(swiperHandlerCSS, " top: 0;")
 } else {
   paste0(swiperHandlerCSS, " bottom: 0;")
 }

 # inner sheet elements
 shiny::tagAppendChildren(
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
#' @param id Sheet id.
#' @param session Shiny session object
#' @export
#' @rdname sheet
#' @examples
#' # Toggle sheet modal
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'     ui = f7Page(
#'        title = "Update f7Sheet",
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
#'           updateF7Gauge(id = "mygauge", value = input$obs)
#'        })
#'        observeEvent(input$go, {
#'           updateF7Sheet(id = "sheet1")
#'        })
#'     }
#'  )
#' }
updateF7Sheet <- function(id, session = shiny::getDefaultReactiveDomain()) {
   session$sendInputMessage(id, NULL)
}
