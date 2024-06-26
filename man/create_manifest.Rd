% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f7-deprecated.R
\name{create_manifest}
\alias{create_manifest}
\title{Create a manifest for your shiny app}
\usage{
create_manifest(
  path,
  name = "My App",
  shortName = "My App",
  description = "What it does!",
  lang = "en-US",
  startUrl,
  display = c("minimal-ui", "standalone", "fullscreen", "browser"),
  background_color = "#000000",
  theme_color = "#0000ffff",
  icon
)
}
\arguments{
\item{path}{package path.}

\item{name}{App name.}

\item{shortName}{App short name.}

\item{description}{App description}

\item{lang}{App language (en-US by default).}

\item{startUrl}{Page to open at start.}

\item{display}{Display mode. Choose among \code{c("minimal-ui", "standalone", "fullscreen", "browser")}.
In practice, you want the standalone mode so that the app looks like a native app.}

\item{background_color}{The background_color property is used on the splash screen when the application is first launched.}

\item{theme_color}{The theme_color sets the color of the tool bar, and may be reflected in the app's preview in task switchers.}

\item{icon}{Dataframe containing icon specs. src gives the icon path
(in the www folder for instance), sizes gives the size and types the type.}
}
\value{
This function creates a www folder for your shiny app. Must specify the path.
It creates 1 folders to contain icons and the manifest.json file.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}.
\code{create_manifest} creates a manifest for your shiny App. Please use this workflow instead:
\url{https://unleash-shiny.rinterface.com/mobile-pwa.html#charpente-and-pwa-tools}.
}
\note{
See \url{https://developer.mozilla.org/en-US/docs/Web/Manifest} for more informations.
}
\keyword{internal}
