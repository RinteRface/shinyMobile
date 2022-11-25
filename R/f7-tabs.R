#' Create a Framework7 tabs
#'
#' By default, \link{f7Tabs} are used within the \link{f7TabLayout}. However, you
#' may use them as standalone components if you specify a the segmented or strong
#' styles.
#'
#' @param ... Slot for \link{f7Tab}.
#' @param .items Slot for other items that could be part of the toolbar such as
#' buttons or \link{f7TabLink}. This may be useful to open an \link{f7Sheet} from
#' the tabbar.
#' @param id Optional to get the id of the currently selected \link{f7Tab}.
#' @param swipeable Whether to allow finger swip. FALSE by default. Only for touch-screens.
#' Not compatible with animated.
#' @param animated Whether to show transition between tabs. TRUE by default.
#' Not compatible with swipeable.
#' @param style Tabs style: \code{c("toolbar", "segmented", "strong")}. If style
#' is toolbar, then \link{f7Tab} have a toolbar behavior.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
#' @examples
#' if (interactive()) {
#'  # tabs as toolbar
#'  library(shiny)
#'  library(shinyMobile)
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Tab Layout",
#'     f7TabLayout(
#'       navbar = f7Navbar(title = HTML(paste("Currently selected:", textOutput("selected")))),
#'       f7Tabs(
#'         id = "tabdemo",
#'         swipeable = TRUE,
#'         animated = FALSE,
#'         f7Tab(
#'          title = "Tab 1",
#'          tabName = "Tab1",
#'          f7Sheet(
#'           id = "sheet",
#'           label = "More",
#'           orientation = "bottom",
#'           swipeToClose = TRUE,
#'           swipeToStep = TRUE,
#'           backdrop = TRUE,
#'           "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#'           Quisque ac diam ac quam euismod porta vel a nunc. Quisque sodales
#'           scelerisque est, at porta justo cursus ac"
#'          )
#'         ),
#'         f7Tab(title = "Tab 2", tabName = "Tab2", "tab 2 text"),
#'         f7Tab(title = "Tab 3", tabName = "Tab3", "tab 3 text"),
#'         .items = f7TabLink(
#'          icon = f7Icon("bolt_fill"),
#'          label = "Toggle Sheet",
#'          `data-sheet` = "#sheet",
#'          class = "sheet-open"
#'         )
#'       )
#'     )
#'   ),
#'   server = function(input, output) {
#'     output$selected <- renderText(input$tabdemo)
#'   }
#'  )
#'  # standalone tabs
#'  library(shiny)
#'  library(shinyMobile)
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7SingleLayout(
#'        navbar = f7Navbar(
#'          title = "Standalone tabs",
#'          hairline = FALSE,
#'          shadow = TRUE
#'        ),
#'        f7Tabs(
#'          id = "tabs",
#'          style = "strong", animated = FALSE, swipeable = TRUE,
#'          f7Tab(
#'            tabName = "Tab1",
#'            icon = f7Icon("envelope"),
#'            active = TRUE,
#'            f7Shadow(
#'              intensity = 10,
#'              hover = TRUE,
#'              f7Card(
#'                title = "Card header",
#'                f7Stepper(
#'                  "obs1",
#'                  "Number of observations",
#'                  min = 0,
#'                  max = 1000,
#'                  value = 500,
#'                  step = 100
#'                ),
#'                plotOutput("distPlot")
#'              )
#'            )
#'          ),
#'          f7Tab(
#'            tabName = "Tab2",
#'            icon = f7Icon("today"),
#'            f7Shadow(
#'              intensity = 10,
#'              hover = TRUE,
#'              f7Card(
#'                title = "Card header",
#'                f7Select(
#'                  inputId = "obs2",
#'                  label = "Distribution type:",
#'                  choices = c(
#'                    "Normal" = "norm",
#'                    "Uniform" = "unif",
#'                    "Log-normal" = "lnorm",
#'                    "Exponential" = "exp"
#'                  )
#'                ),
#'                plotOutput("distPlot2")
#'              )
#'            )
#'          ),
#'          f7Tab(
#'            tabName = "Tab3",
#'            icon = f7Icon("cloud_upload"),
#'            f7Shadow(
#'              intensity = 10,
#'              hover = TRUE,
#'              f7Card(
#'                title = "Card header",
#'                f7SmartSelect(
#'                  inputId = "variable",
#'                  label = "Variables to show:",
#'                  c("Cylinders" = "cyl",
#'                    "Transmission" = "am",
#'                    "Gears" = "gear"),
#'                  multiple = TRUE,
#'                  selected = "cyl"
#'                ),
#'                tableOutput("data")
#'              )
#'            )
#'          )
#'        )
#'      )
#'    ),
#'    server = function(input, output) {
#'      output$distPlot <- renderPlot({
#'        dist <- rnorm(input$obs1)
#'        hist(dist)
#'      })
#'
#'      output$distPlot2 <- renderPlot({
#'        dist <- switch(
#'          input$obs2,
#'          norm = rnorm,
#'          unif = runif,
#'          lnorm = rlnorm,
#'          exp = rexp,
#'          rnorm
#'        )
#'
#'        hist(dist(500))
#'      })
#'
#'      output$data <- renderTable({
#'        mtcars[, c("mpg", input$variable), drop = FALSE]
#'      }, rownames = TRUE)
#'    }
#'  )
#' }
f7Tabs <- function(..., .items = NULL, id = NULL, swipeable = FALSE, animated = TRUE,
                   style = c("toolbar", "segmented", "strong")) {

  style <- match.arg(style)
  if (swipeable && animated) stop("Cannot use two effects at the same time")
  if (is.null(id)) id <- paste0("tabs_", round(stats::runif(1, min = 0, max = 1e9)))
  ns <- shiny::NS(id)
  items <- list(...)
  found_active <- FALSE

  tabItems <- lapply(seq_along(items), FUN = function(i) {

    item <- items[[i]][[1]]
    itemIcon <- items[[i]][[2]]
    itemName <- items[[i]][[5]] # May be NULL
    itemClass <- item$attribs$class
    itemId <- item$attribs$id

    # whether the item is hidden
    itemHidden <- items[[i]][[4]]

    # make sure that if the user set 2 tabs active at the same time,
    # only the first one is selected
    if (!found_active) {
      active <- sum(grep(x = itemClass, pattern = "active")) == 1
      if (active) found_active <<- TRUE
      # if there is already an active panel, set all other to inactive
    } else {
      active <- FALSE
    }

    # generate the link only if the item is visible
    if (!itemHidden) {
      if (!is.null(itemIcon)) {
        if (style %in% c("segmented", "strong")) {
          shiny::tags$button(
            class = if (active) "button tab-link tab-link-active" else "button tab-link",
            `data-tab` = paste0("#", ns(itemId)),
            itemIcon,
            if (!is.null(itemName)) shiny::span(class = "tabbar-label", itemName)
          )
        } else if (style == "toolbar") {
          shiny::a(
            `data-tab` = paste0("#", ns(itemId)),
            class = if (active) "tab-link tab-link-active" else "tab-link",
            itemIcon,
            if (!is.null(itemName)) shiny::span(class = "tabbar-label", itemName)
          )
        }
      } else {
        if (style %in% c("segmented", "strong")) {
          shiny::tags$button(
            class = if (active) "button tab-link tab-link-active" else "button tab-link",
            `data-tab` = paste0("#", ns(itemId)),
            if (!is.null(itemName)) itemName
          )
        } else if (style == "toolbar"){
          shiny::a(
            `data-tab` = paste0("#", ns(itemId)),
            class = if (active) "tab-link tab-link-active" else "tab-link",
            if (!is.null(itemName)) itemName
          )
        }
      }
    }
  })

  # tab links: segmented buttons or toolbar items
  tabLinksTag <- if (style == "segmented") {
    shiny::tags$div(
      class = "block",
      shiny::tags$div(
        class = "segmented segmented-raised",
        tabItems
      )
    )
  } else if (style == "strong") {
    shiny::tags$div(
      class = "block-header",
      shiny::tags$div(
        class = "segmented segmented-strong",
        tabItems,
        shiny::span(class = "segmented-highlight")
      )
    )
  } else if (style == "toolbar") {
    f7Toolbar(
      position = "bottom",
      hairline = TRUE,
      shadow = TRUE,
      icons = TRUE,
      scrollable = FALSE,
      tabItems,
      # other items here
      .items
    )
  }

  # this is for the insertF7Tab and removeF7Tab functions
  # since the menu container is not the same, we need a common
  # css class.
  tabLinksTag <- tagAppendAttributes(tabLinksTag, class = "tabLinks")

  # related page content
  contentTag <- shiny::tags$div(
    # ios-edges necessary to have
    # the good ios rendering
    class = if (style %in% c("segmented", "strong")) {
      "tabs standalone ios-edges"
    } else {
      "tabs ios-edges"
    },
    lapply(seq_along(items), function(i) {
      items[[i]][[1]]$attribs$id <- ns(items[[i]][[1]]$attribs$id)
      if (style %in% c("segmented", "strong")) {
        items[[i]][[1]]$attribs$class <- strsplit(
          items[[i]][[1]]$attribs$class,
          "page-content"
        )[[1]][2]
      }
      # we don't change data value
      items[[i]][[1]]
    })
  )

  contentTag$attribs$id <- id

  # remove bottom margin between tabs and other content
  # only when standalone
  # handle swipeable tabs
  if (swipeable) {
    contentTag <- shiny::tags$div(
      class = if (style %in% c("segmented", "strong")) {
        "tabs-standalone tabs-swipeable-wrap"
      } else {
        "tabs-swipeable-wrap"
      },
      contentTag
    )
  }

  if (animated) {
    contentTag <- shiny::tags$div(
      class = if (style %in% c("segmented", "strong")) {
        "tabs-standalone tabs-animated-wrap"
      } else {
        "tabs-animated-wrap"
      },
      contentTag
    )
  }

  shiny::tagList(tabLinksTag, contentTag)

}


#' Validate a tab name
#'
#' TO avoid JS issues: avoid punctuation and space
#'
#' @param tabName Tab to validate.
#'
#' @return An error if a wrong pattern is found
#' @keywords internal
validate_tabName <- function(tabName) {
  forbidden <- "(?!_)[[:punct:]]|[[:space:]]"
  wrong_selector <- grepl(forbidden, tabName, perl = TRUE)
  if (wrong_selector) {
    stop(
      paste(
        "Please do not use punctuation or space in tabNames.
        This might cause JavaScript issues."
      )
    )
  }
}



#' Create a Framework7 tab item
#'
#' Build a Framework7 tab item
#'
#' @param ... Item content.
#' @param title Tab title (name).
#' @param tabName Item id. Must be unique, without space nor punctuation symbols.
#' @param icon Item icon. Expect \link{f7Icon} function with the suitable lib argument
#' (either md or ios or NULL for native f7 icons).
#' @param active Whether the tab is active at start. Do not select multiple tabs, only
#' the first one will be set to active.
#' @param hidden Whether to hide the tab. This is useful when you want to add invisible tabs
#' (that do not appear in the tabbar) but you can still navigate with \link{updateF7Tabs}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Tab <- function(..., title = NULL, tabName, icon = NULL, active = FALSE, hidden = FALSE) {

  # Tab name validation
  validate_tabName(tabName)

  itemTag <- shiny::tags$div(
    class = if (!active) {
      "page-content tab"
    } else {
      "page-content tab tab-active"
    },
    `data-active` = tolower(active),
    id = tabName,
    `data-value` = tabName,
    `data-hidden` = tolower(hidden),
    ...
  )
  return(list(itemTag, icon, tabName, hidden, title))
}




