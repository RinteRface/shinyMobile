library(shiny)
library(shinyMobile)
library(plotly)

# source modules
e <- environment()
path <- system.file("examples/gallery/tabs/", package = "shinyMobile")
sapply(
  list.files(
    path,
    include.dirs = FALSE,
    pattern = ".R",
    ignore.case = TRUE
  ),
  function(f) { source(paste0(path, f), local = e) }
)

# shiny app
shinyApp(
  ui = f7Page(
    title = "shinyMobile",
    init = f7Init(
      skin = "md",
      theme = "light",
      filled = TRUE,
      hideNavOnPageScroll = FALSE,
      hideTabsOnPageScroll = FALSE,
      serviceWorker = "service-worker.js"
    ),
    f7TabLayout(
      appbar = f7Appbar(
        maximizable = TRUE,
        f7Flex(f7Back(targetId = "tabset"), f7Next(targetId = "tabset")),
        f7Searchbar(id = "search1", inline = TRUE, placeholder = "Try me on the 4th tab!")
      ),
      panels = tagList(
        f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", effect = "reveal"),
        f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", effect = "cover")
      ),
      navbar = f7Navbar(
        title = "miniUI 2.0",
        subtitle = "for Shiny",
        hairline = TRUE,
        shadow = TRUE,
        left_panel = TRUE,
        right_panel = TRUE,
        bigger = FALSE
      ),
      # recover the color picker input and update the text background
      # color accordingly.
      shiny::tags$script(
        "$(function() {
          Shiny.addCustomMessageHandler('text-color', function(message) {
            $('#colorPickerVal').css('background-color', message);
          });
        });
        "
      ),
      f7Tabs(
        id = "tabset",
        animated = TRUE,
        tabInputs,
        tabBtns,
        tabCards,
        tabLists,
        tabText,
        tabInfo,
        tabOthers
      )
    )
  ),
  server = function(input, output, session) {
    output$text <- renderPrint(input$text)
    output$password <- renderPrint(input$password)
    output$slider <- renderPrint(input$slider)
    output$sliderRange <- renderPrint(input$sliderRange)
    output$stepper <- renderPrint(input$stepper)
    output$check <- renderPrint(input$check)
    output$checkgroup <- renderPrint(input$checkgroup)
    output$radio <- renderPrint(input$radio)
    output$toggle <- renderPrint(input$toggle)
    output$select <- renderPrint(input$select)
    output$val <- renderPrint(input$button2)
    output$smartdata <- renderTable({
      head(mtcars[, c("mpg", input$smartsel), drop = FALSE])
    }, rownames = TRUE)
    output$selectDate <- renderText(input$date)
    output$autocompleteval <- renderPrint(input$myautocomplete)

    lapply(1:12, function(i) {
      output[[paste0("res", i)]] <- renderText(paste0("Button", i ," is ", input[[paste0("btn", i)]]))
    })
    output$pickerval <- renderText(input$mypicker)
    output$colorPickerVal <- renderText(input$mycolorpicker)

    # send the color picker input to JS
    observe({
      session$sendCustomMessage(type = "text-color", message = input$mycolorpicker)
    })

    # notifications
    lapply(1:3, function(i) {
      observeEvent(input[[paste0("goNotif", i)]],{

        icon <- if (i %% 2 == 0) f7Icon("bolt_fill") else NULL

        f7Notif(
          text = "test",
          icon = icon,
          title = paste("Notification", i),
          subtitle = "A subtitle",
          titleRightText = i,
          session = session
        )
      })
    })

    # popovers
    observe({
      f7Popover(
        targetId = "popoverTrigger",
        content = "This is a f7Button",
        session
      )
    })

    # toasts
    observeEvent(input$toast, {
      f7Toast(
        session,
        position = "bottom",
        text = "I am a toast. Eat me!"
      )
    })

  }
)
