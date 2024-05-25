export const setStyles = app => {
  // handle background for dark mode
  // need to remove the custom gainsboro color background
  isSplitLayout = $("#app").hasClass("split-layout");
  if (app.params.dark) {
    // Required to apply correct CSS in main.scss
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
    // Required to apply correct CSS in main.scss
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

  // if body class is "dark", check if "dark" class is also present in html tag
  // on chromote sessions the html tag is not updated, leading to visual
  // differences in tests
  if ($("body").hasClass("dark")) {
    if (!$("html").hasClass("dark")) {
      $("html").addClass("dark");
    }
  }
};
