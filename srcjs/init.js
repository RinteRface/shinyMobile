$(function() {
  // collect all data elements stored in body
  var config = $(document).find("script[data-for='app']");
  config = JSON.parse(config.html());

  // check if the app is intended to be a PWA
  var isPWA = $('body').attr('data-pwa') === "true";

  // always erase existing root value just in case the user changes the root.
  // This may be harmful
  config.root = "#app";

  // only register sw if the user wants to make a PWA and has a sw available
  if (isPWA) {
    config.serviceWorker = {
      path: window.location.pathname + "service-worker.js",
      scope: window.location.pathname
    };
  }

  // store app methods
  config.methods =  {
      toggleDarkTheme: function() {
        var self = this;
        var $html = self.$(".view-main");
        $html.toggleClass("theme-dark");
      }
    };

  config.data = function() {
    return {
      popovers: [],
      tooltips: [],
      actions: []
    };
  };

  // create app instance
  app = new Framework7(config);

  // init main view
  mainView = app.views.create(".view-main");

  // dark mode
  if (!config.hasOwnProperty("dark")) config.dark = false;
  if (config.dark) {
    app.methods.toggleDarkTheme();
  }

  // For mobile devices prevent text selection
  if (!app.device.desktop) {
    $("<style>")
      .prop("type", "text/css")
      .html(
        `-webkit-user-select: none;
         -khtml-user-select: none;
         -moz-user-select: none;
         -ms-user-select: none;
         user-select: none;
         -webkit-tap-highligth-color: transparent;
         -webkit-touch-callout: none;
        `
      )
      .appendTo("head");
  }

  // Set color theme
  if (config.hasOwnProperty("color")) {
    var colorCSS = app.utils.colorThemeCSSProperties(config.color);
    $("<style>")
      .prop("type", "text/css")
      .html(
        `:root {
        --f7-theme-color: ${colorCSS["--f7-theme-color"]};
        --f7-theme-color-rgb: ${colorCSS["--f7-theme-color-rgb"]};
        --f7-theme-color-shade: ${colorCSS["--f7-theme-color-shade"]};
        --f7-theme-color-tint: ${colorCSS["--f7-theme-color-tint"]};
      }`
      )
      .appendTo("head");
  }

  // Filled theme
  if (!config.hasOwnProperty("filled")) config.filled = false;
  if (config.filled) {
    var filledCSS = `
    :root,
    :root.theme-dark,
    :root .theme-dark {
      --f7-bars-bg-color: var(--f7-theme-color);
      --f7-bars-bg-color-rgb: var(--f7-theme-color-rgb);
      --f7-bars-translucent-opacity: 0.9;
      --f7-bars-text-color: #fff;
      --f7-bars-link-color: #fff;
      --f7-navbar-subtitle-text-color: rgba(255,255,255,0.85);
      --f7-bars-border-color: transparent;
      --f7-tabbar-link-active-color: #fff;
      --f7-tabbar-link-inactive-color: rgba(255,255,255,0.54);
      --f7-sheet-border-color: transparent;
      --f7-tabbar-link-active-border-color: #fff;
    }
    .appbar,
    .navbar,
    .toolbar,
    .subnavbar,
    .calendar-header,
    .calendar-footer {
      --f7-touch-ripple-color: var(--f7-touch-ripple-white);
      --f7-link-highlight-color: var(--f7-link-highlight-white);
      --f7-button-text-color: #fff;
      --f7-button-pressed-bg-color: rgba(255,255,255,0.1);
    }
    .navbar-large-transparent,
    .navbar-large.navbar-transparent {
      --f7-navbar-large-title-text-color: #000;

      --r: 0;
      --g: 122;
      --b: 255;
      --progress: var(--f7-navbar-large-collapse-progress);
      --f7-bars-link-color: rgb(
        calc(var(--r) + (255 - var(--r)) * var(--progress)),
        calc(var(--g) + (255 - var(--g)) * var(--progress)),
        calc(var(--b) + (255 - var(--b)) * var(--progress))
      );
    }
    .theme-dark .navbar-large-transparent,
    .theme-dark .navbar-large.navbar-transparent {
      --f7-navbar-large-title-text-color: #fff;
  }`;

    $("<style>")
      .prop("type", "text/css")
      .html(`${filledCSS}`)
      .appendTo("head");
  }

  // trick to fix the photo browser link issue
  // we set the body class that will contain the color.
  // We then recover this class in a variable in the app.js code
  $("body").addClass(config.color);
  $("body").attr("filled", config.filled);

  // Provide custom install prompt
  if (isPWA) {
    // Create custom install UI
    var installToast = app.toast.create({
      position: 'center',
      text: '<button id="install-button" class="toast-button button color-green">Install</button>',
    });

    var deferredPrompt;
    // Handle install event
    $(window).on('beforeinstallprompt', (e) => {
      // Prevent Chrome 67 and earlier from automatically showing the prompt
      e.preventDefault();
      // Stash the event so it can be triggered later.
      deferredPrompt = e.originalEvent;
      // Show install trigger
      installToast.open();
    });

    // Installation must be done by a user gesture!
    // close toast whenever a choice is made ... Give time
    // to the toast to be created before event registration.
    app.utils.nextTick(function() {
      $('#install-button').on('click', function() {
        // close install toast
        installToast.close();
        if (!deferredPrompt) {
          // The deferred prompt isn't available.
          return;
        }
        // Show the install prompt.
        deferredPrompt.prompt();
        // Log the result
        deferredPrompt.userChoice.then((result) => {
          console.log('👍', 'userChoice', result);
          // Reset the deferred prompt variable, since
          // prompt() can only be called once.
          deferredPrompt = null;
        });
      });
    }, 500);
  }

});

