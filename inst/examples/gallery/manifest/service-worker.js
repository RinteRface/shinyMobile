// Import Workbox (https://developers.google.com/web/tools/workbox/)
importScripts('https://storage.googleapis.com/workbox-cdn/releases/3.6.3/workbox-sw.js');

/*
  Precache Manifest
Change revision as soon as file content changed
*/
  self.__precacheManifest = [
    //{
    //  revision: '1',
    //  url: 'framework7/css/framework7.bundle.min.css'
    //},
    //{
    //  revision: '1',
    //  url: 'framework7/js/framework7.bundle.min.js'
    //},
    //{
    //  revision: '1',
    //  url: 'css/app.css'
    //},
    //{
    //  revision: '1',
    //  url: 'css/icons.css'
    //},
    //{
    //  revision: '1',
    //  url: 'js/routes.js'
    //},
    //{
    //  revision: '1',
    //  url: 'js/app.js'
    //},
    //// Fonts
    //{
    //  revision: '1',
    //  url: 'fonts/Framework7Icons-Regular.woff2'
    //},
    //{
    //  revision: '1',
    //  url: 'fonts/Framework7Icons-Regular.woff'
    //},
    //{
    //  revision: '1',
    //  url: 'fonts/Framework7Icons-Regular.eot'
    //},
    //{
    //  revision: '1',
    //  url: 'fonts/Framework7Icons-Regular.ttf'
    //},
    //{
    //  revision: '1',
    //  url: 'fonts/MaterialIcons-Regular.woff2'
    //},
    //{
    //  revision: '1',
    //  url: 'fonts/MaterialIcons-Regular.woff'
    //},
    //{
    //  revision: '1',
    //  url: 'fonts/MaterialIcons-Regular.ttf'
    //},
    //{
    //  revision: '1',
    //  url: 'fonts/MaterialIcons-Regular.eot'
    //},
    // HTML
    {
      revision: '1',
      url: './'
    },
    // Icons
    {
      revision: '1',
      url: 'assets/icons/128x128.png'
    },
    {
      revision: '1',
      url: 'assets/icons/144x144.png'
    },
    {
      revision: '1',
      url: 'assets/icons/152x152.png'
    },
    {
      revision: '1',
      url: 'assets/icons/192x192.png'
    },
    {
      revision: '1',
      url: 'assets/icons/256x256.png'
    },
    {
      revision: '1',
      url: 'assets/icons/512x512.png'
    },
    {
      revision: '1',
      url: 'assets/icons/favicon.png'
    },
    {
      revision: '1',
      url: 'assets/icons/apple-touch-icon.png'
    },
    ];

/*
  Enable precaching
It is better to comment next line during development
*/
  workbox.precaching.precacheAndRoute(self.__precacheManifest || []);
