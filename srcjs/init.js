// Import helper functions
import Framework7 from 'framework7/bundle'
import { setConfig } from './helpers/helpers-config.js';
import { initTheme } from './helpers/helpers-theme.js';
import { setPWA } from './helpers/helpers-pwa.js';
import { setCustomDisconnect } from './helpers/helpers-disconnect.js';
import { setStyles } from './helpers/helpers-styles.js';

let appInstance;

$( document ).ready(function() {
  let config = setConfig();
  // create app instance
  app = new Framework7(config);

  var mainView = app.views.get(".view-main");
  // Required to bind/unbind inputs
  // on page change
  mainView.router.on('routeChanged', function(newRoute, previousRoute, router) {
    Shiny.unbindAll();
    Shiny.initializeInputs();
    Shiny.bindAll();
  });
  // Set theme: dark mode, touch, filled, color, taphold css
  initTheme(config, app);
  // Set custom disconnect screen
  setCustomDisconnect(app);
  // PWA setup
  setPWA(app);
  // Set styles
  setStyles(app);
});

export function getAppInstance() {
  return app;
}