#' Special button/link to insert in the tabbar
#'
#' Use in the .items slot of \link{f7Tabs}.
#'
#' @param ... Any attribute like \code{`data-sheet`}, id, ...
#' @param icon Expect \link{f7Icon}.
#' @param label Button label.
#'
#' @export
f7TabLink <- function(..., icon = NULL, label = NULL) {
  shiny::tags$a(
    ...,
    class = "tab-link",
    href = "#",
    icon,
    shiny::span(class = "tabbar-label", label)
  )
}




#' Update a Framework 7 tabsetPanel
#'
#' Update \link{f7Tabs}.
#'
#' @param session Shiny session object.
#' @param id Id of the \link{f7Tabs} to update.
#' @param selected Newly selected tab.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  subtabs_ui <- function(id) {
#'    ns <- NS(id)
#'
#'    tagList(
#'      f7Toggle(inputId = ns("updateSubTab"), label = "Update SubTab", checked = FALSE),
#'      f7Tabs(
#'        id = ns("subtabdemo"),
#'        style = "strong",
#'        animated = FALSE,
#'        f7Tab(title = "Subtab 1", tabName = "SubTab1", "SubTab 1"),
#'        f7Tab(title = "Subtab 2", tabName = "SubTab2", "SubTab 2", active = TRUE),
#'        f7Tab(title = "Subtab 3", tabName = "SubTab3", "SubTab 3")
#'      )
#'    )
#'  }
#'
#'  subtabs <- function(input, output, session) {
#'    observeEvent(input$updateSubTab, {
#'      selected <- ifelse(input$updateSubTab, "SubTab1", "SubTab2")
#'      updateF7Tabs(session, id = "subtabdemo", selected = selected)
#'    })
#'    return(reactive(input$subtabdemo))
#'  }
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Tab Layout",
#'      f7TabLayout(
#'        navbar = f7Navbar(
#'          title =
#'            f7Flex(
#'              HTML(paste("Selected Tab:", textOutput("selectedTab"))),
#'              HTML(paste("Selected Subtab:", textOutput("selectedSubTab")))
#'            )
#'          ,
#'          subNavbar = f7SubNavbar(
#'            f7Flex(
#'              f7Toggle(inputId = "updateTab", label = "Update Tab", checked = TRUE),
#'              subtabs_ui("subtabs1")[[1]]
#'            )
#'          )
#'        ),
#'        f7Tabs(
#'          id = "tabdemo",
#'          swipeable = TRUE,
#'          animated = FALSE,
#'          f7Tab(
#'            title = "Tab 1",
#'            tabName = "Tab1",
#'            subtabs_ui("subtabs1")[[2]]
#'          ),
#'          f7Tab(title = "Tab 2", tabName = "Tab2", "Tab 2"),
#'          f7Tab(title = "Tab 3", tabName = "Tab3", "Tab 3")
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      output$selectedTab <- renderText(input$tabdemo)
#'      observeEvent(input$updateTab, {
#'        selected <- ifelse(input$updateTab, "Tab1", "Tab2")
#'        updateF7Tabs(id = "tabdemo", selected = selected)
#'      })
#'      subtab <- callModule(subtabs, "subtabs1")
#'      output$selectedSubTab <- renderText(subtab())
#'    }
#'  )
#'  # with hidden tabs
#'  shinyApp(
#'   ui <- f7Page(
#'     title = "shinyMobile",
#'     f7TabLayout(
#'       navbar = f7Navbar(
#'         title = "Update Tabs with hidden tab",
#'         subtitle = "",
#'         hairline = TRUE,
#'         shadow = TRUE,
#'         bigger = FALSE,
#'         transparent = TRUE
#'       ),
#'       f7Tabs(
#'         id = 'tabs',
#'         animated = TRUE,
#'         f7Tab(
#'           active = TRUE,
#'           title = "Main tab",
#'           tabName = "Tab1",
#'           icon = f7Icon("doc_text"),
#'           h1("This is the first tab."),
#'           f7Button(inputId = "goto", label = "Go to hidden tab")
#'         ),
#'         f7Tab(
#'           title = "Second tab",
#'           tabName = "Tab2",
#'           icon = f7Icon("bolt_horizontal"),
#'           h1("This is the second tab.")
#'         ),
#'         f7Tab(
#'           title = "Hidden tab",
#'           tabName = "Tab3",
#'           hidden = TRUE,
#'           h1("This is a tab that does not appear in the tab menu.
#'           Yet, you can still access it.")
#'         )
#'       )
#'     )
#'   ),
#'   server = function(input, output, session) {
#'     observe(print(input$tabs))
#'     observeEvent(input$goto, {
#'       updateF7Tabs(session = session, id = "tabs", selected = "Tab3")
#'     })
#'   }
#'  )
#' }
updateF7Tabs <- function(id, selected = NULL, session = shiny::getDefaultReactiveDomain()) {
  # remove the space in the tab name
  message <- dropNulls(list(selected = selected, ns = session$ns(id)))
  session$sendInputMessage(id, message)
}




