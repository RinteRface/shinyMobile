// Import helper functions
import Framework7 from 'framework7/bundle'
import { setConfig } from './helpers/helpers-config.js';
import { initTheme } from './helpers/helpers-theme.js';
import { setPWA } from './helpers/helpers-pwa.js';
import { setCustomDisconnect } from './helpers/helpers-disconnect.js';
import { setStyles } from './helpers/helpers-styles.js';
import { shinyInputsReset } from './utils/shinyUtils.js';

let appInstance;

$( document ).ready(function() {
  let config = setConfig();
  // create app instance
  app = new Framework7(config);

  let mainView = app.views.get(".view-main");

  // Won't run on f7SingleLayout or f7TabLayout.
  // Only for f7MultiLayout.
  let hasRouter = $(".view-main").attr("data-browser-history") !== undefined;
  if (hasRouter) {
    // Required so that the first page is processed
    // by the router and we don't loose it's state when moving
    // to another page and moving back.
    mainView.router.navigate(
      window.location.pathname, 
      {reloadCurrent: true}
    );
    // Each time a page is mounted, we need to rebind all inputs ...
    // which triggers a warning but doesn't seem to break the app
    $(document).on("page:mounted", function(e) {
      shinyInputsReset();
    });
  }
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
