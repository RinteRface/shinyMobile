tabCards <- f7Tab(
  tabName = "Cards",
  icon = "layers_alt_fill",
  active = FALSE,

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings new card components")
  ),


  f7Flex(
    # classic card
    f7Card(
      title = "Card with header and footer",
      img = "http://lorempixel.com/1000/600/nature/3/",
      "This is a simple card with plain text,
     but cards can also contain their own header,
     footer, list view, image, or any other element.",
      footer = tagList(
        f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
        f7Badge("Badge", color = "green")
      )
    ),


    # social card
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
    )
  ),


  f7Flex(

    # card no header, no footer
    f7Card("This is a simple card with plain text,
    but cards can also contain their own header,
    footer, list view, image, or any other element."),

    # media card
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

    # list card
    f7ListCard(
      f7ListCardItem(
        url = "https://www.google.com",
        title = "Item 1"
      ),
      f7ListCardItem(
        url = "https://www.google.com",
        title = "Item 2"
      )
    )
  ),

  # expandable card
  f7ExpandableCard(
    id = "card1",
    title = "Expandable Card 1",
    color = "blue",
    subtitle = "Click on me pleaaaaase",
    "Framework7 - is a free and open source HTML mobile framework
    to develop hybrid mobile apps or web apps with iOS or Android
    native look and feel. It is also an indispensable prototyping apps tool
    to show working app prototype as soon as possible in case you need to."
  )

)