#' Framework7 tab insertion
#'
#' \code{insertF7Tab} inserts an \link{f7Tab} in an \link{f7Tabs}.
#'
#' @rdname inserttab
#' @param id  \link{f7Tabs} id.
#' @param tab \link{f7Tab} to insert.
#' @param target \link{f7Tab} after of before which the new tab will be inserted.
#' @param position Insert before or after: \code{c("before", "after")}.
#' @param select Whether to select the newly inserted tab. FALSE by default.
#' @param session Shiny session object.
#'
#' @export
#' @examples
#' if (interactive()) {
#'  # Insert after
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Insert a tab Before the target",
#'      f7TabLayout(
#'        navbar = f7Navbar(
#'          title = "insertF7Tab",
#'          hairline = FALSE,
#'          shadow = TRUE,
#'          leftPanel = TRUE,
#'          rightPanel = TRUE
#'        ),
#'        f7Tabs(
#'          animated = TRUE,
#'          id = "tabs",
#'          f7Tab(
#'            tabName = "Tab1",
#'            icon = f7Icon("airplane"),
#'            active = TRUE,
#'            "Tab 1",
#'            f7Button(inputId = "add", label = "Add tabs")
#'          ),
#'          f7Tab(
#'            tabName = "Tab2",
#'            icon = f7Icon("today"),
#'            active = FALSE,
#'            f7Button(inputId="stay", label = "Stay"),
#'            "Tab 2"
#'          )
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      observeEvent(input$stay, {
#'        f7Toast("Please stay")
#'      })
#'      observeEvent(input$add, {
#'        insertF7Tab(
#'          id = "tabs",
#'          position = "after",
#'          target = "Tab1",
#'          tab = f7Tab (
#'            # Use multiple elements to test for accessor function
#'            f7Text(inputId = "my_text", label ="Enter something", placeholder = "What?"),
#'            f7Text(inputId = "my_other", label ="Else:", placeholder = "Else ?"),
#'            tabName = paste0("tabx_", input$go),
#'            "Test2",
#'            icon = f7Icon("app_badge")
#'          ),
#'          select = TRUE
#'        )
#'      })
#'    }
#'  )
#'  # Insert in an empty tabsetpanel
#'  library(shiny)
#'  ui <- f7Page(
#'    f7SingleLayout(
#'      navbar = f7Navbar(),
#'      f7Button("add", "Add 'Dynamic' tab"),
#'      br(),
#'      f7Tabs(id = "tabs"),
#'    )
#'  )
#'  server <- function(input, output, session) {
#'    observeEvent(input$add, {
#'      insertF7Tab(
#'        id = "tabs",
#'        f7Tab(title = "Dynamic", tabName = "Dynamic", "This a dynamically-added tab"),
#'        target = NULL
#'      )
#'    })
#'  }
#'  shinyApp(ui, server)
#' }
insertF7Tab <- function(id, tab, target = NULL, position = c("before", "after"),
                        select = FALSE, session = shiny::getDefaultReactiveDomain()) {

  # in shinyMobile, f7Tab returns a list of 5 elements:
  # - 1 is the tag\
  # - 2 is the icon name
  # - 3 is the tabName
  # - 4 hidden
  # - 5 is the title

  # Below we check if the tag is really a shiny tag...
  if (!(class(tab[[1]]) %in% c("shiny.tag" , "shiny.tag.list"))) {
    stop("tab must be a shiny tag")
  }

  nsWrapper <- shiny::NS(id)
  position <- match.arg(position)
  # create the corresponding tab-link
  tabId <- nsWrapper(tab[[1]]$attribs$id)
  children = tab[[1]]$children
  tabLink <- shiny::a(
    class = if (select) "tab-link tab-link-active" else "tab-link",
    `data-tab` = paste0("#", nsWrapper(tab[[1]]$attribs$id)),
    tab[[2]],
    shiny::span(class = "tabbar-label", tab[[1]]$attribs$`data-value`)
  )
  tabLink <- as.character(force(tabLink))

  # force to render shiny.tag and convert it to character
  # since text does not accept anything else
  tab[[1]]$attribs$id <- nsWrapper(tab[[1]]$attribs$id)

  message <- dropNulls(
    list(
      value = processDeps(tab[[1]], session),
      id = tabId,
      link = tabLink,
      target = target,
      position = position,
      select = tolower(select),
      ns = id
    )
  )

  # we need to create a new id not to overlap with the updateF7Tab id
  # prefix by insert_ makes sense
  id <- paste0("insert_", id)
  session$sendCustomMessage(type = id, message)
}


#' Framework7 tab insertion
#'
#' @rdname f7-deprecated
#' @inheritParams insertF7Tab
#' @keywords internal
#' @export
f7InsertTab <- function(id, tab, target, position = c("before", "after"),
                        select = FALSE, session = shiny::getDefaultReactiveDomain()) {
  .Deprecated(
    "insertF7Tab",
    package = "shinyMobile",
    "f7InsertTab will be removed in future release. Please use
      insertF7Tab instead."
  )
  insertF7Tab(id, tab, target, position, select, session)
}



#' Framework7 tab deletion
#'
#' \code{removeF7Tab} removes an \link{f7Tab} in a \link{f7Tabs}.
#'
#' @param id  \link{f7Tabs} id.
#' @param target \link{f7Tab} to remove.
#' @param session Shiny session object.
#'
#' @rdname removetab
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  ui <- f7Page(
#'   title = "Remove a tab",
#'   f7TabLayout(
#'    panels = tagList(
#'      f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", effect = "cover"),
#'      f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", effect = "cover")
#'    ),
#'    navbar = f7Navbar(
#'      title = "Tabs",
#'      hairline = FALSE,
#'      shadow = TRUE,
#'      leftPanel = TRUE,
#'      rightPanel = TRUE
#'    ),
#'    f7Tabs(
#'      id = "tabset1",
#'      f7Tab(
#'        title = "Tab 1",
#'        tabName = "Tab1",
#'        active = TRUE,
#'        p("Text 1"),
#'        f7Button("remove1","Remove tab 1")
#'      ),
#'      f7Tab(
#'        title = "Tab 2",
#'        tabName = "Tab2",
#'        p("Text 2")
#'      ),
#'      f7Tab(
#'        title = "Tab 3",
#'        tabName = "Tab3",
#'        p("Text 3")
#'      )
#'    )
#'   )
#'  )
#'
#'  server <- function(input, output, session) {
#'    observe(print(input$tabset1))
#'    observeEvent(input$remove1, {
#'      removeF7Tab(
#'        id = "tabset1",
#'        target = "Tab1"
#'      )
#'    })
#'  }
#'  shinyApp(ui, server)
#' }
removeF7Tab <- function(id, target, session = shiny::getDefaultReactiveDomain()) {

  # tabsetpanel namespace
  ns <- id

  # we need to create a new id not to overlap with the updatebs4TabSetPanel id
  # prefix by remove_ makes sense
  id <- paste0("remove_", id)

  message <- dropNulls(
    list(
      target = target,
      ns = ns
    )
  )
  session$sendCustomMessage(type = id, message = message)

}


#' Deprecated functions
#'
#' \code{removeF7Tab} removes an \link{f7Tab} in an \link{f7Tabs}.
#' Use \link{removeF7Tab} instead

#' @rdname f7-deprecated
#' @inheritParams removeF7Tab
#' @keywords internal
#' @export
f7RemoveTab <- function(id, target, session = shiny::getDefaultReactiveDomain()) {
  .Deprecated(
    "removeF7Tab",
    package = "shinyMobile",
    "f7RemoveTab will be removed in future release. Please use
      removeF7Tab instead."
  )
  removeF7Tab(id, target, session)
}
