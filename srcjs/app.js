import Framework7 from 'framework7/bundle'
import { getAppInstance } from './init.js'

$(function() {

  const app = getAppInstance();

  // utility to reset the input system
  // whenever elements are added on the fly to the UI
  function shinyInputsReset() {
    Shiny.unbindAll();
    Shiny.initializeInputs();
    Shiny.bindAll();
  }

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
          'Disconnected ... </br> </br> <div class="row"><button onclick="Shiny.shinyapp.reconnect();" class="toast-button button color-green col">Reconnect</button><button onclick="location.reload();" class="toast-button button color-red col">Reload</button></div>'
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
      Shiny.setInputValue("lastInputChanged", {
        name: event.name,
        value: event.value,
        type: type
      });
    }
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

  // Fix messagebar send icon issue when filled is TRUE. It is not
  // visible because it takes the same color as the messagebar background ...
  // To detect if the layout is filled, we search in the body class since the
  // global color is hosted here.
  if (app.params.filled && app.params.dark && $("body").attr("class") !== "#ffffff") {
    $(".demo-send-message-link")
      .find("i")
      .addClass("color-white");
  }

  // chip label remove
  $('.chip-delete').on('click', function() {
    $(this).closest('.chip').remove();
  });

  // Skeleton effect at each output recalculation
  const skeletonClass = 'skeleton-text skeleton-effect-fade';
  // When recalculation starts
  //$(document).on('shiny:outputinvalidated', function(e) {
  //  $('#' + e.target.id).addClass(skeletonClass)
  //});
  //// When calculation is over
  //$(document).on('shiny:value', function(e) {
  //  $('#' + e.target.id).removeClass(skeletonClass)
  //});

  Shiny.addCustomMessageHandler('add_skeleton', function(message) {
    var cl = 'skeleton-text skeleton-effect-' + message.effect
    $(message.target).addClass(cl);
    if (message.duration !== undefined) {
      setTimeout(function() {
        $(message.target).removeClass(cl);
      }, message.duration * 1000)
    } else {
      $(document).on('shiny:idle', function() {
        $(message.target).removeClass(cl);
      });
    }

  });
  // Skeleton preloader
  window.ran = false;
  if (app.params.skeletonsOnLoad) {
    const skeletonTargets = [".page-content", ".navbar", ".toolbar"];
    $(document).on('shiny:connected', function(event) {
      setTimeout(function() {
        if ($("html").hasClass('shiny-busy')) {
          for (target of skeletonTargets) {
            $(target).addClass(skeletonClass);
          }
        }
      }, 50);
    });
    $(document).on('shiny:idle', function(event){
      if(!window.ran) {
        for (target of skeletonTargets) {
          $(target).removeClass(skeletonClass);
        }
      }
      window.ran = true;
    });
  }

  // Classic preloader
  if (app.params.preloader) {
    const preloader = app.dialog.preloader();
    // Handle dark mode
    if (app.params.dark) {
      $(preloader.el).addClass("theme-dark");
    }
    $(document).on('shiny:idle', function(event){
      if(!window.ran){
        app.dialog.close();
      }
      window.ran = true;
    });
  }


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
    for (const property in app.store.state) {
      for (const e in app.store.state[property]) {
        if (e === message.id) {
          instanceFamily = property;
        }
      }
    }

    var oldInstance = app.store.state[instanceFamily][message.id];
    var oldConfig = oldInstance.params;
    var newConfig = app.utils.extend(oldConfig,  message.options);

    // Destroy old instance
    oldInstance.destroy();
    // Create new config
    var newInstance = app[instanceFamily].create(newConfig);
    // Update app data
    app.store.state[instanceFamily][message.id] = newInstance;
  });





  /**
  * Instantiate all widgets: gauges, swiper, searchbar
  */
  const uiWidgets = ["gauge", "swiper", "searchbar"];
  const serverWidgets = ["toast", "photoBrowser", "notification", "popup", "listIndex"];

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
        if (widget === "listIndex") {
          // We first insert the HTML before the page content div.
          $('<div class=\"list-index\" id=\"' + message.el + '\"></div>')
            .insertAfter($('.navbar'));
        }
        // Handle dark mode
        message.on = {
          open: function(target) {
            if (message.id !== undefined) Shiny.setInputValue(message.id, true);
            if (target.app.params.dark) {
              $(target.el).addClass("theme-dark");
            }
            shinyInputsReset();
          },
          close: function() {
            if (message.id !== undefined) Shiny.setInputValue(message.id, false)
          }
        };
        if (widget === "listIndex") {
          message.el = "#" + message.el;
          app[widget].create(message);
        } else {
          app[widget].create(message).open()
        }
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
      // Handle dark mode
      message.on = {
        open: function(target) {
          if (target.app.params.dark) {
            $(target.el).addClass("theme-dark");
          }
        }
      };
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
    if (app.store.state.popovers[message.targetEl] === undefined) {
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

        // Handle dark mode
        message.on = {
          open: function(target) {
            if (target.app.params.dark) {
              $(target.el).addClass("theme-dark");
            }
          }
        };

        // create instance
        var p = app.popover.create(message);
        // Open popover
        p.open();
        // Storage in app data (popovers array)
        app.store.state.popovers[message.targetEl] = p;
        }
    } else {
      // Only show if popover is enable for the current targetEl
      if (!$(message.targetEl).hasClass('popover-disabled')) {
        app.store.state.popovers[message.targetEl].open();
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
    if (app.store.state.tooltips[message.targetEl] === undefined) {
      // create instance
      var t = app.tooltip.create(message);
      // Open tooltip
      t.show();
      // Storage in app data (tooltips array)
      app.store.state.tooltips[message.targetEl] = t;
    }
  });

  Shiny.addCustomMessageHandler('update_tooltip', function(message) {
    if (app.store.state.tooltips[message.targetEl] !== undefined) {
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
          app.store.state.tooltips[message.targetEl] = cachedTooltip;
          // destroy current instance
          t.destroy();
        } else {
          // Parameters
          var pars = app.store.state.tooltips[message.targetEl].params;
          // recreate the tooltip based on the copy configuration
          t = app.tooltip.create(pars);
          app.store.state.tooltips[message.targetEl] = t;
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
    var dialog;
    switch (type) {
      case "alert":
        dialog = app.dialog.alert(text, message.title, message.on);
        break;
      case "confirm":
        dialog = app.dialog
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
        dialog =  app.dialog
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
        dialog = app.dialog
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
    // Handle dark mode
    if (app.params.dark) {
      $(dialog.el).addClass("theme-dark");
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
      // Handle when message.target is null
      var tabId;
      if (message.target === undefined) {
        tabId = $('#' + message.ns); // target the parent tabset
      } else {
        tabId = $('#' + message.ns + '-' + message.target);
      }

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
      } else {
        newTab = $(tab);
      }

      // Ignore position if target is not defined
      if (message.target === undefined) {
        // Insert tab content
        $(tabId).append(newTab);
        // Insert tab link in tabset toolbar
        $('.tabLinks .toolbar-inner').prepend(message.link);
      } else {
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
    if (app.store.state.actions[message.id] === undefined) {
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
        open: function(target) {
          if (target.app.params.dark) {
            $(target.el).addClass("theme-dark");
          }
        },
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
      app.store.state.actions[message.id] = a;

    } else {
      app.store.state.actions[message.id].open();
    }
  });


  Shiny.addCustomMessageHandler("update-action-sheet", function(message) {
    // Destroy old instance
    app.store.state.actions[message.id].destroy();
    // Create new config
    var a = app.actions.create(message);
    // Update app data
    app.store.state.actions[message.id] = a;
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

