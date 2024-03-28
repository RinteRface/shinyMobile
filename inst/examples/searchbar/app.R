library(shiny)
library(shinyMobile)

cities <- names(precip)

app <- shinyApp(
  ui = f7Page(
    title = "Expandable searchbar",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "f7Searchbar with trigger",
        subNavbar = f7SubNavbar(
          f7Searchbar(id = "search1", expandable = TRUE)
        )
      ),
      f7Block(
        f7SearchbarTrigger(targetId = "search1")
      ) %>% f7HideOnSearch(),
      f7List(
        lapply(seq_along(cities), function(i) {
          f7ListItem(cities[i])
        })
      ) %>% f7Found(),
      f7Block(
        p("Nothing found")
      ) %>% f7NotFound()
    )
  ),
  server = function(input, output) {}
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
