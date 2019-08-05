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
    img = "http://lorempixel.com/1000/600/nature/3/",
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
  f7MediaCard(
    title = "A media card:",
    f7MediaCardItem(
      src = "http://lorempixel.com/88/88/fashion/4",
      title = "Yellow Submarine",
      subtitle = "Beatles"
    ),
    f7MediaCardItem(
      src = "http://lorempixel.com/88/88/fashion/5",
      title = "Don't Stop Me Now",
      subtitle = "Queen"
    ),
    footer = tagList(
      span("January 20", 2015),
      span(5, "comments")
    )
  ),
  br(),

  # list card
  f7BlockTitle(title = "f7ListCard") %>% f7Align(side = "center"),
  f7ListCard(
    f7ListCardItem(
      url = "https://www.google.com",
      title = "Item 1"
    ),
    f7ListCardItem(
      url = "https://www.google.com",
      title = "Item 2"
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
  )

)
