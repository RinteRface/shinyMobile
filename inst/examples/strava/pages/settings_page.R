settings_page <- function() {
  page(
    href = "/settings",
    ui = function(request) {
      tags$div(
        class = "page",
        f7Navbar(
          title = "Settings",
          leftPanel = tagList(
            tags$a(
              href = "/me",
              class = "link back",
              tags$i(class = "icon icon-back"),
              tags$span("You")
            )
          )
        ),
        tags$div(
          class = "page-content",
          f7BlockHeader("ACCOUNT <EMAIL TBD>"),
          f7List(
            mode = "media",
            dividers = TRUE,
            strong = TRUE,
            f7ListItem(
              title = "Your Strava Subscription",
              subtitle = "Explore and manage your subscription",
              media = f7Icon("cart"),
              href = "/subscription"
            ),
            f7ListItem(
              title = "Connect an app or device",
              subtitle = "Upload directly to Strava
              with almost any fitness app or device",
              media = f7Icon("device_phone_portrait"),
              href = "/devices"
            ),
            f7ListItem(
              title = "Manage apps and devices",
              href = "#"
            ),
            f7ListItem(
              title = "Restore Purchases"
            ),
            f7ListItem(
              title = "Change Password",
              href = "#"
            ),
            f7ListItem(
              title = "Change Email",
              href = "#"
            ),
            f7ListItem(
              title = "Help",
              href = "#"
            )
          ),
          f7BlockHeader("PREFERENCES"),
          f7List(
            dividers = TRUE,
            strong = TRUE,
            f7ListItem(
              title = "Privacy Controls",
              href = "#"
            ),
            f7SmartSelect(
              "unit_of_measurement",
              "Unit of Measurement",
              choices = c("Kilometers", "Miles"),
              selected = "Kilometers",
              openIn = "popup" # page does not work with router layout
            ),
            f7SmartSelect(
              "temperature",
              "Temperature",
              choices = c("Celsius", "Fahrenheit"),
              selected = "Celsius",
              openIn = "popup"
            ),
            f7SmartSelect(
              "default_highlight_image",
              "Default Highlight Image",
              choices = c("Photo", "Map"),
              selected = "Photo",
              openIn = "popup"
            ),
            f7Toggle(
              "autoplay_video",
              "Autoplay Video",
              TRUE
            ),
            f7ListItem(
              title = "Default Maps",
              href = "#"
            ),
            f7ListItem(
              title = "Feed Ordering",
              "Change how activities
              are ordered in your feed",
              href = "#"
            ),
            f7ListItem(
              title = "Siri & Shortcuts",
              href = "#"
            ),
            f7ListItem(
              title = "Beacon",
              href = "#"
            ),
            f7ListItem(
              title = "Partner Integrations",
              href = "#"
            ),
            f7ListItem(
              title = "Weather",
              href = "#"
            ),
            f7ListItem(
              title = "Data Permissions",
              href = "#"
            ),
            f7ListItem(
              title = "Contacts",
              href = "#"
            ),
            f7ListItem(
              title = "Push Notifications",
              href = "#"
            ),
            f7ListItem(
              title = "Email Notifications",
              href = "#"
            )
          ),
          f7Block(
            strong = TRUE,
            f7Button(
              "logout",
              "Log Out",
              color = "red",
              fill = FALSE
            )
          )
        )
      )
    }
  )
}
