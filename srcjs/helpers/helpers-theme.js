
// Style for touch plugin
const setTouchStyle = (config) => {
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
    if (!config.hasOwnProperty('dark')) config.darkMode = false;
    app.setDarkMode(config.dark);
  };

  export const initTheme = (config, app) => {
    setTouchStyle(config);
    setDarkMode(config, app);
    app.setColorTheme(config.color);
  };
