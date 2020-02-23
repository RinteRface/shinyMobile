#' Create a Framework7 tabs
#'
#' By default, \link{f7Tabs} are used within the \link{f7TabLayout}. However, you
#' may use them as standalone components if you specify a the segmented or strong
#' styles.
#'
#' @param ... Slot for \link{f7Tab}.
#' @param .items Slot for other items that could be part of the toolbar such as
#' buttons or \link{f7TabLink}. This may be useful to open a \link{f7Sheet} from
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
#'          tabName = "Tab 1",
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
#'         f7Tab(tabName = "Tab 2", "tab 2 text"),
#'         f7Tab(tabName = "Tab 3", "tab 3 text"),
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
#'            tabName = "Tab 1",
#'            icon = f7Icon("email"),
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
#'            tabName = "Tab 2",
#'            icon = f7Icon("today"),
#'            active = FALSE,
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
#'            tabName = "Tab 3",
#'            icon = f7Icon("cloud_upload"),
#'            active = FALSE,
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
    itemName <- items[[i]][[3]]
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
            href = paste0("#", ns(itemId)),
            itemIcon,
            shiny::span(class = "tabbar-label", itemName)
          )
        } else if (style == "toolbar") {
          shiny::a(
            href = paste0("#", ns(itemId)),
            class = if (active) "tab-link tab-link-active" else "tab-link",
            itemIcon,
            shiny::span(class = "tabbar-label", itemName)
          )
        }
      } else {
        if (style %in% c("segmented", "strong")) {
          shiny::tags$button(
            class = if (active) "button tab-link tab-link-active" else "button tab-link",
            href = paste0("#", ns(itemId)),
            itemName
          )
        } else if (style == "toolbar"){
          shiny::a(
            href = paste0("#", ns(itemId)),
            class = if (active) "tab-link tab-link-active" else "tab-link",
            itemName
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
        tabItems
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

  # this is for the f7InsertTab and f7RemoveTab functions
  # since the menu container is not the same, we need a common
  # css class.
  tabLinksTag <- tagAppendAttributes(tabLinksTag, class = "tabLinks")

  # related page content
  contentTag <- shiny::tags$div(
    # ios-edges necessary to have
    # the good ios rendering
    class = "tabs ios-edges",
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

  shiny::tagList(f7InputsDeps(), tabLinksTag, contentTag)

}



#' Create a Framework7 tab item
#'
#' Build a Framework7 tab item
#'
#' @param ... Item content.
#' @param tabName Item id. Must be unique.
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
f7Tab <- function(..., tabName, icon = NULL, active = FALSE, hidden = FALSE) {

  id <- tabName
  # handle punctuation
  id <- gsub(x = id, pattern = "[[:punct:]]", replacement = "")
  # handle tab names with space
  id <- gsub(x = id, pattern = " ", replacement = "")

  itemTag <- shiny::tags$div(
    class = if (!active) "page-content tab" else "page-content tab tab-active",
    `data-active` = tolower(active),
    id = id,
    `data-value` = tabName,
    `data-hidden` = tolower(hidden),
    style = "background-color: gainsboro;",
    ...
  )
  return(list(itemTag, icon, tabName, hidden))
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
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "Tab Layout",
#'      f7TabLayout(
#'        navbar = f7Navbar(
#'         title = HTML(paste("Currently selected:", textOutput("selected"))),
#'         subNavbar = f7SubNavbar(
#'          f7Flex(
#'           f7Toggle(inputId = "updateTab", label = "Update Tab", checked = TRUE),
#'           f7Toggle(inputId = "updateSubTab", label = "Update SubTab", checked = FALSE)
#'          )
#'         )
#'        ),
#'        f7Tabs(
#'          id = "tabdemo",
#'          swipeable = TRUE,
#'          animated = FALSE,
#'          f7Tab(
#'           tabName = "Tab 1",
#'           f7Tabs(
#'            id = "subtabdemo",
#'            animated = TRUE,
#'            f7Tab(tabName = "SubTab 1", "SubTab 1"),
#'            f7Tab(tabName = "SubTab 2", "SubTab 2", active = TRUE),
#'            f7Tab(tabName = "SubTab 3", "SubTab 3")
#'           )
#'          ),
#'          f7Tab(tabName = "Tab 2", "Tab 2"),
#'          f7Tab(tabName = "Tab 3", "Tab 3")
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      observeEvent(input$updateTab, {
#'        selected <- ifelse(input$updateTab, "Tab 1", "Tab 2")
#'        updateF7Tabs(session, id = "tabdemo", selected = selected)
#'      })
#'      observeEvent(input$updateSubTab, {
#'        selected <- ifelse(input$updateSubTab, "SubTab 1", "SubTab 2")
#'        updateF7Tabs(session, id = "subtabdemo", selected = selected)
#'      })
#'    }
#'  )
#'  # with hidden tabs
#'  shinyApp(
#'   ui <- f7Page(
#'     title = "shinyMobile",
#'     init = f7Init(
#'       skin = "auto",
#'       theme = "light",
#'       color = 'blue',
#'       filled = TRUE,
#'       hideNavOnPageScroll = FALSE,
#'       hideTabsOnPageScroll = FALSE
#'     ),
#'     f7TabLayout(
#'       navbar = f7Navbar(
#'         title = "Update Tabs with hidden tab",
#'         subtitle = "",
#'         hairline = TRUE,
#'         shadow = TRUE,
#'         left_panel = TRUE,
#'         right_panel = FALSE,
#'         bigger = FALSE,
#'         transparent = TRUE
#'       ),
#'       f7Tabs(
#'         id = 'tabs',
#'         animated = TRUE,
#'         f7Tab(
#'           active = TRUE,
#'           tabName = 'Main tab',
#'           icon = f7Icon('document_text'),
#'           h1("This is the first tab."),
#'           f7Button(inputId ='goto', label = 'Go to hidden tab')
#'         ),
#'         f7Tab(
#'           tabName = 'Second tab',
#'           icon = f7Icon('bolt_horizontal'),
#'           h1('This is the second tab.')
#'         ),
#'         f7Tab(
#'           tabName = 'Hidden tab',
#'           hidden = TRUE,
#'           h1('This is a tab that does not appear in the tab menu.
#'           Yet, you can still access it.')
#'         )
#'       )
#'     )
#'   ),
#'   server = function(input, output, session) {
#'     observe(print(input$tabs))
#'     observeEvent(input$goto,{
#'       updateF7Tabs(session = session, id = 'tabs', selected = 'Hidden tab')
#'     })
#'
#'   }
#'  )
#' }
updateF7Tabs <- function(session, id, selected = NULL) {

  # remove the space in the tab name
  selected <- gsub(x = selected, pattern = " ", replacement = "")

  message <- dropNulls(list(selected = selected, ns = id))
  session$sendInputMessage(id, message)
}




#' Insert a \link{f7Tab} in a \link{f7Tabs}
#'
#' @param inputId  \link{f7Tabs} id.
#' @param tab \link{f7Tab} to insert.
#' @param target \link{f7Tab} after of before which the new tab will be inserted.
#' @param position Insert before or after: \code{c("before", "after")}.
#' @param select Whether to select the newly inserted tab. FALSE by default.
#' @param session Shiny session object.
#'
#' @export
#'
#' @importFrom shiny getDefaultReactiveDomain
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "Insert a tab Before the target",
#'      f7TabLayout(
#'        panels = tagList(
#'          f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", effect = "cover"),
#'          f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", effect = "cover")
#'        ),
#'        navbar = f7Navbar(
#'          title = "Tabs",
#'          hairline = FALSE,
#'          shadow = TRUE,
#'          left_panel = TRUE,
#'          right_panel = TRUE
#'        ),
#'        f7Tabs(
#'          animated = TRUE,
#'          id = "tabs",
#'          f7Tab(
#'            tabName = "Tab 1",
#'            icon = f7Icon("email"),
#'            active = TRUE,
#'            "Tab 1",
#'            f7Button(inputId = "go", label = "Go")
#'          ),
#'          f7Tab(
#'            tabName = "Tab 2",
#'            icon = f7Icon("today"),
#'            active = FALSE,
#'            "Tab 2"
#'          )
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      observeEvent(input$go, {
#'        f7InsertTab(
#'          inputId = "tabs",
#'          position = "before",
#'          target = "Tab 2",
#'          tab = f7Tab (tabName = paste0("tab_", input$go), "Test"),
#'          select = TRUE
#'        )
#'      })
#'    }
#'  )
#' }
#'
f7InsertTab <- function(inputId, tab, target, position = c("before", "after"),
                        select = FALSE, session = shiny::getDefaultReactiveDomain()) {

  # in shinyMobile, f7Tab returns a list of 3 elements:
  # - 1 is the tag\
  # - 2 is the icon name
  # - 3 is the tabName
  # Below we check if the tag is really a shiny tag...
  if (!(class(tab[[1]]) %in% c("shiny.tag" , "shiny.tag.list"))) stop("tab must be a shiny tag")

  nsWrapper <- shiny::NS(inputId)
  position <- match.arg(position)

  # create the corresponding tablink
  tabId <- gsub(" ", "", nsWrapper(tab[[1]]$attribs$id), fixed = TRUE)

  tabLink <- shiny::a(
    class = "tab-link",
    href = paste0("#", nsWrapper(tab[[1]]$attribs$id)),
    tab[[3]]
  )
  tabLink <- as.character(force(tabLink))

  # force to render shiny.tag and convert it to character
  # since text does not accept anything else
  tab[[1]]$attribs$id <- nsWrapper(tab[[1]]$attribs$id)
  tab <- as.character(force(tab[[1]]))

  # remove all whitespace from the target name
  target <- gsub(" ", "", target, fixed = TRUE)

  message <- dropNulls(
    list(
      value = tab,
      id = tabId,
      link = tabLink,
      target = target,
      position = position,
      select = tolower(select),
      ns = inputId
    )
  )

  # we need to create a new id not to overlap with the updateF7Tab id
  # prefix by insert_ makes sense
  inputId <- paste0("insert_", inputId)
  session$sendCustomMessage(type = inputId, message)
}




#' Remove a \link{f7Tab} in a \link{f7Tabs}
#'
#' @param inputId  \link{f7Tabs} id.
#' @param target \link{f7Tab} to remove.
#' @param session Shiny session object.
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
#'      left_panel = TRUE,
#'      right_panel = TRUE
#'    ),
#'    f7Tabs(
#'      id = "tabset1",
#'      f7Tab(
#'        tabName = "Tab 1",
#'        active = TRUE,
#'        p("Text 1"),
#'        f7Button("remove1","Remove tab 1")
#'      ),
#'      f7Tab(
#'        tabName = "Tab 2",
#'        active = FALSE,
#'        p("Text 2")
#'      ),
#'      f7Tab(
#'        tabName = "Tab 3",
#'        active = FALSE,
#'        p("Text 3")
#'      )
#'    )
#'   )
#'  )
#'
#'  server <- function(input, output, session) {
#'    observe(print(input$tabset1))
#'    observeEvent(input$remove1, {
#'      f7RemoveTab(
#'        inputId = "tabset1",
#'        target = "Tab 1"
#'      )
#'    })
#'  }
#'  shinyApp(ui, server)
#' }
f7RemoveTab <- function(inputId, target, session = shiny::getDefaultReactiveDomain()) {

  # tabsetpanel namespace
  ns <- inputId

  # we need to create a new id not to overlap with the updatebs4TabSetPanel id
  # prefix by remove_ makes sense
  inputId <- paste0("remove_", inputId)

  # remove all whitespace from the target name
  target <- gsub(" ", "", target, fixed = TRUE)

  message <- dropNulls(
    list(
      target = target,
      ns = ns
    )
  )
  session$sendCustomMessage(type = inputId, message = message)

}
