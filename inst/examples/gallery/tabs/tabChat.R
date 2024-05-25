tabText <- f7Tab(
  title = "Chat",
  tabName = "chat",
  icon = f7Icon("chat_bubble_2"),
  # this is the message container. Everything happens on the server side!
  f7Block(
    f7Messages(id = "mymessages", title = "My message")
  )
)
