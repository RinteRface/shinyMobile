# shinyMobile 2.0.0
## Major change
- Update Framework7 from 5.7.14 to 8.3.2
- Whenever you have multiple inputs, we now recommend to wrap all of them within `f7List()` which allows you to benefit from new styling options such as outline, inset, strong, ... Internally, we use a function able to detect whether the input is inside a `f7List()`: if yes, you can style this list by passing parameters like `f7List(outline = TRUE, inset = TRUE, ...)`; if not, the input is internally wrapped in a list to have correct rendering (but no styling is possible). Besides, some input like `f7Text()` can have custom styling (add an icon, clear button, outline style), which is independent from the external list wrapper style. Hence, we don't recommend doing `f7List(outline = TRUE, f7Text(outline = TRUE))` since it won't render very well (only use `f7List(outline = TRUE, f7Text())`). Please have a look at the corresponding examples in the documentation.

## Breaking changes
- The aurora theme has been removed. Supported themes are now: ios, md and auto. In case of auto it will use iOS theme for iOS devices and MD theme for all other devices.
- `f7AddMessages()` is definitely removed. Deprecated from previous releases.
- `f7Appbar()` has been removed in Framework7. We have no alternative to replace it.
- `f7ShowNavbar()` and `f7HideNavbar()` are removed, as long time deprecated.
- `f7checkBox()` and `f7checkBoxGroup()` are removed, as long time deprecated.
- Remove `f7InsertTab()`, `f7RemoveTab()` as long time deprecated.
- Remove `f7ValidateInput()` as long time deprecated.
- Remove `f7Popover()` and `f7PopoverTarget()` as long time deprecated.
- Remove `f7ShowPreloader()` and `f7HidePreloader()` as long time deprecated.
- `f7Menu()`, `f7MenuItem()`, `f7MenuDropdown()`, `f7MenuDropdownDivider()` and `updateF7MenuDropdown()` are totally removed from Framework7. We have no alternative to replace it.
- `f7Icon()`: remove deprecated parameter `old`.
- `f7SmartSelect()`: `maxlength` becomes `maxLength`. Typo from Framework7.
- Remove `value` from `f7Password()` (accidental copy and paste from `f7Text()`).

## Soft deprecation
- `f7Accordion()`:
    - `multiCollapse` has been removed in Framework7.
- `f7Block()`:
    - `hairlines` is deprecated since removed from Framework7.
- `f7Segment()`:
    - `container` is deprecated, removed from Framework7.
- `f7Navbar()`:
    - `shadow` and `subtitle` have been removed in Framework7.
- `f7SocialCard()` is deprecated as the same result can be achieved with `f7Card()`.
- `f7AutoComplete()`: `expandInput` is deprecated, removed from Framework7.
- `f7Row()`, `f7Col()` and `f7Flex()` are deprecated in favor of `f7Grid()`, as specified by Framework7 8.3.2
- `f7Fabs()`: `morph` is deprecated. Only `morphTarget` is used.
- `f7Toolbar()`:
    - `hairline` and `shadow` are deprecated, removed from Framework7.
- `f7Shadow()`removed from Framework7. No replacement. Will be removed in a future release.
- `f7Swipeout`: deprecate `side` parameter and `...`. Now use either `left`/`right` or both.
- `f7AutoComplete`: `value` now defaults to `NULL` (instead of the first choice).

