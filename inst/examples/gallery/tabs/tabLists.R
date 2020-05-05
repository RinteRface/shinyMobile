tabLists <- f7Tab(
  tabName = "Lists",
  icon = f7Icon("list_dash", f7Badge("New", color = "red")),
  active = FALSE,

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
          side = "left",
          f7SwipeoutItem(id = "swipeAlert", color = "pink", "Alert"),
          f7SwipeoutItem(id = "swipeNotif", color = "green", "Notif"),
          f7SwipeoutItem(id = "swipeActionSheet", color = "purple", "Action")
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
    lapply(1:3, function(j) f7ListItem(letters[j]))
  ),
  br(),

  # list with complex items
  f7BlockTitle(title = "f7List with components") %>% f7Align(side = "center"),
  f7List(
    lapply(1:3, function(j) {
      f7ListItem(
        letters[j],
        media = f7Icon("alarm_fill"),
        right = "Right Text",
        header = "Header",
        footer = "Footer"
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
        url = "https://www.google.com"
      )
    })
  ),
  br(),

  # simple media list
  f7BlockTitle(title = "f7List with simple media") %>% f7Align(side = "center"),
  f7List(
    mode = "media",
    lapply(1:3, function(j) {
      f7ListItem(
        title = "Title",
        subtitle = "Subtitle",
        media = tags$img(src = paste0("https://cdn.framework7.io/placeholder/people-160x160-", j, ".jpg"))
      )
    })
  ),
  br(),

  # list with links
  f7BlockTitle(title = "f7List with links") %>% f7Align(side = "center"),
  f7List(
    lapply(1:3, function(j) {
      f7ListItem(url = "https://google.com", letters[j])
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
  )#,
  #br(),
  #
  ## list index
  #f7BlockTitle(title = "f7ListIndex") %>% f7Align(side = "center"),
  #f7ListIndex(
  #  id = "listIndex1",
  #  lapply(seq_along(LETTERS), function(i) {
  #    f7ListGroup(
  #      title = LETTERS[i],
  #      lapply(1:3, function(j) {
  #        f7ListIndexItem(letters[j])
  #      })
  #    )
  #  })
  #)
)
