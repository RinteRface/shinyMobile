#' Framework 7 searchbar
#'
#' Searchbar to filter elements in a page.
#'
#' @param id Necessary when using \link{f7SearchbarTrigger}. NULL otherwise.
#' @param placeholder Searchbar placeholder.
#' @param expandable Whether to enable the searchbar with a target link,
#' in the navbar. See \link{f7SearchbarTrigger}.
#' @param inline Useful to add an \link{f7Searchbar} in a navbar.
#' Notice that utilities like \link{f7HideOnSearch} and \link{f7NotFound} are not
#' compatible with this mode.
#' @param options Search bar options.
#' See \url{https://framework7.io/docs/searchbar.html#searchbar-parameters}.
#' If no options are provided, the searchbar will search in list elements by
#' item title. This may be changed by updating the default searchContainer and
#' searchIn.
#' @export
#' @rdname searchbar
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   cars <- rownames(mtcars)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Simple searchbar",
#'       f7SingleLayout(
#'         navbar = f7Navbar(
#'           title = "f7Searchbar",
#'           hairline = FALSE,
#'           shadow = TRUE,
#'           subNavbar = f7SubNavbar(
#'             f7Searchbar(id = "search1")
#'           )
#'         ),
#'         f7Block(
#'           "This block will be hidden on search.
#'         Lorem ipsum dolor sit amet, consectetur adipisicing elit."
#'         ) %>% f7HideOnSearch(),
#'         f7List(
#'           lapply(seq_along(cars), function(i) {
#'             f7ListItem(cars[i])
#'           })
#'         ) %>% f7Found(),
#'         f7Block(
#'           p("Nothing found")
#'         ) %>% f7NotFound()
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#'
#'   # Expandable searchbar with trigger
#'   cities <- names(precip)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Expandable searchbar",
#'       f7SingleLayout(
#'         navbar = f7Navbar(
#'           title = "f7Searchbar with trigger",
#'           subNavbar = f7SubNavbar(
#'             f7Searchbar(id = "search1", expandable = TRUE)
#'           )
#'         ),
#'         f7Block(
#'           f7SearchbarTrigger(targetId = "search1")
#'         ) %>% f7HideOnSearch(),
#'         f7List(
#'           lapply(seq_along(cities), function(i) {
#'             f7ListItem(cities[i])
#'           })
#'         ) %>% f7Found(),
#'         f7Block(
#'           p("Nothing found")
#'         ) %>% f7NotFound()
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#' }
f7Searchbar <- function(id, placeholder = "Search", expandable = FALSE, inline = FALSE,
                        options = NULL) {
  if (is.null(options)) {
    options <- list(
      searchContainer = ".list",
      searchIn = ".item-title"
    )
  }

  searchBarConfig <- shiny::tags$script(
    type = "application/json",
    `data-for` = id,
    jsonlite::toJSON(
      x = options,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )

  searchBarTools <- shiny::tags$div(
    class = "searchbar-input-wrap",
    shiny::tags$input(type = "search", placeholder = placeholder),
    shiny::tags$i(class = "searchbar-icon"),
    shiny::tags$span(class = "input-clear-button")
  )

  searchBarCl <- "searchbar"
  if (inline) searchBarCl <- paste(searchBarCl, "searchbar-inline")
  if (expandable) searchBarCl <- paste(searchBarCl, "searchbar-expandable")

  searchBarTag <- if (inline) {
    shiny::tags$div(
      class = searchBarCl,
      id = id,
      searchBarTools
    )
  } else {
    shiny::tags$form(
      class = searchBarCl,
      id = id,
      shiny::tags$div(
        class = "searchbar-inner",
        searchBarTools,
        shiny::tags$span(class = "searchbar-disable-button", "Cancel")
      )
    )
  }

  shiny::tagList(searchBarTag, searchBarConfig)
}

#' Framework 7 searchbar trigger
#'
#' \link{f7SearchbarTrigger}: Element that
#' triggers the searchbar.
#'
#' @param targetId Id of the \link{f7Searchbar}.
#' @rdname searchbar
#' @export
f7SearchbarTrigger <- function(targetId) {
  shiny::tags$a(
    class = "link icon-only searchbar-enable",
    `data-searchbar` = paste0("#", targetId),
    shiny::tags$i(class = "icon f7-icons", "search")
  )
}

#' Utility to hide a given tag on search
#'
#' \link{f7HideOnSearch}: elements with such class
#' on page will be hidden during search
#'
#' @param tag tag to hide.
#' @rdname searchbar
#' @export
f7HideOnSearch <- function(tag) {
  tag$attribs$class <- paste(tag$attribs$class, "searchbar-hide-on-search")
  tag
}

#' Utility to hide a given tag when \link{f7Searchbar} is enabled.
#'
#' \link{f7HideOnEnable}: elements with such class
#' on page will be hidden when searchbar is enabled
#'
#' @param tag tag to hide.
#' @rdname searchbar
#' @export
f7HideOnEnable <- function(tag) {
  tag$attribs$class <- paste(tag$attribs$class, "searchbar-hide-on-enable")
  tag
}

#' Utility to display an item when the search is unsuccessful.
#'
#' \link{f7SearchNotFound}: elements with such
#' class are hidden by default and become visible
#' when there is not any search results
#'
#' @param tag tag to use.
#' @rdname searchbar
#' @export
f7NotFound <- function(tag) {
  tag$attribs$class <- paste(tag$attribs$class, "searchbar-not-found")
  tag
}

#' Utility to display an item when the search is successful.
#'
#' \link{f7SearchFound}: elements with such
#' class are visible by default and become hidden
#' when there is not any search results.
#'
#' @param tag tag to display. When using \link{f7Searchbar}, one must
#' wrap the items to search in inside \link{f7Found}.
#' @rdname searchbar
#' @export
f7Found <- function(tag) {
  tag$attribs$class <- paste(tag$attribs$class, "searchbar-found")
  tag
}

#' Utility to ignore an item from search.
#'
#' \link{f7SearchIgnore}: searchbar will not
#' consider this elements in search results.
#'
#' @param tag tag to ignore.
#' @rdname searchbar
#' @export
f7SearchIgnore <- function(tag) {
  tag$attribs$class <- paste(tag$attribs$class, "searchbar-ignore")
  tag
}
