export const setStyles = app => {
  // handle background for dark mode
  // need to remove the custom gainsboro color background
  isSplitLayout = $("#app").hasClass("split-layout");
  if (app.params.dark) {
    // Required to apply correct CSS in shinyMobile.css
    $("body").addClass("dark");
    // Fix panel color in splitlayout
    if (isSplitLayout) {
      if ($(".panel-left").hasClass("theme-light")) {
        $(".panel-left")
          .removeClass("theme-light")
          .addClass("theme-dark");
      }
    }
    $(".appbar").addClass("theme-dark");
  } else {
    // Required to apply correct CSS in shinyMobile.css
    $("body").addClass("light");
    // Fix panel color in splitlayout
    if (isSplitLayout) {
      if ($(".panel-left").hasClass("theme-dark")) {
        $(".panel-left")
          .removeClass("theme-dark")
          .addClass("theme-light");
      }
    }
  }
};
