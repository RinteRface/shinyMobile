library(shiny)
library(shinyWidgets)
library(shinyMobile)


ui <- f7Page(
  title = "Insert a tab Before the target",
  f7TabLayout(
    panels = tagList(
      f7Panel(title = "Left Panel", side = "left", theme = "light", f7Button(inputId = "stayside", label = "Please StaySide"), effect = "cover"),
      f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", effect = "cover")
    ),
    navbar = f7Navbar(
      title = "Tabs",
      hairline = FALSE,
      shadow = TRUE,
      leftPanel = TRUE,
      rightPanel = TRUE
    ),
    f7Tabs(
      animated = TRUE,
      id = "tabs",
      f7Tab(
        tabName = "Tab 1",
        icon = f7Icon("airplane"),
        uiOutput("timers"),
        f7Text(inputId = "input1", label ="toupper input1", placeholder = "Enter something here"),
        
        uiOutput("CAPS"),
        active = TRUE,
        #      "Tab 1",      # in this page, the tab label under the icon looks like it is grabbed from line 25 tabName = "Tab 1"
        f7Button(inputId = "add", label = "One-time add Tab 2")
      )
    )
  )
)


server <- function(input, output, session) {
  
  observeEvent(input$add, {
    insertF7Tab(
      id = "tabs",
      position = "after",
      target = "Tab 1",
      tab = f7Tab (
        # Use multiple elements to test for accessor function
        f7Button(inputId = "stay", label = "Please Stay Button"),
        uiOutput("timers"),
        uiOutput("CAPS"),
        f7Text(inputId = "input2", label ="tolower input2", placeholder = "Enter something here"),
        tabName = "tabX", # in this page, the tab label under the icon looks like it is grabbed from line 53 "Tab 2" instead of line 52 
        "Tab 2",
        icon = f7Icon("app_badge")
      ),
      select = TRUE
    )
    removeUI(
      selector = "#add"
    )
  })
  
  output$CAPS <- renderUI( 
    tagList(
      hr(),
      h4( paste("THIS IS THE CAPITALIZED input1:",toupper(as.character(input$input1)))),
      h4( paste("this is the lowercase input2 from :", tolower(as.character(input$input2)))),
      hr()
    ))
  
  observe({
    invalidateLater(1000)
    output$timers <- renderUI(
      h4(format(Sys.time(), "%a %b %d %X %Y")))
  })
  observeEvent({input$stay 
    input$stayside}, {
      f7Toast("Please stay")
    })
  
}


shinyApp(ui, server)

