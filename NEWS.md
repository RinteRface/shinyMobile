# shinyMobile 0.2.0.9000

## Breaking changes
- Rewrite `f7Popup()`. It has now an input associated giving the popup state (opened or closed) as well
as new parameters: backdrop, closeByBackdropClick, closeOnEscape, animate and swipeToClose. 
label parameters has been removed. To create an `f7Popup()` put the `f7Popup()` tag in you UI. On the server side call `f7TogglePopup()`. See documentation for a detailed example. Thanks @pasahe

## Major changes
- add `f7TogglePopup()` to close/open a `f7Popup()`. Thanks @pasahe
- add `preview_mobile()`: function that previews your app in a seleted range of
devices (iphone, samsung, htc, ...)
- redesign the way inputs options are passed from R to Javascript. This does not have impact
on the user side but improves security and code quality

## Minor changes
- add cheatsheet reference in the readme
- add `f7Slider()` labels (remove enableLabels param)
- add step, scaleSteps and scaleSubSteps to `updateF7Slider()`
- add scaleSteps, scaleSubSteps and verticalReversed to `f7Slider()`
- add decimalPoint to `updateF7Stepper()`
- rework `f7Stepper()`: add 2 more parameters (decimalPoint and buttonsEndInputMode)
- hideNavOnPageScroll is set to FALSE by default in `f7Init()`. This improves perfomances
on old devices
- improve `f7SingleLayout()` example (replace sliderInput by f7Slider)
- improve `f7SplitLayout()` example (replace sliderInput by f7Slider)
- improve `f7TabLayout()` example
- add more copyrights

## Bug fix
- fix #41: cannot render shiny outputs in `f7Popup()`. Now `f7Popup()` triggers shiny output rendering. Thanks @pasahe
- fix #31: `updateF7Gauge()` -> wrong fraction for semi circle gauges. 
- fix `f7Stepper()`: some options were not properly initialized (max, min, ...)
- fix `f7Slider()` example 2: wrong argument in help
- fix `f7Icon()` example: wrong function name
- fix `f7Row()` example
- `f7Sheet()`: hiddenItems is NULL by default
- Do no apply a magin bottom to the toolbar if there is no `f7Appbar()`


# shinyMobile 0.1.0

* Added a `NEWS.md` file to track changes to the package.
