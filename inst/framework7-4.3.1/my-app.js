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
  var dark_mode = $('body').hasClass('theme-dark');
  if (dark_mode) {
    $('.page-content').css('background-color', '');
    $('.page-content.tab').css('background-color', '');
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
    var notif = app.notification.create({
      icon: '<i class="f7-icons">bolt_fill</i>',
      title: ' ' + message.title,
      titleRightText: ' ' + message.titleRightText,
      subtitle: ' ' + message.subtitle,
      text: ' ' + message.text,
      closeTimeout: ' ' + message.closeTimeout,
      closeButton: ' ' + message.closeButton,
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
    var toast = app.toast.create({
      text: message.text,
      position: message.position,
      closeButton: message.closeButton,
      closeButtonText: message.closeButtonText,
      closeButtonColor: message.closeButtonColor,
    });
    // Open Notifications
    toast.open();
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

});
