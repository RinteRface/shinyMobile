library(shinyWidgets)
shiny::shinyApp(
  ui = f7Page(
    title = "My app",

    f7Block(
      strong = TRUE,
      # action button
      actionButton("goButton", "Go!"),
      verbatimTextOutput("actionBttn"),
      br(),

      # checkbox
      f7Row(
        prettyCheckbox(
          inputId = "checkbox1",
          label = "Click me!",
          status = "primary",
          animation = "pulse"
        ),
        verbatimTextOutput(outputId = "res1")
      ),

      # radio button
      f7Row(
        prettyRadioButtons(
          inputId = "radio2",
          inline = TRUE,
          label = "Click me!",
          thick = TRUE,
          choices = c("Click me !", "Me !", "Or me !"),
          animation = "pulse",
          status = "danger"
        ),
        verbatimTextOutput(outputId = "res2")
      ),

      # pretty switch
      f7Row(
        prettySwitch(
          inputId = "switch3",
          status = "success",
          label = "Slim switch:",
          slim = TRUE
        ),
        verbatimTextOutput(outputId = "res3")
      ),


      # checkboxGroup
      f7Row(
        prettyCheckboxGroup(
          inputId = "checkgroup4",
          label = "Click me!",
          status = "warning",
          choices = c("Click me !", "Me !", "Or me !"),
          outline = TRUE,
          inline = TRUE,
          plain = TRUE,
          icon = icon("thumbs-up")
        ),
        verbatimTextOutput(outputId = "res4")
      ),

      # normal switch
      f7Row(
        switchInput(inputId = "switchvalue"),
        verbatimTextOutput("res5")
      ),

      # awesome checkbox
      f7Row(
        awesomeCheckbox(
          inputId = "checkvalue",
          label = "A single checkbox",
          value = TRUE,
          status = "info"
        ),
        verbatimTextOutput("res6")
      ),

      # awesome radio (inline is buggy)
      f7Row(
        awesomeRadio(
          inputId = "id1", label = "Make a choice:",
          choices = c("graphics", "ggplot2")
        ),
        verbatimTextOutput(outputId = "res7")
      ),

      # awesome checkbox group (inline is buggy)
      f7Row(
        awesomeCheckboxGroup(
          inputId = "id2", label = "Make a choice:",
          choices = c("graphics", "ggplot2"), inline = TRUE
        ),
        verbatimTextOutput(outputId = "res8")
      ),


      # pickerInput (buggy)
      f7Row(
        pickerInput(
          inputId = "classic",
          label = "Select max two option below:",
          choices = c("A", "B", "C", "D"),
          multiple = TRUE,
          options =  list(
            "max-options" = 2,
            "max-options-text" = "No more!"
          )
        ),
        verbatimTextOutput(outputId = "res_classic")
      ),


      # pretty toggle
      f7Row(
        prettyToggle(inputId = "toggle3",  label_on = "Yes!",
                     label_off = "No..", shape = "round",
                     fill = TRUE, value = TRUE),
        verbatimTextOutput(outputId = "res10")
      ),

      # select input
      f7Row(
        selectInput("variable", "Variable:",
                    c("Cylinders" = "cyl",
                      "Transmission" = "am",
                      "Gears" = "gear")),
        tableOutput("data")
      )
    )

  ),
  server = function(input, output) {
    output$actionBttn <- renderPrint(input$goButton)
    output$res1 <- renderPrint(input$checkbox1)
    output$res2 <- renderPrint(input$radio2)
    output$res3 <- renderPrint(input$switch3)
    output$res4 <- renderPrint(input$checkgroup4)
    output$res5 <- renderPrint({ input$switchvalue })
    output$res6 <- renderText({ input$checkvalue })
    output$res7 <- renderPrint({input$id1})
    output$res8 <- renderPrint({input$id1})
    output$res_classic <- renderPrint(input$classic)
    output$res10 <- renderPrint(input$toggle3)
    output$data <- renderTable({
      mtcars[, c("mpg", input$variable), drop = FALSE]
    }, rownames = TRUE)
  }
)
