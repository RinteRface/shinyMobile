import { getAppInstance } from "../init.js";

$(function() {
  const app = getAppInstance();

  // handle f7InsertTab and f7RemoveTab ...
  // recover all tabSet ids in an array
  // The idea is that we will add each respective
  // id to the Shiny.addCustomMessageHandler function
  // which first argument is the type and should be the id
  // of the targeted tabSet

  function handleTabLinkHighlight() {
    $(".tab-link-highlight").remove();
    // calculate new segment width
    var segment_width = 100 / $(".toolbar-inner > a").length;
    // calculate new indicator position
    var tabs = $(".toolbar-inner > a");
    var tabsClasses = [];
    for (i = 0; i < tabs.length; i++) {
      tabsClasses.push(tabs[i].className);
    }
    var idx = tabsClasses.indexOf("tab-link tab-link-active");
    var translate_rate;
    // In case of removeTab, if no other tab is active,
    // we select the first tab after the one removed.
    if (idx === -1) {
      translate_rate = 0;
    } else {
      translate_rate = idx * 100 + "%";
    }

    $(".toolbar-inner").append(
      '<span class="tab-link-highlight" style="width: ' +
        segment_width +
        "%; transform: translate3d(" +
        translate_rate +
        ', 0px, 0px);"></span>'
    );
  }

  var tabIds = [];
  getAllTabSetIds = function() {
    $(".tabs").each(function() {
      tabIds.push(this.id);
    });
  };

  // call the function ...
  getAllTabSetIds();

  // f7InsertTab js
  tabIds.forEach(function(index) {
    var id = "insert_" + index;
    Shiny.addCustomMessageHandler(id, function(message) {
      // Handle when message.target is null
      var tabId;
      if (message.target === undefined) {
        tabId = $("#" + message.ns); // target the parent tabset
      } else {
        tabId = $("#" + message.ns + "-" + message.target);
      }

      var tab = $(message.value.html);

      // for swipeable tabs
      var newTab;
      if (tabId[0].tagName === "SWIPER-SLIDE") {
        // prepare the new slide
        newTab = `<swiper-slide 
          class="page-content tab"
          data-active=${tab.data("active")} 
          id=${tab.attr("id")} 
          data-value=${tab.data("value")} 
          data-hidden=${tab.data("hidden")}
        >${tab.html()}
        </swiper-slide>`;
        // remove page content class for standalone tabs
        if (
          $(".tabLinks")
            .children(1)
            .hasClass("segmented")
        ) {
          $(newTab).removeClass("page-content");
        }
        // add active if necessary
        if (message.select === "true") {
          $(newTab).addClass("swiper-slide-active");
        }
      } else {
        newTab = $(tab);
      }

      // Ignore position if target is not defined
      if (message.target === undefined) {
        // Insert tab content
        $(tabId).append(newTab);
        // Insert tab link in tabset toolbar
        $(".tabLinks .toolbar-inner").prepend(message.link);
      } else {
        if (message.position === "after") {
          // insert after the targeted tag in the tab-panel div
          $(newTab).insertAfter($(tabId));
          // we also need to insert an item in the navigation
          $(message.link).insertAfter(
            $(
              '.tabLinks [data-tab ="#' +
                message.ns +
                "-" +
                message.target +
                '"]'
            )
          );
        } else if (message.position === "before") {
          // insert before the targeted tag in the tab-panel div
          $(newTab).insertBefore($(tabId));
          // we also need to insert an item in the navigation
          $(message.link).insertBefore(
            $(
              '.tabLinks [data-tab ="#' +
                message.ns +
                "-" +
                message.target +
                '"]'
            )
          );
        }
      }

      // needed to render input/output in newly added tab. It takes the possible
      // deps and add them to the tag. Indeed, if we insert a tab, its deps are not
      // included in the page so it can't render properly
      Shiny.renderContent(tab[0], {
        html: tab.html(),
        deps: message.value.deps
      });

      // we need to transform a in button in case
      // the container has segmented class (for standalone tabs).
      // This is ignored for toolbar tabs
      if (
        $(".tabLinks")
          .children(1)
          .hasClass("segmented")
      ) {
        var newLink;
        var oldLink = $('.tabLinks [data-tab ="#' + message.id + '"]');
        newLink = $(oldLink).replaceWith(
          '<button class="button tab-link" data-tab="#' +
            message.id +
            '">' +
            $(oldLink).html() +
            "</button>"
        );
      }

      // update the swiper if needed
      if (tabId[0].tagName === "SWIPER-SLIDE") {
        // access the swiper container
        var swiper = document.querySelector("swiper-container").swiper;
        swiper.update();
      }

      // if the newly inserted tab is active, disable other tabs
      if (message.select === "true") {
        // trigger a click on corresponding the new tab button.
        app.tab.show("#" + message.id, true);
      }

      // we programmatically remove the old tabbar indicator and rebuild it.
      // The with of the tabbar indicator depends on the number of tab items it contains
      if (
        !$(".tabLinks")
          .children(1)
          .hasClass("segmented")
      ) {
        handleTabLinkHighlight();
      }
    });
  });

  // f7RemoveTab js
  tabIds.forEach(function(index) {
    var id = "remove_" + index;
    Shiny.addCustomMessageHandler(id, function(message) {
      // show the next tab first
      var tabToRemove = $("#" + message.ns + "-" + message.target);

      // important: prevent tab from translating which would lead to a
      // white screen
      if ($(".tabs.ios-edges").length > 0) {
        $(".tabs.ios-edges").css("transform", "");
      } else {
        $(".tabs").css("transform", "");
      }
      

      // remove the tab link: if condition to handle the case
      // of standalone tabs vs toolbar tabs
      if (
        !$(".tabLinks")
          .children(1)
          .hasClass("segmented")
      ) {
        $(
          '.toolbar-inner a[data-tab="#' +
            message.ns +
            "-" +
            message.target +
            '"]'
        ).remove();
      } else {
        var linkToRemove = $(
          '.tabLinks button[data-tab="#' +
            message.ns +
            "-" +
            message.target +
            '"]'
        );
        var otherLinks = $(".tabLinks button").not(
          '[data-tab="#' + message.ns + "-" + message.target + '"]'
        );
        if ($(linkToRemove).next().length === 0) {
          if (!$(otherLinks).hasClass("tab-link-active")) {
            $(linkToRemove)
              .prev()
              .addClass("tab-link-active");
          }
        } else {
          if (!$(otherLinks).hasClass("tab-link-active")) {
            $(linkToRemove)
              .next()
              .addClass("tab-link-active");
          }
        }
        $(linkToRemove).remove();
      }

      // remove the tab body content
      $("#" + message.ns + "-" + message.target).remove();

      // update the swiper if needed
      if (tabToRemove[0].tagName === "SWIPER-SLIDE") {
        // access the swiper container
        var swiper = document.querySelector("swiper-container").swiper;
        swiper.update();
      }

      // show the next element. Need to be after the swiper update.
      var nextTabId = $(tabToRemove)
        .next()
        .attr("id");
      app.tab.show("#" + nextTabId);

      // we programmatically remove the old tabbar indicator and rebuild it.
      // The with of the tabbar indicator depends on the number of tab items it contains
      if (
        !$(".tabLinks")
          .children(1)
          .hasClass("segmented")
      ) {
        handleTabLinkHighlight();
      }
    });
  });
});

