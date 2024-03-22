test_that("timeline works", {
  items <- tagList(
    lapply(1:5,
           function(i) {
             f7TimelineItem(
               paste0("Another text ", i),
               date = paste0(i, " Dec"),
               card = i %% 2 == 0,
               time = paste0(10 + i, ":30"),
               title = paste0("Title", i),
               subtitle = paste0("Subtitle", i),
               side = ifelse(i %% 2 == 0, "left", "right")
             )
           }
    )
  )

  expect_s3_class(f7Timeline(items), "shiny.tag")
  expect_identical(f7Timeline(items)$attribs$class, "timeline")
  expect_identical(
    f7Timeline(items, sides = TRUE)$attribs$class,
    "timeline, timeline-sides"
  )
  expect_identical(
    f7Timeline(items, calendar = TRUE)$attribs$class,
    "timeline-year"
  )

  timeline_children <- dropNulls(
    f7Timeline(items)$children[[1]][[1]]
  )
  expect_length(timeline_children, 5)
  expect_identical(timeline_children[[1]]$attribs$class, "timeline-item timeline-item-right")
  expect_identical(timeline_children[[2]]$attribs$class, "timeline-item timeline-item-left")
})
