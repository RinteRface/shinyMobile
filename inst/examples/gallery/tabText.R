tabText <- f7Tab(
  tabName = "Text",
  icon = f7Icon("document_text"),

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings text containers")
  ),

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
  )
)
