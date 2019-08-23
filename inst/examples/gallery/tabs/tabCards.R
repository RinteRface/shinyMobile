tabCards <- f7Tab(
  tabName = "Cards",
  icon = f7Icon("card"),
  active = FALSE,

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings new card components")
  ),

  # classic card without header nor footer
  f7BlockTitle(title = "f7Card with no header nor footer") %>% f7Align(side = "center"),
  f7Card(
    "Card with header and footer",
    "This is a simple card with plain text,
     but cards can also contain their own header,
     footer, list view, image, or any other element."
  ),
  br(),

  # classic card without image
  f7BlockTitle(title = "f7Card with header and footer") %>% f7Align(side = "center"),
  f7Card(
    title = "Card with header and footer",
    "This is a simple card with plain text,
     but cards can also contain their own header,
     footer, list view, image, or any other element.",
    footer = tagList(
      f7Link(label = "Google", src = "https://www.google.com"),
      f7Link(label = "Google", src = "https://www.google.com", external = TRUE)
    )
  ),
  br(),

  # classic card with image
  f7BlockTitle(title = "f7Card with media") %>% f7Align(side = "center"),
  f7Card(
    title = "Card with header, footer and image",
    img = "https://lorempixel.com/1000/600/nature/3/",
    "This is a simple card with plain text,
     but cards can also contain their own header,
     footer, list view, image, or any other element.",
    footer = tagList(
      f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
      f7Badge("Badge", color = "green")
    )
  ),
  br(),


  # social card
  f7BlockTitle(title = "f7SocialCard") %>% f7Align(side = "center"),
  f7SocialCard(
    author_img = "http://lorempixel.com/68/68/people/1/",
    author = "A social Card",
    date = "Monday at 3:47 PM",
    "What a nice photo i took yesterday!",
    img(src = "http://lorempixel.com/1000/700/nature/8/", width = "100%"),
    footer = tagList(
      f7Badge("1", color = "yellow"),
      f7Badge("2", color = "green"),
      f7Badge("3", color = "blue")
    )
  ),
  br(),


  # media card
  f7BlockTitle(title = "f7MediaCard") %>% f7Align(side = "center"),
  f7Card(
    title = "A card with media:",

    f7List(
      mode = "media",
      lapply(1:2, function(j) {
        f7ListItem(
          title = letters[j],
          subtitle = "Subtitle",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
            Nulla sagittis tellus ut turpis condimentum, ut dignissim
            lacus tincidunt.",
          media = tags$img(src = paste0("https://lorempixel.com/88/88/fashion/", j)),
          right = "Right Text",
          url = "test"
        )
      })
    ),
    footer = tagList(
      span("January 20", 2015),
      span(5, "comments")
    )
  ),
  br(),

  # expandable card
  f7BlockTitle(title = "f7ExpandableCard") %>% f7Align(side = "center"),
  f7ExpandableCard(
    id = "card1",
    title = "Expandable Card 1",
    color = "yellow",
    subtitle = "Click on me pleaaaaase",
    "Framework7 - is a free and open source HTML mobile framework
    to develop hybrid mobile apps or web apps with iOS or Android
    native look and feel. It is also an indispensable prototyping apps tool
    to show working app prototype as soon as possible in case you need to."
  ),
  f7ExpandableCard(
    id = "card2",
    title = "Expandable Card 2",
    img = "https://i.pinimg.com/originals/73/38/6e/73386e0513d4c02a4fbb814cadfba655.jpg",
    "Framework7 - is a free and open source HTML mobile framework
    to develop hybrid mobile apps or web apps with iOS or Android
    native look and feel. It is also an indispensable prototyping apps tool
    to show working app prototype as soon as possible in case you need to."
  ),
  f7ExpandableCard(
    id = "card3",
    title = "Expandable Card 3",
    fullBackground = TRUE,
    img = "https://i.ytimg.com/vi/8q_kmxwK5Rg/maxresdefault.jpg",
    "Framework7 - is a free and open source HTML mobile framework
    to develop hybrid mobile apps or web apps with iOS or Android
    native look and feel. It is also an indispensable prototyping apps tool
    to show working app prototype as soon as possible in case you need to."
  )

)
