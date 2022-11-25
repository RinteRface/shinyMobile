tabCards <- f7Tab(
  tabName = "Cards",
  icon = f7Icon("rectangle_stack", f7Badge(8, color = "green")),
  active = FALSE,

  f7BlockTitle(title = "f7Block") %>% f7Align(side = "center"),
  f7Block(
    f7BlockHeader(text = "Header"),
    "Here comes paragraph within content block.
     Donec et nulla auctor massa pharetra
     adipiscing ut sit amet sem. Suspendisse
     molestie velit vitae mattis tincidunt.
     Ut sit amet quam mollis, vulputate
     turpis vel, sagittis felis.",
    f7BlockFooter(text = "Footer")
  ),
  br(),

  f7BlockTitle(title = "f7Block with wrapper") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    f7BlockHeader(text = "Header"),
    "Here comes paragraph within content block.
     Donec et nulla auctor massa pharetra
     adipiscing ut sit amet sem. Suspendisse
     molestie velit vitae mattis tincidunt.
     Ut sit amet quam mollis, vulputate
     turpis vel, sagittis felis.",
    f7BlockFooter(text = "Footer")
  ),
  br(),

  f7BlockTitle(title = "f7Block with wrapper and inset") %>% f7Align(side = "center"),
  f7Block(
    inset = TRUE,
    strong = TRUE,
    f7BlockHeader(text = "Header"),
    "Here comes paragraph within content block.
     Donec et nulla auctor massa pharetra
     adipiscing ut sit amet sem. Suspendisse
     molestie velit vitae mattis tincidunt.
     Ut sit amet quam mollis, vulputate
     turpis vel, sagittis felis.",
    f7BlockFooter(text = "Footer")
  ),

  br(),

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
    title = tagList(
      "Card with header and footer",
      f7Icon("card", f7Badge("Hi!", color = "red"))
    ),
    "This is a simple card with plain text,
     but cards can also contain their own header,
     footer, list view, image, or any other element.",
    footer = tagList(
      f7Link(label = "Google", href = "https://www.google.com"),
      f7Link(label = "Twitter", href = "https://www.twitter.com")
    )
  ),
  br(),

  # classic card with image
  f7BlockTitle(title = "f7Card with media") %>% f7Align(side = "center"),
  f7Card(
    title = "Card with header, footer and image",
    image = "https://cdn.framework7.io/placeholder/nature-1000x600-3.jpg",
    "This is a simple card with plain text,
     but cards can also contain their own header,
     footer, list view, image, or any other element.",
    footer = tagList(
      f7Button(color = "blue", label = "My button", href = "https://www.google.com"),
      f7Badge("Badge", color = "green")
    )
  ),
  br(),


  # social card
  f7BlockTitle(title = "f7SocialCard") %>% f7Align(side = "center"),
  f7SocialCard(
    image = "https://cdn.framework7.io/placeholder/people-68x68-1.jpg",
    author = "A social Card",
    date = "Monday at 3:47 PM",
    "What a nice photo i took yesterday!",
    img(src = "https://cdn.framework7.io/placeholder/nature-1000x700-8.jpg", width = "100%"),
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
          media = tags$img(src = "https://picsum.photos/200"),
          right = "Right Text",
          href = "https://www.google.com"
        )
      })
    ),
    footer = tagList(
      span("January 20", 2015),
      f7Chip(label = "Example Chip", image = "https://picsum.photos/200"),
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
    image = "https://i.pinimg.com/originals/73/38/6e/73386e0513d4c02a4fbb814cadfba655.jpg",
    "Framework7 - is a free and open source HTML mobile framework
    to develop hybrid mobile apps or web apps with iOS or Android
    native look and feel. It is also an indispensable prototyping apps tool
    to show working app prototype as soon as possible in case you need to."
  ),
  f7ExpandableCard(
    id = "card3",
    title = "Expandable Card 3",
    fullBackground = TRUE,
    image = "https://cdn.pixabay.com/photo/2017/10/03/18/55/mountain-2813667_960_720.png",
    "Framework7 - is a free and open source HTML mobile framework
    to develop hybrid mobile apps or web apps with iOS or Android
    native look and feel. It is also an indispensable prototyping apps tool
    to show working app prototype as soon as possible in case you need to."
  ),

  # update cards
  f7BlockTitle(title = "updateF7Card") %>% f7Align(side = "center"),
  f7Block(f7Button(inputId = "goCard", label = "Expand card 3"))
)