## Minor change
- New component `f7Treeview()`: display items in a treeview. Used in combination with `f7TreeviewItem()` and `f7TreeviewGroup()`. 
- `f7Messages()`: the corresponding input is now a list of lists, each item being a single `f7Message()`. The previous setting was not optimal R,the JS binding was returning a array of objects, which can't be easily translated to R. We now return an object of objects which becomes a list of lists.
- `f7Block()` gains an `outline` parameter (add grey border).
- `f7Button()` get a new `tonal` style.
- `f7Card()` get a new `raised` and `divider` parameters.
- `f7CheckboxGroup()` has a new `position` parameter to control
the check icon position. Default to left.
- `f7CheckboxChoice()`: new function to pass inside `choices` in a
`f7CheckboxGroup()`. Improved choice with title, subtitle, ...
- `f7List()` has new `outline`, `dividers` and `strong` styles. `mode` gains 2 new values: `simple` and `links`.
- `f7ListIndex()` now gets applied to an specific element, instead of the whole page. This makes it possible to add multiple lists with list indexes to the same app.
- Added `id` argument to `f7List()`, which makes it possible to use an id as target in `f7ListIndex`.
- `f7Panel()` has new "floating"/"push" effects as well as a new `options` parameter
to pass in extra configuration. See https://framework7.io/docs/panel#panel-parameters.
- `f7VirtualList()` has new `outline`, `dividers` and `strong` styles. Additionally, `mode` was added with the following possible values: `simple`, `links`, `media` or `contacts`.
- `f7Popup()` has a new `push` effect (pushin the main view behind on opening).
- `f7Radio()` has a new `position` parameter to control
the check icon position. Default to left (like `f7CheckboxGroup()`).
Also, `f7Radio()` inherits from `f7List()` styling parameters such as `inset`, `outline`,`dividers`, `strong` for more styling option.
- `f7RadioChoice()`: new function to pass inside `choices` in a
`f7Radio()`. Improved choice with title, subtitle, ...
- `f7Sheet()` gains new `options` parameter to allow passing more configuration. See https://framework7.io/docs/sheet-modal#sheet-parameters.
- `f7Picker()` has new `...` parameter to pass custom options. Also `f7Picker()` now can have NULL as `value`, allowing you to display a placeholder.
- `f7DatePicker()` has new `...` parameter to pass custom options. `f7DatePicker()` now also supports usage of the `timePicker`, and returns a posixct object when this is enabled. See https://framework7.io/docs/calendar#examples.
- Added `tapHoldPreventClicks`, `touchClicksDistanceThreshold`, `mdTouchRipple` to `f7Page()` touch options.
- `showF7Preloader()` has new `type` parameter and a new modal dialog support (if `type` is passed). New `id` parameter that has to be set when `type` is not NULL.
- `hideF7Preloader()` has a new `id` parameter. This is to hide modals or progress from the server.
- New `updateF7Preloader()` to be able to update a progress preloader from the server.
- `f7PhotoBrowser()` fixed the `pageBackLinkText` to `back` when type was set to `page`, but this has been removed. The Framework7 default is now used, or the `pageBackLinkText` can be set manually (iOS only).
- `f7ColorPicker()` has new `...` parameter to pass custom options and now returns a list of values with hex, rgb, hsl, hsb, alpha, hue, rgba, and hsla values.
- `f7Slider()` has new `...` parameter to pass extra options. New
`showLabel` parameter: fix an unfortunate naming conflict between the input label (name) and the name Framework7 has given to the bubble component (label).
- `f7AutoComplete()` and `updateF7AutoComplete()` have new `...` parameter to pass extra options as well as a new `style` parameter to customize the input look and feel. `f7AutoComplete()` has new `style` parameter to allow for custom styling only when `openIn` is `dropdown`.
- `f7SplitLayout()` has a new look and at a minimal app width (1024 px) the sidebar becomes always visible. The sidebar will be collapsed on smaller screens. 
- `f7Text()`, `f7TextArea()` and `f7Password()` have new parameters: `description`, `media`, `floating`, `outline` and `cleareable` for more styling options. `label` can also be NULL.
- `f7Select()` has new `description`, `media` and `outline` parameters.
- Fix various issues in documentation.

# shinyMobile 1.0.1

## New
- Added webR to pkgdown infrastructure which allows to run shinylive
apps in the documentation.

## Minor change
- Add `limit` to `f7AutoComplete()`. Thanks @bthieurmel.

## Bug fixes
- Fix ignored __height__ in `f7Card()` (Typo).
- Fix CRAN note.

# shinyMobile 1.0.0

## New
- Added `skeletonsOnLoad` to `f7Page()` options (not compatible) with `preloader`.

## Breaking change
- `preloader` is moved to `f7Page()` options list. 
- Removed `loading_duration` from `f7Page()`. Now the preloader will automatically disappear when shiny is idle like in `{bs4Dash}`.
- __panels__ becomes __panel__ in `f7SplitLayout()` for consistency reasons.
- `f7Tab()` uses `validate_tabName` so that `Tab 1` is not valid anymore but `Tab1` yes.
Tabs will have to be manually renamed.
- `f7Popup()` is now generated on the server side like `f7Notif()`. Remove `updateF7Popup()`,
`f7TogglePopup()`.
- Reworked `f7listIndex()`: remove `f7ListIndexItem()`. `f7ListIndex()` is generated from
the server side.
- Reworked `f7Skeleton()`: triggered from server side. See examples.

