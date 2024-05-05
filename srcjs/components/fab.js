import { getAppInstance } from "../init.js";

// if FAB is used in a page, it needs to be placed
// after .page-current and after the navbar if it exists,
// otherwise it will loose its sticky behaviour

$(document).ready(function() {
  const app = getAppInstance();

  var fab = $(".fab");
  var pageCurrent = $(".page-current");
  var navbar = $(".navbar");

  // establish the current parent of the FAB
  var parent = fab.parent();

  // check if the parent class is .page-content, and if so, get the id
  // whenever data-active='true' for this page, the FAB will be shown
  // if data-active='false', the FAB will be hidden
  if (parent.hasClass("page-content")) {
    var parentID = parent.attr("id");
    app.store.state.fabs.ids = parentID;
  }

  // whenever the .tab-active class is added to the parent id, the FAB will be shown
  // if the .tab-active class is removed, the FAB will be hidden
  // listen for changes on this id and show/hide the FAB accordingly
  var observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
      if (mutation.attributeName === "class") {
        if (mutation.target.classList.contains("tab-active")) {
          fab.show();
        } else {
          fab.hide();
        }
      }
    });
  });

  // observe the parent id for changes
  var target = document.getElementById(parentID);
  observer.observe(target, {
    attributes: true
  });

  if (pageCurrent.length > 0) {
    if (navbar.length > 0) {
      navbar.after(fab);
    } else {
      pageCurrent.append(fab);
    }
  }
});
