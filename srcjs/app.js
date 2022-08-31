$(function() {
  // show reconnect notification
  $(document).on("shiny:disconnected", function(event) {
    // remove shiny server stuff
    $("#ss-connect-dialog").hide();
    $("#ss-overlay").hide();
    // use Framework7 internal tools
    var reconnectToast = app.toast
      .create({
        icon: '<i class="icon f7-icons">bolt_fill</i>',
        position: "center",
        text:
          'Oups... disconnected </br> </br> <div class="row"><button onclick="Shiny.shinyapp.reconnect();" class="toast-button button color-green col">Reconnect</button><button onclick="location.reload();" class="toast-button button color-red col">Reload</button></div>'
      })
      .open();

    // close toast whenever a choice is made ...
    $(".toast-button").on("click", function() {
      reconnectToast.close();
    });
  });

  // From this we can recover the workerId and the sessionId. sessionId
  // is the same recovered on the server side with session$token.
  $(document).on("shiny:sessioninitialized", function(event) {
    Shiny.setInputValue("shinyInfo", Shiny.shinyapp.config);
  });

  // Returns the last input changed (name, value, type, ...)
  $(document).on("shiny:inputchanged", function(event) {

    var type;
    if (event.binding !== null) {
      type = (event.binding.name !== undefined) ? event.binding.name.split(".")[1] : 'NA'
    } else {
      type = 'NA'
    }

    Shiny.setInputValue("lastInputChanged", {
      name: event.name,
      value: event.value,
      type: type
    });
  });

  // Framework7.device is extremely useful to set up custom design
  $(document).on("shiny:connected", function(event) {
    Shiny.setInputValue("deviceInfo", Framework7.device);
  });

  // handle toolbar padding for mobiles in standalone mode
  // only if there is an appbar
  if (Framework7.device.standalone) {
    $("html, body").css({ height: "100vh", width: "100vw" });
    if ($(".appbar").length > 0) {
      $(".toolbar").css("margin-bottom", "20px");
    }
  }

  // fix standalone tabs height issue
  $(".tabs-standalone").css("height", "auto");

  // Fix messagebar send icon issue when filled is TRUE. It is not
  // visible because it takes the same color has the messagebar background ...
  // To detect if the layout is filled, we search in the body class since the
  // global color is hosted here.
  if (app.params.filled && app.params.dark && $("body").attr("class") !== "#ffffff") {
    $(".demo-send-message-link")
      .find("i")
      .addClass("color-white");
  }

  // handle background for dark mode
  // need to remove the custom gainsboro color background
  isSplitLayout = $("#app").find(".splitlayout").length > 0;
  if (app.params.dark) {
    // Fix panel color in splitlayout
    if (isSplitLayout) {
      if ($(".panel-left").hasClass("theme-light")) {
        $(".panel-left")
          .removeClass("theme-light")
          .addClass("theme-dark");
      }
    }

    $(".demo-facebook-card .card-footer").css("background-color", "#1c1c1d");
    $(".sheet-modal, .swipe-handler").css("background-color", "#1b1b1d");
    $(".popup").css("background-color", "#1b1b1d");
    $(".fab-label").css("background-color", "var(--f7-fab-label-text-color)");
    $(".fab-label").css("color", "var(--f7-fab-text-color)");

    // fix black accordion text in dark mode
    $(".accordion-item .item-content .item-inner").css("color", "white");
    $(".accordion-item .accordion-item-content").css("color", "white");

    // below the sidebar id #f7-sidebar-view ensures that we do not
    // screw up the classic f7Panel style in dark mode
    // The sidebar background has to be slightly lighter than the main background
    var sidebarPanel = $("#f7-sidebar-view").find(".page-content");
    $(sidebarPanel).css("background-color", "#1e1e1e");
    // we also need to darken sidebar items in the sidebar menu
    // the default color does not contrast enough with the
    // new sidebar background
    var sidebarItems = $("#f7-sidebar-view").find("li");
    $(sidebarItems).css("background-color", "#171717");
  } else {
    $("div.messages").css("background-color", "gainsboro");
    $(".singlelayout.page-content").css("background-color", "gainsboro");
    $(".tablayout.tab").css("background-color", "gainsboro");

    // Fix panel color in splitlayout
    if (isSplitLayout) {
      if ($(".panel-left").hasClass("theme-dark")) {
        $(".panel-left")
          .removeClass("theme-dark")
          .addClass("theme-light");
      }
    }

    // fix photo browser links issue
    $("a").on("click", function() {
      setTimeout(function() {
        // we recover the body class that contains the page
        // color we set up in f7Init
        var linkColors = $("body").attr("class");
        $(".navbar-photo-browser .navbar-inner .title").css("color", "black");
        $(".navbar-photo-browser .navbar-inner .right .popup-close").css(
          "color",
          linkColors
        );
        $(".photo-browser-page .toolbar .toolbar-inner a").css(
          "color",
          linkColors
        );
      }, 100);
    });
  }

  // allow for subnavbar. If a subnavbar if provided in the navbar
  // add a custom class to the page so that the subnavbar is rendered
  var subnavbar = $(".subnavbar");
  if (subnavbar.length == 1) {
    $(".page").addClass("page-with-subnavbar");
  }

  // Update app instance params
  Shiny.addCustomMessageHandler('update-app', function(message) {
    // Merge new config to existing one
    app.utils.extend(app.params, message);
  });

  Shiny.addCustomMessageHandler('update-entity', function(message) {
    // Recover in which array is stored the given instance.
    // Uniqueness is ensured since HTML id are supposed to be unique.
    var instanceFamily;
    for (const property in app.data) {
      for (const e in app.data[property]) {
        if (e === message.id) {
          instanceFamily = property;
        }
      }
    }

    var oldInstance = app.data[instanceFamily][message.id];
    var oldConfig = oldInstance.params;
    var newConfig = app.utils.extend(oldConfig,  message.options);

    // Destroy old instance
    oldInstance.destroy();
    // Create new config
    var newInstance = app[instanceFamily].create(newConfig);
    // Update app data
    app.data[instanceFamily][message.id] = newInstance;
  });





  /**
  * Instantiate all widgets: gauges, swiper, searchbar
  */
  const uiWidgets = ["gauge", "swiper", "searchbar"];
  const serverWidgets = ["toast", "photoBrowser", "notification"];

  const widgets = uiWidgets.concat(serverWidgets);

  // Instantiate a widget
  activateWidget = function(widget) {
    // Handle ui side widgets
    if (uiWidgets.indexOf(widget) > -1) {
      $("." + widget).each(function() {
        var $el = $(this);
        var config = $(document).find(
          "script[data-for='" + $el.attr("id") + "']"
        );
        config = JSON.parse(config.html());
        // add the id
        config.el = '#' + $el.attr("id");

        // feed the create method
        app[widget].create(config);
      });
    } else {
      // This concerns toasts, notifications, photoBrowser, ...
      // that don't have any UI element in the DOM before creating
      // the widget instance.
      Shiny.addCustomMessageHandler(widget, function(message) {
        app[widget].create(message).open();
      });
    }
  };

  // Loop over all widgets to activate them
  widgets.forEach(function(w) {
    activateWidget(w);
  });


  // set up popovers
  popoverIds = [];
  getAllPopoverIds = function() {
    //In data-popover attribute we specify CSS selector of popover we need to open
    $("[data-popover]").each(function() {
      popoverIds.push($(this).attr("data-popover"));
    });
  };

  // call the function ...
  getAllPopoverIds();

  popoverIds.forEach(function(index) {
    Shiny.addCustomMessageHandler(index, function(message) {
      var popover = app.popover.create({
        targetEl: '[data-popover = "' + index + '"]',
        content:
          '<div class="popover">' +
          '<div class="popover-inner">' +
          '<div class="block">' +
          message.content +
          "</div>" +
          "</div>" +
          "</div>"
      });
      $('[data-popover = "' + index + '"]').on("click", function() {
        popover.open();
      });
    });
  });


  // New popover API shinyMobile 2.0.0
  Shiny.addCustomMessageHandler('add_popover', function(message) {
    // We store all created instances in app data so that we don't
    // recreate them later if they exist ...
    if (app.data.popovers[message.targetEl] === undefined) {
      // Only create if popover is enable for the current targetEl
      if (!$(message.targetEl).hasClass('popover-disabled')) {
        // popover HTML layout
        message.content = `
        <div class="popover">
          <div class="popover-angle"></div>
          <div class="popover-inner">
            <div class="block">${message.content}</div>
          </div>
        </div>
        `;

        // create instance
        var p = app.popover.create(message);
        // Open popover
        p.open();
        // Storage in app data (popovers array)
        app.data.popovers[message.targetEl] = p;
        }
    } else {
      // Only show if popover is enable for the current targetEl
      if (!$(message.targetEl).hasClass('popover-disabled')) {
        app.data.popovers[message.targetEl].open();
      }
    }
  });


  Shiny.addCustomMessageHandler('toggle_popover', function(message) {
    // Simply adds a class to indicate that the popover has to be hidden
    $(message).toggleClass('popover-disabled');
  });


  // Tooltips new API shinyMobile 2.0.0
  Shiny.addCustomMessageHandler('add_tooltip', function(message) {
    // We store all created instances in app data so that we don't
    // recreate them later if they exist ...
    if (app.data.tooltips[message.targetEl] === undefined) {
      // create instance
      var t = app.tooltip.create(message);
      // Open tooltip
      t.show();
      // Storage in app data (tooltips array)
      app.data.tooltips[message.targetEl] = t;
    }
  });

  Shiny.addCustomMessageHandler('update_tooltip', function(message) {
    if (app.data.tooltips[message.targetEl] !== undefined) {
      // Try to get the instance
      var t = app.tooltip.get(message.targetEl);
      if (message.action === "update") {
        if (t) {
          t.setText(message.text);
        }
      } else if (message.action === "toggle") {
        if (t) {
          // create copy that won't be modified if t is destroyed!
          var cachedTooltip = Object.assign({}, t);
          // save copy to replace the deleted one in the app data
          app.data.tooltips[message.targetEl] = cachedTooltip;
          // destroy current instance
          t.destroy();
        } else {
          // Parameters
          var pars = app.data.tooltips[message.targetEl].params;
          // recreate the tooltip based on the copy configuration
          t = app.tooltip.create(pars);
          app.data.tooltips[message.targetEl] = t;
        }
      }
    }
  });


  // handle dialog
  Shiny.addCustomMessageHandler("dialog", function(message) {
    var type = message.type;
    // decide to lock the vertical size so that
    // people don't need to manually add overflow.
    var text = `<div style="max-height: 300px; overflow-y: scroll;">${message.text}</div>`
    switch (type) {
      case "alert":
        var dialog = app.dialog.alert(text, message.title);
        break;
      case "confirm":
        var confirm = app.dialog
          .confirm(
            (text = text),
            (title = message.title),
            (callbackOk = function() {
              Shiny.setInputValue(message.id, true);
            }),
            (callbackCancel = function() {
              Shiny.setInputValue(message.id, false);
            })
          )
          .open(Shiny.setInputValue(message.id, null));
        //confirm.closed(Shiny.setInputValue(message.id, null));
        break;
      case "prompt":
        var prompt = app.dialog
          .prompt(
            (text = text),
            (title = message.title),
            (callbackOk = function(value) {
              Shiny.setInputValue(message.id, value);
            }),
            (callbackCancel = function() {
              Shiny.setInputValue(message.id, null);
            })
          )
          .open(Shiny.setInputValue(message.id, null));
        break;
      case "login":
        console.log(login);
        var login = app.dialog
          .login(
            (text = text),
            (title = message.title),
            (callbackOk = function(username, password) {
              Shiny.setInputValue(message.id, {
                user: username,
                password: password
              });
            }),
            (callbackCancel = function() {
              Shiny.setInputValue(message.id, null);
            })
          )
          .open(Shiny.setInputValue(message.id, null));
        break;
      default:
        console.log("");
    }
  });

  // handle taphold events
  Shiny.addCustomMessageHandler("tapHold", function(message) {
    var callback = new Function('return ('+ message.callback +')');
    $(message.target).on("taphold", function() {
      callback();
    });
  });

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
    for (i= 0; i<tabs.length; i++) {
      tabsClasses.push(tabs[i].className)
    }
    var idx = tabsClasses.indexOf("tab-link tab-link-active");
    var translate_rate;
    // In case of removeTab, if no other tab is active,
    // we select the first tab after the one removed.
    if (idx === -1) {
      translate_rate = 0;
    } else {
      translate_rate = idx * 100 + '%';
    }


    $(".toolbar-inner").append(
      '<span class="tab-link-highlight" style="width: ' +
        segment_width +
        '%; transform: translate3d(' + translate_rate + ', 0px, 0px);"></span>'
    );
  }

  var tabIds = [];
  getAllTabSetIds = function() {
    $(".tabs.ios-edges").each(function() {
      tabIds.push(this.id);
    });
  };

  // call the function ...
  getAllTabSetIds();

  // f7InsertTab js
  tabIds.forEach(function(index) {
    var id = "insert_" + index;
    Shiny.addCustomMessageHandler(id, function(message) {
      var tabId = $('#' + message.ns + '-' + message.target);

      var tab = $(message.value.html);


      // for swipeable tabs
      var newTab;
      if ($(tabId).hasClass("swiper-slide")) {
        // prepare the new slide
        newTab = $(tab).addClass("swiper-slide");
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
        if (app.params.dark) $(newTab).css("background-color", "");
      } else {
        // remove white background for tab in dark mode
        newTab = $(tab);
        if (app.params.dark) $(newTab).css("background-color", "");
      }

      if (message.position === "after") {
        // insert after the targeted tag in the tab-panel div
        $(newTab).insertAfter($(tabId));
        // we also need to insert an item in the navigation
        $(message.link).insertAfter(
          $(
            '.tabLinks [data-tab ="#' + message.ns + "-" + message.target + '"]'
          )
        );
      } else if (message.position === "before") {
        // insert before the targeted tag in the tab-panel div
        $(newTab).insertBefore($(tabId));
        // we also need to insert an item in the navigation
        $(message.link).insertBefore(
          $(
            '.tabLinks [data-tab ="#' + message.ns + "-" + message.target + '"]'
          )
        );
      }

      // needed to render input/output in newly added tab. It takes the possible
      // deps and add them to the tag. Indeed, if we insert a tab, its deps are not
      // included in the page so it can't render properly
      Shiny.renderContent(
        tab[0],
        {html: tab.html(), deps: message.value.deps}
      );

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
      if ($(tabId).hasClass("swiper-slide")) {
        // access the swiper container
        var swiper = document.querySelector(".swiper-container").swiper;
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
      $(".tabs.ios-edges").css("transform", "");

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
      if ($(tabToRemove).hasClass("swiper-slide")) {
        // access the swiper container
        var swiper = document.querySelector(".swiper-container").swiper;
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


  // Update gauges
  Shiny.addCustomMessageHandler("update-gauge", function(message) {
    var el = "#" + message.id;
    app.gauge.get(el).update(message);
  });


  // Create and show all f7Progress
  activateAllProgress = function() {
    $(".progressbar").each(function() {
      var el = "#" + $(this).attr("id");
      var progress = parseInt($(this).attr("data-progress"));
      // color does not work from JS (needs to be done from R)
      app.progressbar.show(el, progress);
    });
  };

  activateAllProgress();

  // update f7Progress
  Shiny.addCustomMessageHandler("update-progress", function(message) {
    app.progressbar.set("#" + message.id, message.progress);
  });


  // show navbar (to remove)
  Shiny.addCustomMessageHandler("show_navbar", function(message) {
    var animate;
    if (message.animate == "true") animate = true;
    else animate = false;
    app.navbar.show(".navbar", (animate = message.animate));
  });

  // hide navbar (to remove)
  Shiny.addCustomMessageHandler("hide_navbar", function(message) {
    var animate;
    var hideStatusbar;
    if (message.animate == "true") animate = true;
    else animate = false;
    if (message.hideStatusbar == "true") hideStatusbar = true;
    else hideStatusbar = false;
    app.navbar.hide(
      ".navbar",
      (animate = animate),
      (hideStatusbar = hideStatusbar)
    );
  });

  // toggle navbar
  Shiny.addCustomMessageHandler("toggle_navbar", function(message) {
    $navbar = $('.navbar');
    var isHidden = $navbar.hasClass('navbar-hidden');
    if (isHidden) {
      app.navbar.show(".navbar", animate = message.animate);
    } else {
      app.navbar.hide(".navbar", animate = message.animate, hideStatusbar = message.hideStatusbar);
    }
  });

  // handle action sheet
  Shiny.addCustomMessageHandler("action-sheet", function(message) {
    // Only create action sheet whenever necessary
    if (app.data.actions[message.id] === undefined) {
      var buttonsId = message.id + "_button";

      // define function that set an inputvalue those name depends on an index
      // parameter
      function setButtonInput(index) {
        Shiny.setInputValue(buttonsId, index);
      }

      // add those functions to the message.button array
      function setOnClick(element, index) {
        Object.defineProperty(element, "onClick", {
          value: function() {
            setButtonInput(index + 1);
          },
          writable: false
        });
      }

      message.buttons.forEach(setOnClick);

      // Callbacks for shiny inputs
      message.on = {
        opened: function() {
          Shiny.setInputValue(message.id, true);
        },
        closed: function() {
          Shiny.setInputValue(message.id, false);
          // input$button is null when the action is closed
          Shiny.setInputValue(buttonsId, null);
        }
      };

      // create the sheet
      var a = app.actions.create(message)
      a.open();
      // save action sheet to app data to update it later
      app.data.actions[message.id] = a;

    } else {
      app.data.actions[message.id].open();
    }
  });


  Shiny.addCustomMessageHandler("update-action-sheet", function(message) {
    // Destroy old instance
    app.data.actions[message.id].destroy();
    // Create new config
    var a = app.actions.create(message);
    // Update app data
    app.data.actions[message.id] = a;
  });



  // pull to refresh
  // add the preloader tag dynamically
  if ($('body').attr('data-ptr') === 'true') {
    const ptrLoader = $(
      '<div class="ptr-preloader">' +
        '<div class="preloader"></div>' +
        '<div class="ptr-arrow"></div>' +
        "</div>"
    );

    // add useful classes to the page content
    $(".page-content")
      .addClass("ptr-content")
      .prepend(ptrLoader)
      .attr("data-ptr-distance", "55")
      .attr("data-ptr-mousewheel", "true");

    // we need to create the ptr manually since it
    // is added after the page initialization
    app.ptr.create(".ptr-content");
    var ptr = app.ptr.get(".ptr-content");
    // Add 'refresh' listener on it
    ptr.on("refresh", function(e) {
      // Emulate 2s loading
      Shiny.setInputValue("ptr", true);
      setTimeout(function() {
        app.ptr.done();
      }, 2000);
    });

    // reset input. This will prevent observeEvent from
    // always being fired since they ignore NULL by default.
    // Therefore, instead of setting ptr to FALSE, we set it
    // to null
    ptr.on("done", function(e) {
      Shiny.setInputValue("ptr", null);
    });
  }

  // validate inputs (see f7ValidateInput)
  Shiny.addCustomMessageHandler("validate-input", function(message) {
    $("#" + message.target)
      .attr("required", "")
      .attr("validate", "")
      .attr("pattern", message.pattern)
      .attr("data-error-message", message.error);

    $("#" + message.target)
      .closest(".item-content.item-input")
      .addClass("item-input-with-info");
    var infoTag;
    if (message.info !== undefined) {
      infoTag = '<div class = "item-input-info">' + message.info + "</div>";
    }
    $("#" + message.target)
      .parent()
      .append(infoTag);
  });

  // preloader
  Shiny.addCustomMessageHandler("show-preloader", function(message) {
    if (typeof message.el !== "undefined") {
      app.preloader.showIn(message.el, message.color);
    } else {
      app.preloader.show(message.color);
    }
  });

  Shiny.addCustomMessageHandler("hide-preloader", function(message) {
    if (typeof message.el !== "undefined") {
      app.preloader.hideIn(message.el);
    } else {
      app.preloader.hide();
    }
  });


  // Each click on swipeout item set shiny input value to TRUE
  // We also close the parent swipeout container. Set proirity to event
  // so that the input always invalidate observers on the R side, even though
  // its value does not change.
  $('.swipeout-item').each(function() {
    $(this).on('click', function() {
      Shiny.setInputValue($(this).attr('id'), true, {priority: 'event'});
      // close the swipeout element
      app.swipeout.close($(this).closest('.swipeout'));
    });
  })

});

