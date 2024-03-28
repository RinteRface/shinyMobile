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
  // init main view
  mainView = app.views.create('.view-main');
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
