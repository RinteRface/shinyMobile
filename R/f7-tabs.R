#' Create a Framework7 tabs
#'
#' By default, \link{f7Tabs} are used within the \link{f7TabLayout}. However, you
#' may use them as standalone components if you specify a the segmented or strong
#' styles.
#'
#' For md design, when there is no icons in the tabbar,
#' a tiny horizontal highlight bar is displayed on top
#' of the active tab. Whenever a tab with icon is included, the highlight bar is
#' hidden and a round pill highlights the currently active tab.
#'
#' @param ... Slot for \link{f7Tab}.
#' @param .items Slot for other items that could be part of the toolbar such as
#' buttons or \link{f7TabLink}. This may be useful to open an \link{f7Sheet} from
#' the tabbar.
#' @param id Optional to get the id of the currently selected \link{f7Tab}.
#' @param swipeable Whether to allow finger swipe. FALSE by default. Only for touch-screens.
#' Not compatible with animated.
#' @param animated Whether to show transition between tabs. TRUE by default.
#' Not compatible with swipeable.
#' @param style Tabs style: \code{c("toolbar", "segmented", "strong")}. If style
#' is toolbar, then \link{f7Tab} have a toolbar behavior.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
#' @rdname tabs
#' @example inst/examples/tabs/app.R
f7Tabs <- function(..., .items = NULL, id = NULL, swipeable = FALSE, animated = TRUE,
                   style = c("toolbar", "segmented", "strong")) {
  style <- match.arg(style)
  if (swipeable && animated) stop("Cannot use two effects at the same time")
  if (is.null(id)) id <- paste0("tabs_", round(stats::runif(1, min = 0, max = 1e9)))
  ns <- shiny::NS(id)
  items <- list(...)
  found_active <- FALSE
  has_icon <- FALSE

  tabItems <- lapply(seq_along(items), FUN = function(i) {
    item <- items[[i]][[1]]
    itemIcon <- items[[i]][[2]]
    itemName <- items[[i]][[5]] # May be NULL
    itemClass <- item$attribs$class
    itemId <- item$attribs$id

    # To handle the tab highlight
    if (!is.null(itemIcon) && !has_icon) has_icon <<- TRUE

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
        } else if (style == "toolbar") {
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
    toolbar <- f7Toolbar(
      position = "bottom",
      # To be able to see the tab highlight when no icons
      # for md design
      icons = if (has_icon) TRUE else FALSE,
      scrollable = FALSE,
      tabItems,
      # other items here
      .items
    )
    toolbar$attribs$class <- paste(
      toolbar$attribs$class,
      "tabbar"
    )
    toolbar
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
      if (swipeable) items[[i]][[1]]$name <- "swiper-slide"
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
    contentTag <- swiperTag(
      class = if (style %in% c("segmented", "strong")) {
        "tabs-standalone"
      },
      id = contentTag$attribs$id,
      contentTag$children
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

#' Needed for swipeable tabs
#'
#' See \url{https://framework7.io/docs/tabs#swipeable-tabs}.
#'
#' @keywords internal
swiperTag <- function(...) {
  htmltools::tag(
    "swiper-container",
    list(class = "tabs", ...)
  )
}

#' @keywords internal
swiperSlideTag <- function(..., active = FALSE) {
  htmltools::tag(
    "swiper-slide",
    list(class = paste("tab", if (active) "tab-active"), ...)
  )
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
  list(itemTag, icon, tabName, hidden, title)
}

#' Special button/link to insert in the tabbar
#'
#' Use in the .items slot of \link{f7Tabs}.
#'
#' @param ... Any attribute like \code{`data-sheet`}, id, ...
#' @param icon Expect \link{f7Icon}.
#' @param label Button label.
#' @export
f7TabLink <- function(..., icon = NULL, label = NULL) {
  props <- list(...)

  shiny::tags$a(
    ...,
    class = "tab-link",
    href = if (is.null(props$href)) "#",
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
#' @seealso \link{f7Tabs}
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
#' @seealso \link{f7Tabs}
insertF7Tab <- function(id, tab, target = NULL, position = c("before", "after"),
                        select = FALSE, session = shiny::getDefaultReactiveDomain()) {
  # in shinyMobile, f7Tab returns a list of 5 elements:
  # - 1 is the tag\
  # - 2 is the icon name
  # - 3 is the tabName
  # - 4 hidden
  # - 5 is the title

  # Below we check if the tag is really a shiny tag...
  if (!(class(tab[[1]]) %in% c("shiny.tag", "shiny.tag.list"))) {
    stop("tab must be a shiny tag")
  }

  nsWrapper <- shiny::NS(id)
  position <- match.arg(position)
  # create the corresponding tab-link
  tabId <- nsWrapper(tab[[1]]$attribs$id)
  children <- tab[[1]]$children
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
#' @seealso \link{f7Tabs}
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

#' Framework7 back button
#'
#' \link{f7Back} is a button to go back in \link{f7Tabs}.
#'
#' @param targetId \link{f7Tabs} id.
#' @export
f7Back <- function(targetId) {
  backJS <- shiny::singleton(
    shiny::tags$script(
      shiny::HTML(
        paste0(
          "$(function() {
            var firstTabId =  $('#", targetId, " div:eq(0)').attr('id');
            var currentTab = null;
            var currentTabId = null;
            // need to update the current tab on each click
            $(window).on('click', function() {
              currentTab = $('#", targetId, "').find('.tab-active');
              currentTabId = $(currentTab).attr('data-value');
            });
            $('#back_", targetId, "').on('click', function(e) {
              currentTab = $('#", targetId, "').find('.tab-active');
              currentTabId = $(currentTab).attr('id');
              // if the first tab is already active, we cannot go back
              if (currentTabId !== firstTabId) {
                var backTab = $(currentTab).prev();
                var backTabId = $(backTab).attr('id');
                app.tab.show('#' + backTabId);
              }
            });
          });
          "
        )
      )
    )
  )

  backTag <- shiny::tags$a(
    href = "#",
    id = paste0("back_", targetId),
    class = "button button-small display-flex margin-left-half",
    f7Icon("arrowshape_turn_up_left_fill")
  )

  shiny::tagList(backJS, backTag)
}

#' Framework7 next button
#'
#' \link{f7Next} is a button to go next in \link{f7Tabs}.
#'
#' @param targetId \link{f7Tabs} id.
#' @export
f7Next <- function(targetId) {
  nextJS <- shiny::singleton(
    shiny::tags$script(
      shiny::HTML(
        paste0(
          "$(function() {
            var lastTabId =  $('#", targetId, " div:last-child').attr('id');
            var currentTab = null;
            var currentTabId = null;
            // need to update the current tab on each click
            $(window).on('click', function() {
              currentTab = $('#", targetId, "').find('.tab-active');
              currentTabId = $(currentTab).attr('data-value');
            });
            $('#next_", targetId, "').on('click', function(e) {
              currentTab = $('#", targetId, "').find('.tab-active');
              currentTabId = $(currentTab).attr('id');
              // if the first tab is already active, we cannot go back
              if (currentTabId !== lastTabId) {
                var backTab = $(currentTab).next();
                var backTabId = $(backTab).attr('id');
                app.tab.show('#' + backTabId);
              }
            });
          });
          "
        )
      )
    )
  )

  nextTag <- shiny::tags$a(
    href = "#",
    id = paste0("next_", targetId),
    class = "button button-small display-flex margin-left-half",
    f7Icon("arrowshape_turn_up_right_fill")
  )

  shiny::tagList(nextJS, nextTag)
}
