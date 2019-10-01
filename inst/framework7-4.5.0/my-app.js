$(function () {
  // handles shinyapps.io
  var workerId = $('base').attr('href');
  // ensure that this code does not locally
  if (typeof workerId != "undefined") {
    var pathname = window.location.pathname;
    var newpath = pathname + workerId;
    window.history.replaceState( {} , 'newpath', newpath);
  }

  // handle background for dark mode
  // need to remove the custom gainsboro color background
  var dark_mode = $('html').hasClass('theme-dark');
  if (dark_mode) {
    $('.page-content').css('background-color', '');
    $('.page-content.tab').css('background-color', '');
    $('.demo-facebook-card .card-footer').css('background-color', '#1c1c1d');
    $('.sheet-modal, .swipe-handler').css('background-color', '#1c1c1d');

    // below the sidebar id #f7-sidebar-view ensures that we do not
    // screw up the classic f7Panel style in dark mode
    // The sidebar background has to be slightly lighter than the main background
    var sidebarPanel = $('#f7-sidebar-view').find('.page-content');
    $(sidebarPanel).css('background-color', '#1e1e1e');
    // we also need to darken sidebar items in the sidebar menu
    // the default color does not contrast enough with the
    // new sidebar background
    var sidebarItems = $('#f7-sidebar-view').find('li');
    $(sidebarItems).css('background-color', '#171717');
  } else {
    $('div.messages').css('background-color', 'gainsboro');
  }


      // allow for subnavbar. If a subnavbar if provided in the navbar
      // add a custom class to the page so that the subnavbar is rendered
  var subnavbar = $('.subnavbar');
  if (subnavbar.length == 1) {
   $('.page').addClass('page-with-subnavbar');
  }


  // set up notifications
  // for now, it only works for 1 notification at a time
  Shiny.addCustomMessageHandler("notif", function(message) {

    // properly treat Booleans get from R
    // R returns strings containing 'true' or 'false'
    var closeButton = (message.closeButton == 'true');
    var closeOnClick = (message.closeOnClick == 'true');
    var swipeToClose = (message.swipeToClose == 'true');

    // create the HTML icon
    var icon;
    if (message.icon !== undefined) {
      icon = '<i class="' +
    message.icon.attribs.class +'">' +
    message.icon.children[0] + '</i>';
    } else {
      icon = undefined;
    }

    var notif = app.notification.create({
      icon: icon,
      title: message.title,
      titleRightText: message.titleRightText,
      subtitle: message.subtitle,
      text: message.text,
      closeTimeout: parseInt(message.closeTimeout),
      closeOnClick: closeOnClick,
      swipeToClose: swipeToClose,
      closeButton: closeButton
    });
    // Open Notifications
    notif.open();
  });

  // set up popovers
  popoverIds = [];
  getAllPopoverIds = function() {
    //In data-popover attribute we specify CSS selector of popover we need to open
    $('[data-popover]').each(function() {
      popoverIds.push($(this).attr("data-popover"));
    });
  };

  // call the function ...
  getAllPopoverIds();

  popoverIds.forEach(function(index) {
    Shiny.addCustomMessageHandler(index, function(message) {
      var popover = app.popover.create({
        targetEl: '[data-popover = "' + index + '"]',
        content: '<div class="popover">'+
                 '<div class="popover-inner">'+
                 '<div class="block">'+
                  message.content +
                '</div>'+
                '</div>'+
                '</div>',
        // Events
        on: {
          open: function (popover) {
            console.log('Popover open');
          },
          opened: function (popover) {
            console.log('Popover opened');
          },
        }
      });
      $('[data-popover = "' + index + '"]').on('click', function() {
        popover.open();
      });
    });
  });


  // handle toasts
  Shiny.addCustomMessageHandler("toast", function(message) {

    // properly treat Booleans get from R
    // R returns strings containing 'true' or 'false'
    var closeButton = (message.closeButton == 'true');

    var toast = app.toast.create({
      text: message.text,
      position: message.position,
      closeButton: closeButton,
      closeTimeout: parseInt(message.closeTimeout),
      closeButtonText: message.closeButtonText,
      closeButtonColor: message.closeButtonColor
    });
    // Open Notifications
    toast.open();
  });



  // handle dialog
  Shiny.addCustomMessageHandler("dialog", function(message) {

    var type = message.type;
    switch (type) {
      case 'alert':
        var dialog = app.dialog.alert(message.text, message.title);
        break;
      case 'confirm':
        var confirm = app.dialog.confirm(
          text = message.text,
          title = message.title,
          callbackOk = function() {
            Shiny.setInputValue(message.id, true);
          },
          callbackCancel = function() {
            Shiny.setInputValue(message.id, false);
          }
        ).open(Shiny.setInputValue(message.id, null));
        //confirm.closed(Shiny.setInputValue(message.id, null));
        break;
      case 'prompt':
        var prompt = app.dialog.prompt(
          text = message.text,
          title = message.title,
          callbackOk = function(value) {
            Shiny.setInputValue(message.id, value);
          },
          callbackCancel = function() {
            Shiny.setInputValue(message.id, null);
          }
        ).open(Shiny.setInputValue(message.id, null));
        break;
      case 'login':
        console.log(login);
        var login = app.dialog.login(
          text = message.text,
          title = message.title,
          callbackOk = function (username, password) {
            Shiny.setInputValue(message.id, {user: username, password: password});
          },
          callbackCancel = function() {
            Shiny.setInputValue(message.id, null);
          }
        ).open(Shiny.setInputValue(message.id, null));
        break;
      default:
        console.log('');
    }
  });



  // handle update f7Tabs
  tabsIds = [];
  getAllTabsIds = function() {
    $('.tabs').each(function() {
      tabsIds.push($(this).attr('id'));
    });
  };

  // call the function ...
  getAllTabsIds();

  tabsIds.forEach(function(index) {
    Shiny.addCustomMessageHandler(index, function(message) {
      app.tab.show('#' + message.selected);
    });
  });


  // handle taphold events
  Shiny.addCustomMessageHandler('tap-hold', function(message) {
    $(message.target).on('taphold', function() {
      message.callback;
    });
  });

});
