library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Virtual List",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Virtual Lists"
      ),
      # controls
      f7Segment(
        f7Button(inputId = "appendItem", "Append Item"),
        f7Button(inputId = "prependItems", "Prepend Items"),
        f7Button(inputId = "insertBefore", "Insert before"),
        f7Button(inputId = "replaceItem", "Replace Item")
      ),
      f7Segment(
        f7Button(inputId = "deleteAllItems", "Remove All"),
        f7Button(inputId = "moveItem", "Move Item"),
        f7Button(inputId = "filterItems", "Filter Items")
      ),
      f7Grid(
        cols = 3,
        uiOutput("itemIndexUI"),
        uiOutput("itemNewIndexUI"),
        uiOutput("itemsFilterUI")
      ),
      # searchbar
      f7Searchbar(id = "search1"),
      # main content
      f7VirtualList(
        id = "vlist",
        rowsBefore = 2,
        rowsAfter = 2,
        mode = "media",
        items = lapply(1:1000, function(i) {
          f7VirtualListItem(
            title = paste("Title", i),
            subtitle = paste("Subtitle", i),
            header = paste("Header", i),
            footer = paste("Footer", i),
            right = paste("Right", i),
            content = paste0("Content", i),
            media = img(style = "border-radius: 8px",
                        src = "https://cdn.framework7.io/placeholder/fashion-88x88-1.jpg")
          )
        })
      )
    )
  ),
  server = function(input, output) {

    output$itemIndexUI <- renderUI({
      req(input$vlist$length > 2)
      f7Stepper(
        inputId = "itemIndex",
        label = "Index",
        min = 1,
        value = 2,
        max = input$vlist$length
      )
    })

    output$itemNewIndexUI <- renderUI({
      req(input$vlist$length > 2)
      f7Stepper(
        inputId = "itemNewIndex",
        label = "New Index",
        min = 1,
        value = 1,
        max = input$vlist$length
      )
    })

    output$itemsFilterUI <- renderUI({
      input$appendItem
      input$prependItems
      input$insertBefore
      input$replaceItem
      input$deleteAllItems
      input$moveItem
      isolate({
        req(input$vlist$length > 2)
        f7Slider(
          inputId = "itemsFilter",
          label = "Items to Filter",
          min = 1,
          max = input$vlist$length,
          value = c(1, input$vlist$length)
        )
      })
    })

    observeEvent(input$appendItem, {
      updateF7VirtualList(
        id = "vlist",
        action = "appendItem",
        item = f7VirtualListItem(
          title = "New Item Title",
          right = "New Item Right",
          content = "New Item Content",
          media = img(src = "https://cdn.framework7.io/placeholder/fashion-88x88-3.jpg")
        )
      )
    })

    observeEvent(input$prependItems, {
      updateF7VirtualList(
        id = "vlist",
        action = "prependItems",
        items = lapply(1:5, function(i) {
          f7VirtualListItem(
            title = paste("Title", i),
            right = paste("Right", i),
            content = i,
            media = img(src = "https://cdn.framework7.io/placeholder/fashion-88x88-3.jpg")
          )
        })
      )
    })

    observeEvent(input$insertBefore, {
      updateF7VirtualList(
        id = "vlist",
        action = "insertItemBefore",
        index = input$itemIndex,
        item = f7VirtualListItem(
          title = "New Item Title",
          content = "New Item Content",
          media = img(src = "https://cdn.framework7.io/placeholder/fashion-88x88-3.jpg")
        )
      )
    })

    observeEvent(input$replaceItem, {
      updateF7VirtualList(
        id = "vlist",
        action = "replaceItem",
        index = input$itemIndex,
        item = f7VirtualListItem(
          title = "Replacement",
          content = "Replacement Content",
          media = img(src = "https://cdn.framework7.io/placeholder/fashion-88x88-3.jpg")
        )
      )
    })

    observeEvent(input$deleteAllItems, {
      updateF7VirtualList(
        id = "vlist",
        action = "deleteAllItems"
      )
    })

    observeEvent(input$moveItem, {
      updateF7VirtualList(
        id = "vlist",
        action = "moveItem",
        oldIndex = input$itemIndex,
        newIndex = input$itemNewIndex
      )
    })

    observeEvent(input$filterItems, {
      updateF7VirtualList(
        id = "vlist",
        action = "filterItems",
        indexes = input$itemsFilter[1]:input$itemsFilter[2]
      )
    })

  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
