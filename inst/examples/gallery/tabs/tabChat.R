tabText <- f7Tab(
  tabName = "chat",
  icon = f7Icon("chat_bubble_2"),
  # this is the message container. Everything happens on the server side!
  f7Messages(id = "mymessages", title = "My message")
)