## Bug fixes and improvements
- Improve `f7Swiper()`: better CSS, pagination, navigation, scrollbar, ...
- Fix issue in `f7PhotoBrowser()` example: wrong default theme ...
- `f7CheckBox()`: better layout.
- Fix issue in `f7FabMorphTarget()` example.
- Fix #226: `f7PhotoBrowser()` just works with two or more pictures. Fix issue in JSON conversion.
- Fix issue in `updateF7Popup()` documentation (showed as deprecated by mistake).
- New skeleton effect on load (automatic): applied grey background on elements loading.
Ends when shiny is idle.
- New skeleton effect on output recalculation. 
- Fix issue in `f7Navbar()`: hard-coded css style causing white text on white
background.
- Fix #151: Issue in navbar/toolbar scroll. See [here](https://github.com/RinteRface/shinyMobile/issues/151).
- Fix #165: Setting separate theme for panels does not work.
- Fix #181: Adding dynamic tab to an empty panel.
- Related to #220. A new __title__ parameter is available for `f7Tab()` so as to pass any
name, as oposed to __tabName__. 
- Fix #228: Vignette Example doesn't show graphs. Breaking change in shiny 1.7.2.
- Issue in `f7SmartSelect()` with __openIn__ param (failed when not provided).
- Fix #219: Avoid using inline CSS so that users can easily override {shinyMobile} defaults.
- Fix #220: `f7Tab()` can create duplicate IDs which in turn break the page. Now we use `validate_tabName` internally
to check whether the tab is valid (avoid JS issues with jQuery selectors)...
- Fix #224: `updateF7AutoComplete()` accepts __choices__.
- Fixes #217: `f7SmartSelect()` interfering NS for server-side module.
- Fixes #215: Icon not displayed in reconnect / reload toaster. Add f7Icon deps anyway.
- Fixes #204: issue with `f7DatePicker()` and DST. 
- Update CI/CD setup.
- Fix [issue](https://github.com/RinteRface/shinyMobile/issues/165#issuecomment-1226581561) where `f7Page()` does not accept anymore color by its name. Now, and like in earlier versions, `f7Page()` accepts either hex code or color name. 
- Fixes #222: `f7Slider()` code updated to work with the fix for #215 above. 


# shinyMobile 0.9.1
This release only fixes an issue with Shiny 1.7.0 with a failing unit [test](https://github.com/RinteRface/shinyMobile/pull/211). Thanks @schloerke


# shinyMobile 0.9.0

This release also fixes an issue with R CMD check and htmltools.

## Breaking change
- `f7Link()` __icon__ now expects `f7Icon()`. __label__ is not mandatory anymore.

## Major change
- New `updateF7Radio()`. Fixes #135. Thanks @korterling.

## Minor change
- More security for embedded apps. 
- Added shinyMobile hands on slides in Getting Started vignette. 
- `f7Dialog()` has a fixed height of 300px and vertical overflow to avoid issues.
- Add `...` to `f7SmartSelect()`. 
- Add `options` to `f7SearchBar()` to provide more configuration. Fixes #47: thanks @rodrigoheck.
- Add `valueText` param for `f7Gauge()`. Fixes #84: thanks @tanho63.
- Reworked `f7Gauge()` JS code (no user impact).
- Rework widget JS code base (no user impact). 

## Bug fixes
- Fix #180: Tab highlight index issue for android devices when tab remove or add tab.
- Fix #190: How to add a longer dialog text for f7Dialog.
- Fix #154: How to include link icon in f7Link() function.
- Fix #127: Enable groups in `f7SmartSelect()`. 
- Fix #174 and #134: Reactive elements created inside `insertF7Tab()` are losing reactivity.
- Fix #98: `f7DatePicker()` visibility issue. Thanks @styvens.
- Fix #120: `f7Button()` with link not working. Thanks @bwganblack.
- Fix #144: Close `f7SmartSelect()` on selection. Thanks @dewalex.


# shinyMobile 0.8.0

This release is to addresses the following reverse dependency issue with [shiny](https://github.com/rstudio/shiny/pull/3239). Moreover, it also starts
the road to v1.0.0 (later this year).

## Soft Deprecations
- `f7AddMessages()` will become `updateF7Messages()` in future release
- `f7HideNavbar()` and `f7ShowNavbar()` will be replaced by `updateF7Navbar()`
- `f7ShowPopup()` will become `updateF7Popup()`
- `f7checkBox()` will become `f7Checkbox()`
- `f7checkBoxGroup()` will become `f7CheckboxGroup()`
- `f7ValidateInput()` will become `validateF7Input()`
- `f7InsertTab()` and `f7RemoveTab()` will becomes `insertF7Tab()` and `removeF7Tab()`,
respectively
- `f7ShowPreloader()` and `f7HidePreloader()` will become `showF7Preloader()` and
`hideF7Preloader()`, respectively. 
- `f7Popover()` and `f7PopoverTarget()` replaced by `addF7Popover()` and `toggleF7Popover()`
- `create_manifest()` is going to be replaced by the workflow described here: https://unleash-shiny.rinterface.com/mobile-pwa.html#charpente-and-pwa-tools

## Breaking changes

### Inputs
- `updateF7Fabs()`: __inputId__ becomes __id__

### Layout
- `f7Appbar()`: __left_panel__ becomes __leftPanel__ and __right_panel__ __rightPanel__
- `f7Init()` removed. Now pass it through the `f7Page()` __options__
- `f7Navbar()`:  __left_panel__ becomes __leftPanel__ and __right_panel__ __rightPanel__
- `f7Panel()` and `updateF7Panel()`: __inputId__ becomes __id__
- `f7InsertTab()` and `f7RemoveTab()`: __inputId__ becomes __id__

### Cards
- `f7ExpandableCard()` and `f7Card()`: __img__ becomes __image__
- `f7SocialCard()`: __author_img__ becomes __image__

### Lists
- `f7ListItem()`: __url__ becomes __href__
- `f7VirtualListItem()`:  __url__ becomes __href__
- `updateF7VirtualList()`: __old_index__ and __new_index__ become __oldIndex__ and __newIndex__, respectively

### Interactions
- __session__ not mandatory in `f7Toast()`, `updateF7Progress()`, ... and has been
swapped at the end of the parameters for more convenience
- `f7Dialog()`: __inputId__ becomes __id__
- `updateF7Sheet()`: __inputId__ becomes __id__


### Buttons
- `f7Link()`: __external__ has been removed from  (much simpler), __src__ becomes __href__
- `f7Button()`: __src__ becomes __href__

### Others
- __session__ swapped to the end in `f7Gauge()` and not mandatory. Default to `shiny::getDefaultReactiveDomain()`
- `f7Chip()`: __icon_status__ becomes __iconStatus__, __img__ becomes __image__
- __inputId__ becomes __id__ in `f7Accordion()` and `updateF7Accordion()`
- Remove `f7ProgressInf()` (useless)
- Change `f7Swiper()` API. New __options__ parameter
- `f7PhotoBrowser()` is now called from the shiny server function. See help, __id__ and 
__label__ have been removed
- __id__ mandatory for `f7Searchbar()`


## Major changes
- New `updateF7Entity()`
- New `updateF7ActionSheet()`
- New `addF7Tooltip()` and `updateF7Tooltip()` to generate tooltips from the server
- New __allowPWA__ parameter in `f7Page()` so that we doesn't oblige users to create a PWA
- `f7Page()` has a new __options__ parameter as replacement of `f7Init()`. Much simpler to handle
- update framework7 from 5.5.0 to 5.7.14
- add `f7Menu()`, `f7MenuItem()`, `f7MenuDropdown()`, `f7MenuDropdownDivider()` and `updateF7MenuDropdown()`: special buttons and dropdown elements, behaving like action buttons

## Minor changes
- app instance accessible from anywhere is JS code
- New __...__ parameter for `f7PhotoBrowser()`
- Add choices to `updateF7SmartSelect()`: thanks @Edireito
- Add disconnect toast if `shiny:disconnect` occurs. Gives ability to reload or reconnect

## Bug fixes
- Fix #128 and #140: workerId issue in url. Thanks @Tixierae and @ppagnone.
- Fix #104: f7Picker cannot have NULL value. Prevents JS from breaking. Thanks @Seyphaton
- Correcting an internal use of `htmltools::attachDependencies()` in `create_app_ui`


# shinyMobile 0.7.0

## Notes
- disable backdrop in `f7Searchbar()` since it messes up with tabbar navigation. This does 
not have any impact on user experience. In a future release of shinyMobile, `f7Searchbar()` will have input binding associated as well as more parameters for configuration

## Breaking changes
- `f7SmartSelect()`: type param becomes openIn to align with other inputs
- rework `f7Messages()`: messages are updated on the server side with `f7AddMessages()`. New `f7MessageBar()` to send messages from the server side.
- `f7ActionSheet()`: to access the currently selected button, use input$[sheet_id]_button. This is to make action sheets compatible with shiny modules. Moreover, the buttons provided
must be included in a list (not in a dataframe)
- `f7Sheet()` is still inserted in the UI side but can be triggered either on the server side in combination with `updateF7Sheet()` (see example) or on the UI side. Overall, this improves flexibility since user may choose any trigger element. In practice, any element having `data-sheet` pointing to the sheet id as well as the "sheet-open" css class may open it, instead of having a default trigger contained in the sheet. A use case may be to open a sheet in the tabbar (the trigger would be a `f7TabLink()` that is a special button styled for the tabbar)
- All update method for inputs : argument `session` is now optional and has been moved to the last position in function call
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
- remove maximizable parameter from `f7Appbar()`

## Major changes
- new `input$shinyInfo` and `input$lastInputChanged` (see shinyMobile tools vignette for more details)
- `f7SmartSelect()` has input binding as well as an update function `updateF7SmartSelect()`
- new `f7VirtualList()`, `f7VirtualListItem()`, `updateF7VirtualList()`: high performance list with caching system -> faster rendering (up to 10x faster than `f7List()`). Ability to add item(s), remove item(s), move item, filter items, ...
- new messagebar parameter to `f7TabLayout()`. This allows to use the `f7Messagebar()` in a tabs layout configuration. 
- new `f7ValidateInput()` function to validate input from the server side (similar to
shinyFeedback but internal to shinyMobile and without dependencies)
- new `f7Login()` and `updateF7Login()` feature to provide UI boilerplates
for authentication
- `f7Tabs()` may be used as standalone components with the style argument (segmented or strong). toolbar has the default behavior.
- update `f7Icon()` and icons dependencies. thanks @pvictor
- new `updateF7DatePicker()`: thanks @pvictor
- add input binding to `f7Fabs()` to get the status of the container
- add `updateF7Button()` and `updateF7Fabs()`
- new pullToRefresh parameter to `f7Init()`. Pull the screen from top to bottom fires `input$ptr` which becomes TRUE. When the pull to refresh event is finished, `input$ptr` is NULL. Useful to trigger events in an observeEvent
- add new `updateF7Select()`: thanks @Seyphaton for the suggestion
- add `f7TogglePopup()` to close/open a `f7Popup()`. Thanks @pasahe
- add `preview_mobile()`: function that previews your app in a seleted range of
devices (iphone, samsung, htc, ...)
- redesign the way inputs options are passed from R to Javascript. This does not have impact
on the user side but improves security and code quality

## Minor changes
- add new `f7File()` for file upload. See shiny `fileInput`
- add new `f7DownloadButton()` to work properly with the shiny `downloadHandler` function. Thanks @bwganblack for the report
- add new tapHoldDelay parameter to `f7Init()` to control the delay necessary to trigger
a long press (default to 750 ms)
- new `f7ShowPreloader()` and `f7HidePreloader()`
- new `f7TextArea()` input and `updateF7TextArea()` on the server side
- add block title for `f7checkBoxGroup()` and `f7Radio()`
- add new `f7TabLink()` (special link to insert in `f7Tabs()` that may open a `f7Sheet()`)
- add new active parameter to `f7Button()`
- add new strong parameter to `f7Segment()`
- Improve website. Thanks @pvictor
- new fullsize and closeButton parameter to `f7Popup()` + rewrite js binding. Thanks @pvictor
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
- Fix issue in `updateF7AutoComplete`: text input was not updated. Thanks @sanchez5674 for the report
- Remove duplicated html tag in `f7Page()`. Thanks @ pvictor
- Fix issue in `f7Sheet()` wrong css style applied when multiple sheets are in the same app
- Fix issue in `f7Tabs()`: if one put `f7Tabs()` inside a `f7Tab()` in a parent `f7Tabs()`, the input binding was giving the wrong tab for the top level tabset (once we clicked in the tab containing the sub-tabset). 
- Fix issue with `f7InsertTab()` and `f7RemoveTab()` when swipeable is TRUE
- trigger shown event for `f7Tabs()` on click. This allows to use `f7Tabs()`
without swipeable and animated
- Allow output elements to be displayed in `f7Panel()` (need to provide the `f7Panel()` inputId)
- Prevent `f7Swipeout()` to make the current tab swipping if in `f7TabLayout()`
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
