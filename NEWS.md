# shinyMobile 0.2.0.9000

## Breaking changes
- `f7AutoComplete()`: type becomes openIn to align with the framework7 documentation
- remove parameter fill from `f7Icon()` (not used)
- Rewrite `f7Popup()`. It has now an input associated giving the popup state (opened or closed) as well
as new parameters: backdrop, closeByBackdropClick, closeOnEscape, animate and swipeToClose. 
label parameters has been removed. To create an `f7Popup()` put the `f7Popup()` tag in you UI. On the server side call `f7TogglePopup()`. See documentation for a detailed example. Thanks @pasahe
- `f7NavbarHide()` renamed to `f7HideNavbar()` for consistancy
- `f7NavbarShow()` renamed to `f7ShowNavbar()` for consistancy
- In `f7Gauge()` valueText was removed. It does not make sense that the value can be accidentally
different from the text displayed. valueText is then an internal parameter.
- In `f7DatePicker()`: min becomes minDate, max becomes maxDate and format becomes dateFormat

## Major changes
- add new `updateF7Select()`: thanks @Seyphaton for the suggestion
- add `f7TogglePopup()` to close/open a `f7Popup()`. Thanks @pasahe
- add `preview_mobile()`: function that previews your app in a seleted range of
devices (iphone, samsung, htc, ...)
- redesign the way inputs options are passed from R to Javascript. This does not have impact
on the user side but improves security and code quality

## Minor changes
- add extra parameters to `f7DatePicker()`: direction, openIn,
scrollToInput, closeByOutsideClick, toolbar, toolbarCloseText,
header and headerPlaceholder
- add new parameters to `updateF7Gauge()`. Thanks @rodrigoheck for the suggestion
- add noSwipping argument to `f7Slider()` to prevent wrong behaviour when used in `f7TabLayout()`
- `f7Select()` does not rely anymore on the shiny selectInput binding (does not have impact on user experience)
- add hidden argument to `f7Tab()`: allows to navigate through hidden tabs without displaying them
in the tab menu. Thanks @rodrigoheck
- add closeOnSelect param to `f7AutoComplete()`
- add new parameters to `f7Picker()` and `updateF7Picker()`: rotateEffect, openIn, scrollToInput, closeByOutsideClick, toolbar, toolbarCloseText and sheetSwipeToClose
- add color argument to `f7Icon()`
- add selected parameter to `f7Select()`
- update framework7 to 5.3.0
- add color to `updateF7Slider()`
- add color to `f7Slider()`
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
- Fix `f7Fab()` label white background color in dark mode
- fix #19: letting bigger TRUE in `f7Navbar()` would center the body content on scroll, due to a css conflict
- fix issue with `f7Slider()` and `f7TabLayout()`: When setting value of a slider in a swipeable f7TabLayout it cause the tab to be swip. This describe here : framework7io/framework7#2603. Thanks @pvictor
- fix #39: issue in `f7DatePicker()` format for months. Thanks @kmaheshkulkarni
- fix issue in `f7DatePicker()`: the viewport does not scroll to input by default
- fix typo in `f7AutoComplete()` example
- fix #43: slider label not visible on drag. Thanks @pasahe
- fix #42: add vertical overflow to `f7Popup()`. Thanks @pasahe
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
