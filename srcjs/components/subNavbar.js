$(function() {
  // allow for subnavbar. If a subnavbar if provided in the navbar
  // add a custom class to the page so that the subnavbar is rendered
  var subnavbar = $(".subnavbar");
  if (subnavbar.length == 1) {
    $(".page").addClass("page-with-subnavbar");
  }
});

