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
      skin = "ios",
      theme = "dark",
      filled = TRUE,
      hideNavOnPageScroll = FALSE,
      hideTabsOnPageScroll = FALSE,
      serviceWorker = "service-worker.js",
      iosTranslucentBars = FALSE,
      pullToRefresh = FALSE
    ),
    f7TabLayout(
      appbar = f7Appbar(
        f7Flex(f7Back(targetId = "tabset"), f7Next(targetId = "tabset")),
        f7Searchbar(id = "search1", inline = TRUE, placeholder = "Try me on the 4th tab!")
      ),
      panels = tagList(
        f7Panel(
          inputId = "panelLeft",
          title = "Left Panel",
          side = "left",
          theme = "light",
          "Blabla",
          effect = "reveal"
        ),
        f7Panel(
          title = "Right Panel",
          side = "right",
          theme = "dark",
          "Blabla",
          effect = "cover"
        )
      ),
      navbar = f7Navbar(
        title = "shinyMobile",
        subtitle = "for Shiny",
        hairline = TRUE,
        shadow = TRUE,
        left_panel = TRUE,
        right_panel = TRUE,
        bigger = TRUE,
        transparent = FALSE
      ),
      f7Login(
        id = "loginPage",
        title = "You really think you can go here?",
        footer = "This section simulates an authentication process. There
        is actually no user and password database. Put whatever you want but
        don't leave blank!",
        startOpen = FALSE,
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
        animated = FALSE,
        swipeable = TRUE,
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

    # trigger for login
    trigger <- reactive({
      req(input$tabset == "Text")
    })
    # login server module
    callModule(
      f7LoginServer,
      id = "loginPage",
      ignoreInit = TRUE,
      trigger = trigger
    )

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


    # popup
    output$popupContent <- renderPrint(input$popupText)

    observeEvent(input$togglePopup, {
      f7TogglePopup(id = "popup1")
    })

    observeEvent(input$popup1, {
      if (input$tabset == "Popups") {
        popupStatus <- if (input$popup1) "opened" else "closed"
        f7Toast(
          session,
          position = "top",
          text = paste("Popup is", popupStatus)
        )
      }
    })

    # sheet plot
    output$sheetPlot <- renderPlot({
      hist(rnorm(input$sheetObs))
    })

    observeEvent(input$toggleSheet, {
      updateF7Sheet(inputId = "sheet1", session = session)
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

    # Dialogs
    # notifications
    lapply(1:3, function(i) {
      observeEvent(input[[paste0("goDialog", i)]], {

        if (i == 1) {
          f7Dialog(
            title = "Dialog title",
            text = "This is an alert dialog",
            session = session
          )
        } else if (i == 2) {
          f7Dialog(
            inputId = "confirmDialog",
            title = "Dialog title",
            type = "confirm",
            text = "This is an confirm dialog",
            session = session
          )
        } else if (i == 3) {
          f7Dialog(
            inputId = "promptDialog",
            title = "Dialog title",
            type = "prompt",
            text = "This is a prompt dialog",
            session = session
          )
        }
      })
    })

    observeEvent(input$confirmDialog, {
      f7Toast(session, text = paste("Alert input is:", input$confirmDialog))
    })

    output$promptres <- renderUI({
      if (is.null(input$promptDialog)) {
        f7BlockTitle(title = "Click on dialog button 3")
      }
      f7BlockTitle(title = input$promptDialog)
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

    # action sheet
    observeEvent(input$goActionSheet, {
      f7ActionSheet(
        grid = TRUE,
        id = "action1",
        icons = list(f7Icon("info"), f7Icon("lightbulb_fill")),
        buttons = data.frame(
          text = c('Notification', 'Dialog'),
          color = c(NA, NA)
        )
      )
    })

    observeEvent(input$button, {
      if (input$button == 1) {
        f7Notif(
          text = "You clicked on the first button",
          icon = f7Icon("bolt_fill"),
          title = "Notification",
          titleRightText = "now",
          session = session
        )
      } else if (input$button == 2) {
        f7Dialog(
          inputId = "actionSheetDialog",
          title = "Click me to launch a Toast!",
          type = "confirm",
          text = "You clicked on the second button",
          session = session
        )
      }
    })

    observeEvent(input$actionSheetDialog, {
      f7Toast(session, text = paste("Alert input is:", input$actionSheetDialog))
    })

    # update progress bar
    observeEvent(input$updatepg1, {
      updateF7Progress(session, id = "pg1", value = input$updatepg1)
    })

    # update gauge
    observeEvent(input$updategauge1, {
      updateF7Gauge(session, id = "mygauge1", value = input$updategauge1)
    })

    # expand card 3
    observeEvent(input$goCard, {
      updateF7Card(id = "card3", session = session)
    })

    # toggle accordion
    observeEvent(input$goAccordion, {
      updateF7Accordion(
        inputId = "accordion1",
        selected = 1,
        session = session
      )
    })

    # update panel
    observeEvent(input$goPanel, {
      updateF7Panel(inputId = "panelLeft", session = session)
    })

    # swipeout
    observeEvent(input$swipeNotif, {
      f7Notif(
        text = "test",
        icon = f7Icon("bolt_fill"),
        title = "Notification",
        subtitle = "A subtitle",
        titleRightText = "now",
        session = session
      )
    })

    observeEvent(input$swipeAlert, {
      f7Dialog(
        title = "Dialog title",
        text = "This is an alert dialog",
        session = session
      )
    })

    observeEvent(input$swipeActionSheet, {
      f7ActionSheet(
        grid = TRUE,
        id = "swipeAction",
        icons = list(f7Icon("info"), f7Icon("lightbulb_fill")),
        buttons = data.frame(
          text = c('Notification', 'Dialog'),
          color = c(NA, NA)
        )
      )
    })

    # pull to refresh
    observeEvent(input$ptr, {

      ptrStatus <- if (input$ptr) "on"

      f7Dialog(
        session = session,
        text = paste('ptr is', ptrStatus),
        type = "alert"
      )
    })

  }
)
