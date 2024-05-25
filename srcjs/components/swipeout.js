import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // Each click on swipeout item set shiny input value to TRUE
  // We also close the parent swipeout container. Set proirity to event
  // so that the input always invalidate observers on the R side, even though
  // its value does not change.
  $(".swipeout-item").each(function() {
    $(this).on("click", function() {
      Shiny.setInputValue($(this).attr("id"), true, { priority: "event" });
      // close the swipeout element
      app.swipeout.close($(this).closest(".swipeout")[0]);
    });
  });
});

