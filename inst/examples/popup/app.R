library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Popup",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "f7Popup"
      ),
      f7Block(f7Button("toggle1", "Toggle Popup")),
      br(),
      f7Block(f7Button("toggle2", "Toggle Page Popup"))
    )
  ),
  server = function(input, output, session) {

    output$res1 <- renderPrint(input$text)
    output$res2 <- renderPrint(input$text2)

    observeEvent(input$toggle1, {
      f7Popup(
        id = "popup1",
        title = "My first popup",
        f7Text(
          "text1", "Popup content",
          "This is my first popup ever, I swear!"
        ),
        verbatimTextOutput("res1")
      )
    })

    observeEvent(input$toggle2, {
      f7Popup(
        id = "popup2",
        title = "My first popup",
        page = TRUE,
        f7Text(
          "text2", "Popup content",
          "Look at me, I can scroll!"
        ),
        verbatimTextOutput("res2"),
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
    })

    observeEvent(input$popup1, {
      popupStatus <- if (input$popup1) "opened" else "closed"

      f7Toast(
        position = "top",
        text = paste("Popup1 is", popupStatus)
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
