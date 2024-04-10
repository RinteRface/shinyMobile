// Style for touch plugin
const setTouchStyle = config => {
  if (config.hasOwnProperty("touch")) {
    if (config.touch.tapHold) {
      $("<style>")
        .prop("type", "text/css")
        .html(
          `
            -moz-user-select: none;
            -webkit-user-select: none;
            user-select: none;`
        )
        .appendTo("head");
    }
  }
};

// Set dark mode
const setDarkMode = (config, app) => {
  if (!config.hasOwnProperty("dark")) config.dark = "auto";
  app.setDarkMode(config.dark);
};

// Filled theme
const setFilledStyle = config => {
  if (!config.hasOwnProperty("filled")) config.filled = false;
  if (config.filled) {
    var filledCSS = `
    :root,
    :root.dark,
    :root .dark {
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
    .dark .navbar-large-transparent,
    .dark .navbar-large.navbar-transparent {
      --f7-navbar-large-title-text-color: #fff;
  }`;

    $("<style>")
      .prop("type", "text/css")
      .html(`${filledCSS}`)
      .appendTo("head");
  }

};

export const initTheme = (config, app) => {
  setTouchStyle(config);
  setDarkMode(config, app);
  setFilledStyle(config);
  app.setColorTheme(config.color);
};

