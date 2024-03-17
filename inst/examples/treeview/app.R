library(shiny)
# library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "My app",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7Treeview"),

      # simple treeview
      f7Treeview(
        lapply(1:3, function(i) f7TreeviewItem(label = paste0("Item ", letters[i])))
      ),

      # simple treeview with icons
      f7Treeview(
        lapply(1:3, function(i) f7TreeviewItem(label = paste0("Item ", letters[i]),
                                               icon = f7Icon("folder_fill")))
      ),

      # group treeview with icons
      f7Treeview(
        f7TreeviewGroup(
          title = "Images",
          icon = f7Icon("folder_fill"),
          lapply(1:3, function(i) f7TreeviewItem(label = paste0("image", i, ".png"),
                                                 icon = f7Icon("photo_fill")))
        )
      )
    )
  ),
  server = function(input, output) {}
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
