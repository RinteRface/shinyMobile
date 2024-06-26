% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{app_container}
\alias{app_container}
\title{Create an iframe container for app demo}
\usage{
app_container(url, deps = FALSE, skin, color = NULL, landscape = FALSE)
}
\arguments{
\item{url}{app URL.}

\item{deps}{Whether to include marvel device assets. Default to FALSE.
The first occurence must set deps to TRUE so that CSS is loaded in the page.}

\item{skin}{Wrapper devices.}

\item{color}{Wrapper color. Only with iphone8 (black, silver, gold),
iphone8+ (black, silver, gold), iphone5s (black, silver, gold),
iphone5c (white,red , yellow, green, blue), iphone4s (black, silver), ipadMini (black, silver) and
galaxyS5 (black, white).}

\item{landscape}{Whether to put the device wrapper in landscape mode. Default to FALSE.}
}
\description{
Create an iframe container for app demo
}
\keyword{internal}
