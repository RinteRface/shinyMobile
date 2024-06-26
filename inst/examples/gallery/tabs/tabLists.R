# contacts_list <- f7List(
#  mode = "contacts",
#  lapply(seq_along(LETTERS), function(i) {
#    f7ListGroup(
#      title = LETTERS[i],
#      lapply(seq_along(LETTERS), function(j) {
#        f7ListItem(letters[j])
#      })
#    )
#  })
# )
#
# contacts_list$attribs$id <- "list-index-target"


tabLists <- f7Tab(
  title = "Lists",
  tabName = "lists",
  icon = f7Icon("list_dash", f7Badge("New", color = "red")),
  active = FALSE,
  f7Block(
    f7Searchbar(id = "search1",
                inline = TRUE,
                placeholder = "Search for something!"
    )
  ),
  # swipeable list
  f7BlockTitle(title = "f7Swipeout, swipeable list") %>%
    f7Align(side = "center"),
  f7List(
    lapply(1:3, function(j) {
      if (j == 1) {
        f7Swipeout(
          tag = f7ListItem(
            if (j == 1) {
              "Swipe me to the right"
            } else {
              "You can't swipe me!"
            }
          ),
          left = tagList(
            f7SwipeoutItem(id = "swipeAlert", color = "red", "Alert"),
            f7SwipeoutItem(id = "swipeNotif", color = "blue", "Notif"),
            f7SwipeoutItem(id = "swipeActionSheet", color = "green", "Action")
          )
        )
      } else {
        f7ListItem(letters[j])
      }
    })
  ),
  br(),

  # simple list
  f7BlockTitle(title = "Simple f7List") %>% f7Align(side = "center"),
  f7List(
    lapply(1:3, function(j) {
      f7ListItem(sprintf("Item %s content", j))
    })
  ),
  br(),

  # list with complex items
  f7BlockTitle(title = "f7List with custom style") %>% f7Align(side = "center"),
  f7List(
    inset = TRUE,
    outline = TRUE,
    dividers = TRUE,
    strong = TRUE,
    mode = "media",
    lapply(1:3, function(j) {
      f7ListItem(
        title = letters[j],
        "Content",
        media = f7Icon("alarm_fill"),
        right = "Right Text"
      )
    })
  ),
  br(),

  # media list
  f7BlockTitle(title = "f7List in media mode") %>% f7Align(side = "center"),
  f7List(
    mode = "media",
    lapply(1:3, function(j) {
      f7ListItem(
        title = letters[j],
        subtitle = "subtitle",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
            Nulla sagittis tellus ut turpis condimentum, ut dignissim
            lacus tincidunt. Cras dolor metus, ultrices condimentum sodales
            sit amet, pharetra sodales eros. Phasellus vel felis tellus.
            Mauris rutrum ligula nec dapibus feugiat. In vel dui laoreet,
            commodo augue id, pulvinar lacus.",
        media = tags$img(src = paste0("https://cdn.framework7.io/placeholder/people-160x160-", j, ".jpg")),
        right = "Right Text",
        href = "https://www.google.com"
      )
    })
  ),
  br(),

  # list with links
  f7BlockTitle(title = "f7List with links") %>% f7Align(side = "center"),
  f7List(
    mode = "links",
    lapply(1:3, function(j) {
      tags$li(
        f7Link(label = letters[j], href = "https://google.com")
      )
    })
  ),
  br(),

  # grouped lists
  f7BlockTitle(title = "f7List with f7ListGroup") %>% f7Align(side = "center"),
  f7List(
    mode = "contacts",
    lapply(1:3, function(i) {
      f7ListGroup(
        title = LETTERS[i],
        lapply(1:3, function(j) f7ListItem(letters[j]))
      )
    })
  ),
  br(),

  # treeview
  f7BlockTitle(title = "f7Treeview") %>% f7Align(side = "center"),
  f7Treeview(
    id = "treeview",
    withCheckbox = TRUE,
    startExpanded = TRUE,
    f7TreeviewGroup(
      title = "Images",
      icon = f7Icon("folder_fill"),
      toggleButton = TRUE,
      lapply(letters[1:3], function(i) f7TreeviewItem(label = paste0(i, ".png"),
                                                      icon = f7Icon("photo_fill")))
    )
  ),
  br(),
  verbatimTextOutput("treeview")
)
