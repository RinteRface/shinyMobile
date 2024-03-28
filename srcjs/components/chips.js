$(function() {
  // chip label remove
  $(".chip-delete").on("click", function() {
    $(this)
      .closest(".chip")
      .remove();
  });
});

