# shinyMobile <img src="man/figures/logo.png" width="200px" align="right"/>


> Develop outstanding {shiny} apps for iOS, Android, desktop as well as beautiful {shiny} gadgets. {shinyMobile} is built on top of the latest [Framework7](https://framework7.io) template.

<!-- badges: start -->
[![Build Status](https://travis-ci.org/RinteRface/shinyMobile.svg?branch=master)](https://travis-ci.org/RinteRface/shinyMobile)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/RinteRface/shinyMobile?branch=master&svg=true)](https://ci.appveyor.com/project/RinteRface/shinyMobile)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-ff69b4.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Project Status](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![CRAN status](https://www.r-pkg.org/badges/version/shinyMobile)](https://cran.r-project.org/package=shinyMobile)
<!-- badges: end -->



## Installation

```r
# from CRAN
install.packages("shinyMobile")
# for the latest version
devtools::install_github("RinteRface/shinyMobile")
```


## Cheatsheet

<a href="https://github.com/RinteRface/cheatsheets/tree/master/shinyMobile"><img src="https://raw.githubusercontent.com/rinterface/cheatsheets/master/shinyMobile/png/shinyMobile1.png" width="630" height="487" style="max-width:100%;"></a>


## Demo

A running demo is available here : https://dgranjon.shinyapps.io/miniUI2Demo/. Left side: android demo, right side: iOS demo


![](man/figures/demo.png)



## Progressive Web App (PWA)

### Configuration

shinyMobile is PWA capable, meaning that it can be displayed full screen on many mobile
devices. This feature is automatically handled by `f7Page()` and the Google PWA compatibility
[script](https://github.com/GoogleChromeLabs/pwacompat). The last 3 parameters of `f7Page()`
are not mandatory. If not provided, the app will use shinyMobile default ressources to create an apple-touch-icon, a manifest and a favicon. The PWA compatibility script will automatically create any missing icons and splash screens for iOS and Android devices.


Below is an example showing the manifest.json file:

```javascript
{
  "name": "My App",
  "short_name": "My App",
  "description": "My App",
  "lang": "en-US",
  "start_url": "https://dgranjon.shinyapps.io/miniUI2Demo/",
  "display": "standalone",
  "icons": [
    {
      "src": "icons/128x128.png",
      "sizes": "128x128",
      "type": "image/png"
    },
    {
      "src": "icons/144x144.png",
      "sizes": "144x144",
      "type": "image/png"
    },
    {
      "src": "icons/152x152.png",
      "sizes": "152x152",
      "type": "image/png"
    },
    {
      "src": "icons/192x192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "icons/256x256.png",
      "sizes": "256x256",
      "type": "image/png"
    },
    {
      "src": "icons/512x512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
```

Be sure to replace the `start_url` with your own url. Also, add a custom name, even though this can be modified later when adding the PWA to your IOS apps. shinyMobile has an helper to create the manifest, that is
`create_manifest`. FInally, there are tools such as [appsco](https://appsco.pe/developer/splash-screens) and [app-manifest](https://app-manifest.firebaseapp.com), to create 
those custom icons and splash screens, if you need to.


### Add the PWA to your desktop Apps

Copy the url of your app in your mobile web browser (iOS: Safari and Andoid: Chrome). In this example this is: https://dgranjon.shinyapps.io/miniUI2Demo/. It opens like a classic web app, with top and bottom ugly navigation bars.

- Select the share button located in the bottom bar of your Iphone/Ipad. For Android,
you may do something similar. Importantly, Chrome for iOS does not support this feature, that's why I recommend using Safari.
- Click on "Add to Home Screen"
- Choose a relevant name and click on OK. 
- The app will be added to your IOS/Android Apps. In case you want custom icons, replace the content of the www folder with your own.

<div class="row">
<div class="card">
<a href="#" target="_blank"><img src="man/figures/f7PWA.png"></a>
</div>
</div>

### Limitations
It is actually quite complex to guarantee that all mobile platforms are supported.
The PWA compatibility script will work in most of the case. If not, please open an issue [here](https://github.com/GoogleChromeLabs/pwacompat/issues), to help improving it!


## Acknowledgement

A special thanks to [Vladimir Kharlampidi](https://github.com/nolimits4web) for creating this
amazing framework7 HTML template.
