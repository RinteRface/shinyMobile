# shinyMobile <img src="man/figures/logo.png" width="200px" align="right"/>


> Develop outstanding {shiny} apps for iOS and Android, as well as beautiful {shiny} gadgets. {shinyMobile} is built on top of the latest [Framework7](https://framework7.io) template.

[![R build status](https://github.com/RinteRface/shinyMobile/workflows/R-CMD-check/badge.svg)](https://github.com/RinteRface/shinyMobile/actions)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-ff69b4.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![CRAN status](https://www.r-pkg.org/badges/version/shinyMobile)](https://cran.r-project.org/package=shinyMobile)
[![Codecov test coverage](https://codecov.io/gh/RinteRface/shinyMobile/branch/master/graph/badge.svg)](https://app.codecov.io/gh/RinteRface/shinyMobile?branch=master)


## Installation

```r
# from CRAN
install.packages("shinyMobile")

# for the latest version
devtools::install_github("RinteRface/shinyMobile")
```

## Demo

A running demo is available [here](https://shinylive.io/r/app/#h=0&code=NobwRAdghgtgpmAXGKAHVA6ASmANGAYwHsIAXOMpMAGwEsAjAJykYE8AKAZwAtaJWAlAB0IdJiw48+rALJF6tanGEQRAYgAEnIgFdGBOBphEAJjqWcRhgDwBaDRQButRiXhl2K1FFLcNdrVZOchgMADNFOHYhMDgAD1hUCwB6AHMoaiU2ZNIoek5kmNwNbwIAayhUwwBeDRipfjkFJRiVTjQkjhENDTpg8MjOaIgenu9fXG7RvgJqHRM4DBMXTg1agDEAQQAZAGUAUUmR0fHyRhHamOwiqZ7aVIgiRkWCKE4ajQAVLABVfamBEcemEdBACKRaCR2GEBBoQFpdPoohElBhxtx2OjijDitQiK9qGsHLCAL4iFTqLS8fgaDoiBqsTboYY9HS0IlhADsAAVKlFbrTMkQAO7cgDqmyJ3z+xSIqAhJFWtT6pHYJhYZSJWz2hw0KKUJi1OwOxVQzzxUAWjClv32gIFXM+eW2UFYulVAp6HXoLA5nKZqB9jBZo1DXPWSji0M5ACEoOV2LlGFVSABJQ2XMC5fJwUitbGcgBy8VVSZT6aJMWz7zzYAE9uOoeBnN2cBYBG4QfYtAzdTA73b3AAjEUNHw6BAPtLdUl43BuERqFbK2BPmwjIYSBpfIYACy+bd5ACErU9GgbTY3nHaVSDfpkcGvfLjwb4qB0ad7MRgrHgT9vLCjrOBgLkucDWpmD7-nA+Znt4k7UEqh6pNstDBCGl5cryCEYZeY5fmA8FwNQ2xwGEtZAnhPQQqQSgrqR5EaNhxE3I2eGcD2HwxEo5GsVR1HcHA8ArnQqTcBRZ6hjEMbUHksl8fxZFhHA4Irs8jhttQMSSeelGYTyUA4Tp1G0LRXFgFg9ziUxhksXgxlaJxalWRJbGXjuwmZuqjBlApVHSbJ9DyfZblNkpKmkCuxAaYw2mhT0KiXheTbQI4d61FyhZQGlLC4aGNF0ZmDJNJEflNpwOj0AV5lhE8Gi7NSrBlaG3BQC4E5Traenla1JgijaMo6TxpDMYStTTt1oaMC5o0DYcOkKKkVQQV8XU6aQzAQJw3jPGQRo6meyVhpy2xEKkfB5dMBF4udEC8lUzWjNVK4AJq6BozwZNQrDbtSmpujoGivCMqREBognPAA-I9wJEEQZwrp8vCrO84KQiMHEwOYPiPrSIxQB+glkLQrwKiMZr4o+nAYF8EMwfFY6rPGpA6F9P2PBoOjvNahmGt417Ck8hrqtmbyLExH4aMKrXkDFGgA1LhmRfQH46X1EAAOSRUo2WGEFhllCeIVUcELCkAA8qgFD7Sah2TRomjPNF4G-YYxB4taqAk2ULtvpLvOc6gIuGDu24lhoPrlKkrigiYZ6aO7dXxsQjDLBAqTfRgZ65KknAACScAQ03ypdPQxHn0KgmjUKwiADkNdIGCWiYADCXOkEQMBQTecAABK81k7BayWtiJ4wGvYlXZPsH+Pe1w5PQVxrahj9y3vgQAahkGsCBgBDXkPkdlNHugQCYo+Lk8E9XnPADcDkkgI9+qAzPQ1qmZDgY4GSV2C0-z6-UYS9aAwFSDvJupANpDyLkQa8Tx7h8GvhrQyJBfy6E4DvZ+-ENAkmKAAVgAAwEIpIA5IyRtxnQzoYWefII6+h9O8Q0W5Q4ED0LtWiP13hKHBHAQ02Z66NSbiYVu7dO7dz5P3M+g8taUKUOIgC49J5-3RjPKmfIAHYLuGEDQqjoJrGqLUDWHYfA7zhAvIBQ81A-hoQo8BPARSeCwZoxeQ8MAd0XEGNxzo+BlAwbvXgCxHHmJJA4RChg66ANDEvKxv41G2P8ZxIJkSLEazcXDagnjsyoQgL4uxC5hRJOcWSQBj8nGXlKTpOKSV7aOjyEMHSPYVzVlzDDPGICca9m1LbBmnBhS0CtnJTqg0GbZg-u+UgnB7bUTyDGUgW0pmHnoC3FgJhJnrW8cENZIy8ifBLAs0ZEBar7LyObHcjBLChUSqMI625TKFT7MVeQpUwAAkotzOWGUp4qL9qQWUH5xnFHeNedGACBSaB+Rob+dARbowFPId5UQImXihT2HG6xORjI-N2CA4yKyZnIHECiY5Dlg0zGKGWcAYqnlCii4O6LMUegZj8vFfZ+a9KFq0044ELh9mAAQ2wABOAAugAKlaeBVwK0Yjm1EOzHQMB6DgVWEkNs7wjaHQFI-EQYKKFLTojYvWLBEBUl0EuDQJBvoR0MMsTgslWC8KlkTc1IxQ4GtWPwti8Kv5wH2BpDwPy87NN+WY0KQKOIkALhQERwQxFxKiKQVgVsmmyLgPIuAQZRwBqDVcnoWqX6hk0FzF27wz4aEnMKG+fI4U5kYBpX1FBVQ-OAMAb8sToJBlsCWuOYAhVCuKEipsOgg5os5Gm+pTKCLWLjZYY2eEVSl1GFyNNC78rh1qAGqd7aWALNDNATyfYAAi2UeytPyom8yJbXLOMEpaF2kE40aF7m2K0p7F1wwRvevR6x33gVfdREsT7b1StXOHQDL7Z3YIJaQb98M719igxoGDZw-20m-kmFc4lSCoE4IgMhBATAQHCMweAgsfKcgwJCZIwF5yLitFRuAcolC2CHEQuILH+XkYAFaoFSFU-iOamwCYSpqkhBa9RQB9hQj6Kk4C0A0h9XmndK1VAuaGL1tbEVnj4LSnGLozjsEIUQoTZbYC4wCAQaIYAN4kw7rFPAfYABSRBuCqDrGePdNh7DtBgCq9gHnJkaCHKJwdw7yDorHQuxpmZN09xnQs+dDkl1xpXU9NdfY00oY80SDzO6nrnrUjJuTvCUPZR8L6TMmHsO4eSPhwjYRiNwFI2UcjlHqOgTo1bRjcBmOsfY4KjA3HeMvMAcZ4TlyRParYpoDa9xlp6jqjdPgAoZtLRdgET6aMNLsAHVNOAABHbF4zA11NzPovsxjawCbzWJxbGNvXWmMGYFobECTUDkE9-koUuSnVuq2DTjB7ZRb7Ld+6MEIPTAeE8OAH9TJzXtitubtQEe-rYsFno7ojscRGOtqN4FuR4lVEkeGXA+DFFsF7YoAAmEVXt6xwv+R+POxBVg47PnjgnmIOfM7JxTjQ1Pado-NQz0ggbw6s6tNyaa-qcWM6gwJjHjO2WkcNOLvHUvG0y5F0roW8vhei8JSwNs-h7C7Ql+rw7suSyG6gLrrDjPbWcWtKrxgku+Aa8x9C8CtuPeO6wIZKoxvpNs5d+bgNDurR+-TsoenduRfBDgOgNbJvcch7dxbuP5BE+MG94zjsKlNTO9d9Lo7efyg55F6X4+MdUCB9N2rtPAbK8nyHeXvOzBlhg0L6HzXbfLSQlbx3PVnmg9m4bz3wfVDW9cIirXlPRf3f2+IhFVvULZ-B-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-EntJlEbvtjDXLlmok4kwd9AbD4d-Ll4CbSb8dDMxmVr-hkVxE7JVo2NNrIx9iwop0QGATLbP15o9b-1ZYp2mYagZodbQGhpo4CbmhcwYOxmuwQQGAtqapqA7Ae+Z4AS3pPI3bQGiYLAKYK4g7G7EuBOqNyTjV3R+77O+pheHOFdpp7A5phl1BRm1bvNqAC4d9TAIo3MQtJzAzIuE+Sg3Ir7RAWrAH8MRAMY4B3MzLgk+6MQ3kvktN5jpsZ875k4nKgHSET+gCMQlWOGeGBGRGpmTWLWRAVGskIEtG4EyQ20TwEyPWlOu4bGBC9HzGA2L+3t2HkCVWeHdWDWRHFGJHbWFHjAVHdRn+nAdHDHLGzHlOrHMlWHYAOH1WtWBHJGTwzW-HpHc47WlH1HYnEnjHzHCZsnoj8pCL9Vz5GgD4-Vjb-TeTsuKaVnOguLI6jnB6-+fUEBlm7gOgQZyr6ZTbHhFAOgqYIQozhNxDdNYoxEhI6scA3xfnvNnAPsWBKN1L3VoU2mGQqK5Aem-1u4RCxChNuwyXuYzDc7JX0htgKoVxYQt6o4y7ZLYmqENDfACwcQYKXj8JE0JTmgLZzXaYbOUYOqV0IkAbtgrX8QzGZUvX0yyY-bfYagKo43g3tgfbc5vNMZeQxEc0w3AmaguCzqBgUBKTJQA1Umzw9Wj43AOqnX8R8oAOPXw3JQG00pRJgekjp1G0lJYAJtYKT3SjIl2zq6NjqL8eQ893jM1893r3sp3UM31E5jGQTFbFM3e3OCwWxSKgYAJIQqQAA).

## Progressive Web App (PWA)

### Configuration

`{shinyMobile}` is PWA capable, meaning that you can make sure your app uses the correct assets to be used as a PWA. This feature is automatically handled by `f7Page()` if `allowPWA` is `TRUE`. 

<br>

When set to `TRUE`, your app is set up to use both a `service-worker.js` script and a `manifest.webmanifest` file that you will provide.

<br>

To create these necessary assets for your PWA, you can use `{charpente}`:

```r
remotes::install_github("RinteRface/charpente")
library(charpente)
set_pwa(APP_PATH, ...)
```

Where `APP_PATH` is the app location. Currently, it only works if the app is **inside a package** like with [`{golem}`](https://github.com/ThinkR-open/golem). If your app is not in a package, you may copy the `www` folder of the [gallery app](https://github.com/RinteRface/shinyMobile/tree/master/inst/examples/gallery/www), which provides:

- A valid `service-worker.js`.
- A valid web manifest (`manifest-webmanifest`). Don't forget to change the `start_url` property to the path of your app.
For instance, the following app hosted at https://dgranjon.shinyapps.io/rstudio-global-2021-calendar/, has the `/rstudio-global-2021-calendar/` path.
- As a bonus a valid `offline.html` fallback, which is displayed when the app is offline.
- A valid set of icons. There are tools such as [appsco](https://appsco.pe/developer/splash-screens) and [app-manifest](https://app-manifest.firebaseapp.com), to create 
those custom icons and splash screens, if you need to.

It is really easier with `{charpente}`, the reason why we strongly recommend to develop your app inside a package.

<br>

But that's not all that's needed! When you set `allowPWA = TRUE` in `f7Page()`, the app will also attach the [Google PWA compatibility script](https://github.com/GoogleChromeLabs/pwacompat), called PWACompat, which will help with PWA compatibility. More specifically, PWACompat brings the Web App Manifest to non-compliant browsers for better PWAs. This mostly means creating splash screens and icons for Mobile Safari, as well as supporting IE/Edge's Pinned Sites feature. It basically assures that the `manifest.webmanifest` file has a wider support.

### Using your PWA

The first step is to deploy your app somewhere. It doesn't matter where (shinyapps.io, Posit Connect, your own server, etc.), but you will need a URL to access it.

<br>

Then, you can follow these steps to install your app on your mobile device.

<br> 
Copy the URL of your app in your mobile web browser (iOS: Safari and Andoid: Chrome). In this example this is: https://dgranjon.shinyapps.io/miniUI2Demo/. It opens like a classic web app, with top and bottom ugly navigation bars that are part of the browser UI.

- Select the share button located in the bottom bar of your iPhone/iPad For Android, you may do something similar. Importantly, Chrome for iOS does not support this feature, that's why we recommend using Safari.
- Click on "Add to Home Screen"
- Choose a relevant name and click on OK. 
- The app will be added to your iOS/Android Apps. In case you want custom icons, replace the content of the www folder with your own.

<div class="row">
<div class="card">
<a href="#" target="_blank"><img src="vignettes/figures/f7PWA.png"></a>
</div>
</div>

### Limitations
It is actually quite complex to guarantee that all mobile platforms are supported.
The PWA compatibility script will work in most cases. If not, please open an issue [here](https://github.com/GoogleChromeLabs/pwacompat/issues), to help improving it!

## Acknowledgement

A special thanks to [Vladimir Kharlampidi](https://github.com/nolimits4web) for creating this
amazing framework7 HTML template.

## Code of Conduct
  
  Please note that the shinyMobile project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
