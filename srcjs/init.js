// Import helper functions
import Framework7 from 'framework7/bundle'
import { setConfig } from './helpers/helpers-config.js';
import { initTheme } from './helpers/helpers-theme.js';
import { setPWA } from './helpers/helpers-pwa.js';
import { setCustomDisconnect } from './helpers/helpers-disconnect.js';
import { setStyles } from './helpers/helpers-styles.js';
import { shinyInputsReset } from './utils/shinyUtils.js';

$( document ).ready(function() {
  let config = setConfig();
  // create app instance
  app = new Framework7(config);

  let mainView = app.views.get(".view-main");

  // Won't run on f7SingleLayout or f7TabLayout.
  // Only for f7MultiLayout.
  let hasRouter = $(".view-main").attr("data-browser-history") !== undefined;
  if (hasRouter) {
    // Remove content of the first page
    // to prevent shiny from binding any input
    // Because we reload the page content via the router, it will
    // be reincluded automatically. This avoids duplicated
    // binding warning and broken app. We also save the toolbar
    // as we reinject it once the session is loaded.
    let mainToolbar = $(".toolbar-main");
    let viewContent = $(".view-main").children();
    viewContent.remove();

    // Re-include global toolbar if there was one ...
    // the toolbar-main class is given by the f7MultiLayout
    // whenever a global toolbar is passed (as opposed to local
    // pages toolbars)
    if (mainToolbar.length > 0) {
      $(document).on('shiny:sessioninitialized', function() {
        $(".view-main").append(mainToolbar);
      });
    }
    // Required so that the first page is processed
    // by the router and we don't loose it's state when moving
    // to another page and moving back.
    mainView.router.navigate(
      window.location.pathname,
      // Doc -> reloadCurrent: true:
      // replace the current page with the new one from route,
      // no animation in this case
      {reloadCurrent: true}
    );

    // For some reasons, the navbars get duplicated entries.
    // We remove the first one.
    $(document).on('shiny:sessioninitialized', function() {
      if ($(".navbars").children().length > 1) {
        $(".navbars").children()[0].remove();
      }
    });

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

// attach Framework7 to the window object
// allows usage in browser at later stage (e.g. for offline PWA page)
window.Framework7 = Framework7;

