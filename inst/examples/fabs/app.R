library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Update f7Fabs",
    f7SingleLayout(
      navbar = f7Navbar(title = "Update f7Fabs"),
      toolbar = f7Toolbar(
        position = "bottom",
        lapply(1:3, function(i) f7Link(label = i, href = "#") |> f7FabClose())
      ) |> f7FabMorphTarget(),
      # put an empty f7Fabs container
      f7Fabs(
        id = "fabsMorph",
        extended = TRUE,
        label = "Open",
        position = "center-bottom",
        color = "yellow",
        sideOpen = "right",
        morphTarget = ".toolbar"
      ),
      f7Block(f7Button(inputId = "toggle", label = "Toggle Fabs")),
      f7Fabs(
        position = "center-center",
        id = "fabs",
        lapply(1:3, function(i) f7Fab(inputId = i, label = i))
      ),
      f7BlockTitle("Output"),
      f7Block(
        textOutput("res")
      ),
      f7BlockTitle("Page Content"),
      f7Block(
        p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse
            hendrerit magna non sem iaculis, ac rhoncus est pulvinar. Interdum et
            malesuada fames ac ante ipsum primis in faucibus. In sagittis vel lacus
            ac bibendum. Maecenas mollis, diam nec fermentum sollicitudin, massa
            lectus ullamcorper orci, in laoreet lectus quam nec lacus.
            Nulla sollicitudin imperdiet metus, quis mollis justo finibus varius.
            In mattis malesuada enim in tincidunt. Nulla vehicula dui lacus,
            iaculis condimentum dui dapibus ac. Cras elit nunc, auctor vestibulum
            odio id, iaculis posuere arcu. Mauris dignissim id lectus sit amet
            vestibulum. Nam rutrum sit amet augue vel interdum. Donec sed orci vitae
            eros eleifend posuere vitae id nibh. Donec faucibus erat in placerat
            feugiat. Sed sodales facilisis eros, porta viverra purus pretium eu.
            Morbi vehicula metus lacus, id commodo mauris posuere nec. Vivamus
            ornare et lacus et lobortis. Etiam tristique elit id eros ornare,
            vel faucibus mauris hendrerit. Nulla elit nulla, consequat sit amet
            neque et, ultrices elementum diam. Etiam dignissim elit a arcu pulvinar,
            ut dapibus elit maximus. Mauris ultricies nulla in mauris laoreet, at
            lacinia lorem maximus. Nulla sed enim diam. In ac felis dignissim,
            euismod augue nec, tempus augue. Maecenas eget aliquam mi.
            In tincidunt massa a velit suscipit, ac dapibus mi laoreet. Vestibulum
            lacinia nulla lorem, nec blandit quam sollicitudin at. Pellentesque
            in vehicula lacus. Etiam vitae lectus malesuada, hendrerit mauris eu,
            placerat elit. Mauris vehicula dictum pharetra. Etiam interdum vehicula
            urna, ac blandit lectus posuere id. Nullam facilisis tincidunt sem et
            pretium. Praesent pulvinar feugiat augue, quis pretium nunc vestibulum a.
            Morbi id eros eget lectus placerat placerat. Morbi dapibus viverra
            orci nec pellentesque. Vestibulum mollis gravida sem, quis tincidunt
            sem maximus gravida. Nam id egestas augue, sit amet egestas orci. Duis
            porttitor lectus sit amet efficitur auctor. Quisque dui ante, eleifend
            eget nibh a, tincidunt interdum nisi. Integer varius tempor erat, in
            commodo neque elementum ut. Maecenas eu lorem ultrices, posuere neque ac,
            aliquam ante. Maecenas eu volutpat arcu. Morbi hendrerit sem sed vehicula
            sodales. Quisque ultrices massa erat, vel accumsan risus vehicula eu.
            Donec laoreet aliquet est, a consequat odio viverra lacinia. Suspendisse
            id iaculis risus. Vestibulum posuere dignissim lacus quis ornare. Nam
            dapibus efficitur neque sed tristique."
        )
      )
    )
  ),
  server = function(input, output, session) {
    output$res <- renderText(input[["1"]])

    observeEvent(input$toggle, {
      updateF7Fabs(id = "fabs")
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
