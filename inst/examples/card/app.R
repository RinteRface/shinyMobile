library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Expandable Cards",
    f7SingleLayout(
      navbar = f7Navbar(title = "Expandable Cards"),
      f7ExpandableCard(
        id = "card1",
        title = "Expandable Card 1",
        image = "https://i.pinimg.com/originals/73/38/6e/73386e0513d4c02a4fbb814cadfba655.jpg",
        "Framework7 - is a free and open source HTML mobile framework
         to develop hybrid mobile apps or web apps with iOS or Android
         native look and feel. It is also an indispensable prototyping apps tool
         to show working app prototype as soon as possible in case you need to."
      ),
      hr(),
      f7BlockTitle(title = "Click below to expand the card!") %>% f7Align(side = "center"),
      f7Button(inputId = "go", label = "Go"),
      br(),
      f7ExpandableCard(
        id = "card2",
        title = "Expandable Card 2",
        fullBackground = TRUE,
        image = "https://cdn.pixabay.com/photo/2017/10/03/18/55/mountain-2813667_960_720.png",
        "Framework7 - is a free and open source HTML mobile framework
        to develop hybrid mobile apps or web apps with iOS or Android
        native look and feel. It is also an indispensable prototyping apps tool
        to show working app prototype as soon as possible in case you need to."
      )
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$go, {
      updateF7Card(id = "card2")
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
