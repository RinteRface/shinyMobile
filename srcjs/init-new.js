// Import helper functions
import Framework7 from 'framework7/bundle'
import { setConfig } from './helpers/helpers-config.js';
import { initTheme } from './helpers/helpers-theme.js';
import { setPWA } from './helpers/helpers-pwa.js';
import { setCustomDisconnect } from './helpers/helpers-disconnect.js';

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

  app.notification.create({
    text: 'Hello, how are you?',
    on: {
      opened: function () {
        console.log('Notification opened');
      }
    }
  }).open();

  // equivalent to setTimeout ...
  app.utils.nextTick(function() {
    app.notification.create({
      text: 'You look great!'
    }).open();
  }, 2000);

  // taphold test
  $('#mybutton').on('taphold', function () {
    app.dialog.alert('Tap hold fired!');
  });
});
