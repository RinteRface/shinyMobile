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

A running demo is available [here](https://shinylive.io/r/app/#h=0&code=NobwRAdghgtgpmAXGKAHVA6ASmANGAYwHsIAXOMpMAdzgCMAnRRAVwhiLdIAoAdMAPQsAzgwEAbAJZ0BWCdIZQGATwHCAFpIjKAskTqTxcfgEpeEWo2ZbhpKOPF8IAAmf8NW3fsPG851wxwqETCzgC8zgR8YOqkpKjCiAICDFrkDABmUARwGADmkqTqLHQYkkQpaXCZ2XAAtNRQwjB1BIoQAqbmZhDmUoxKytwe2j39iirDmtp6BkY95gDEzsKcDDnOHAAmLEbC5nDOADx1zhQAbpIMJPBk3D2oUEXHp8LKtnAwGBk+0XAAHrBUHsBHl7EYVAI7HRhJ08M5HgQANZQPKHCLuaZeOa+HrCNDAob+ZxSWzfHzCJyuVyPIq4YmuLQEcQsLa5LZXUIRABiAEEADIAZQAovSXNTaekXBiwNh+GLqc5JHkIERAhgCE10c4ACpYACqwuJJgVzgybAIpHKEG4GRMzhADJWaxytp8GFp6m4ntwZpNJKImvE4TOPVcAF9uuZzASAPpEVBWkihE4kyS2KnOIqfbX8cr7PzirZKJEhvWG00-BxwLYhvlC0XE1CBcREKBshhlg2N8XEVudmWLAAMQ4A7FAMhl5cToOc6EoQ6SeE7NGyAPIQAAKqLggraRAcXYrTpgWwAwhR0jrCkYj0bxT0FhBliNlM4CeZX7z0JmWJIQxko7bmimauOCRDUJuADqvJ3qargJkmEBcu+6Dxom1rCPBZqjjqUB0PyUDKJwy7ioqVqkLeMqvrMPjOAA4uC1TKNOZHUvAwj4mi84DjhOhwJxO4AEJKNwWioCwpAAJK1jKMDKBxXH0EorGKmp6kaZpNLiLU6gHh2Ib8PxgloqY2E0lAEBwOIKF2Hk-LpqRmmAduVmOE66mSLJbhgI8bn8nAGSkKpWkUVRPkBUFziudZIWacIXm5mARhBXFGmAUJrbItEsF+dZzjUIU6gIiIxWBRkcCWmZHlqS5lnWfxEAsKBWk2HApBwTV6kkVIVmdWxmnLPqwiHIUnyhE0Wb4c4s7Kk81rOCQ4gsQN6VAfV4hSeQMAtVpU10AAcrASXQiNpB1FJEASaQBbmaFN5JZd137bdXUaZIxDSjhUmfdEOkMGiBBXMycCxlW4ixkD6xGNVq2adkVrnNq5b3ntrgmm9ip1W5W2fLtoX4Ud8CGWAp3tXUfJCa9cMaWFSVCZJpDJi9aV7R9JAAaOP0kH9SiA8DRhg4YENQyDXQ04qYZaRjEtnJOlUdTKEkaKzamIZhi6OcMhWoMj3ZS+pMvOetbn4+RD0k1gyqxNFG2q4qCVsiTqR5LE9vUoBWDtuUZtqeJkkyST2bwO7io6XQ+Uyjq6g5qH1IEHpH0CSGUT8Ke8o+fmsNoys1kKzWIZxuryYACTB8YstG1pnve0QvuKv70nefwxYMEiceuOHkc+XobId5Eic5ChqdgK37fwvwUiu8FYBV3tI1GJaBcRJIFU2XA3BFxhpdj76Lclhnk-WzPBsaXPa1exydeY9SjeBzKfZqv3XfBjKZ4Hk-hY5wnRBJyhaKkG5KOd+-ZKTn3innJezdfKpBgIMfgN9wFqXKgrEmGRWzzQgHkOOxdkKawzMIHWetDSn0ljVJBs4eKcyOnOUSb06Ykxot4W8jFqwqHduoKAVxerEJ7JpFKpAYqv11N2O6ARj5CLvOQu6gF+REAKDaN6XkSatgUcBXwYiswWxlAATU4M4QI4I3xFC0KWYiLBIiWWcHkIgzgY6BAAPzuwyEQIg6QSbR3TLnS0C0EowF2E8ZOVioCSRjmQD680ObNkDAJYQGBdT2IrppLxCMWBGJmrYkQ1R3wQFrI8Ti1A1S1mLNCLU8TNySQKpw8gSNOzmIKpZDqdBJJvS2CQAA5B1IwUAkbODoDpCASIACE7tbBKFIGuXWX16wimkTVZYgRiC1KzDHSIH9OyoA+kibJjccm1hYKgEphxsxZgBE07ISI8jXDYFseZaz+zvgIMQBgHIsHLQwDVOywgS7CDaJIRMvt+Al1tBaJC9wHQ30FFiDA7ZzwiCZjAYySkAASlktgQm4J0s5rR1ntN9OaCAPieaKR3PaR0stXDAvaYsR+DBNxbOqAANXsO0kwGpOKYvnMiK5nBck4v7HizYsTSUAG4b7hhMGK3ostkhZnkXkW8JK0R9IXPOEatYOYnIICwBggQyDLVzovcgtZoSQuhbCs88KiCIuFWiVFuSMWdPlUYJFO4eKCoJUSm0Sq4BkpvoyDIzhuA+vCGECI7SE5PFZRCil1IqWLHkj691bKNAQXuFKnOlLMUYCZgeHiOb8IOUGcIVlGBVwb0lf65w4YzjrxjZm5w8bE22uUgwUt5b01Vqze0nNrjxD5uhEWpEJaU16WoJ22NkZZYSozRpGdb0EGrSQYBPCMJfbKJlGTGemjLKSDgcausAoRSaMIf8uA+Fwoo00dCJ6kksL0PwkJUgyFr34TPEoLY96aaDscl+zS0IdRnNfXQS6LjgNrmzAwfYS6nRSyriNBgyyIierBY3X0JFrq+hGpxa0frpWKmWAco5KzY5sX0AhpGwokZ3EbmXGO8BfTKlVIES6hQ4L1rUkRwJQDvyoF9rglCS564keJivK6kk6Okc0qQ5wp8JXRjYoRw5gTNhED7mRmE1RKPUZ4LR3eSoVRqjgKxxWIiKwccVFx8gPGfxvQE-gpyWkx4hlXtZEaYlxOkBLs5sNPkx4Zyvc4GZwoZPo3IU6eT+HqRKeI7Sp05GtNwCo5eDz10S60sY4ZljEA2MREC+S9SVm4A2b43Z7eeCIhCZvrSlznn0vrLejJuTT4CNKk884c49gvKRKiwhTTiGN4FbUp1qQRygG3t055++PlyD-G3W1lxJMoLVLgLU8W6kRvdes1zTz66pvQPyYQop7tJTVC+vwYAQ46gAE4AC6AAqd21Rri8X4BuA1TUYARygwibpI0RlgHC2xSLTplhMzyAqw4IaeKIBWHpXYGqIAGojs4DkwgdLKALtQMJi0XAnJ9aEU1GmKNJZ06liTW7fRDYdrE60PyKBwtsNa11IFSDKF1kHZ1cAWetozrRrdMnsMJRIPT3Jlqmc2pMhvNnHPN1c8FOe9Y6geJ87qwLiLLXovOCyZ2EauSZpwGoEKqX8X+vaZS43YAwA04KRbTxOoevblgFu7dqnNUitAJ55SJR0Dm1S+pvwrWN9AI8+E64WbpnaN+6UjxTRipoCiZ8gAER6V5fuMukp6+3VWmO7Zskyh584ZF56Oz9xcW4-PPcW1BdcekdPZzi959e2AQDc2i8l+qPXub3Ja+V-4BHmvFeGD9x6U8BcMpYjxESMkAgWwIDfEUPAQpbdRxlAqMCXS+lqgCF1gmIwdQACMI5-hH6u6vgAVqgbBgPK6NaB4qEHimzRQG2XKgxlU4CSF6e0NpMBjdKWg0VASwG24Gp1vggE2yOUInSG4AAFYRwhwZME9k5UwR5GUPomZh8J4wAAApIgdQXoWeGqZAl4FYIEIwbgZArCZwA-TXSzZTbbL3ddX3W3f3d2KrWWEPFtMPU5NvAvFtfuEgiIZAuPakDPZ2D-L-GsEfTrOwZvSfBIJIAQWfefDIRfQ3NUJEVfcoHfHSHIPScQDsHfOAPfeoU-E-EcG7DAS-a-RBO-GDYHOg5wMHF2NETsFxTsVRLQJ0UgVw7JVMQxHxJGUAmqQIAAR3Jy8y3VDR8kjRPg11BwDAUVzgG07G2F2CSQ9lHDkQUQV1SPxg3R8i8K3B3FViYyMxM36nUl8OVDcJDBqIh07zYicIwwkwShcACIZ2qE3FbB4GBDcWGC0F9DqE2V9AACZnB7sERJATBT5WivNiAUxTg9UOweiBj+ieBFjhjRjnAJipjNlZiFMgDJI0sB9OjclujUgaM1czk5iTiJNDtl9axzjVirjJs0tHiik7j4gKczklBz1SCVjLi0hIiy4-jDFvi0t0dEpOwXjgTrioTRtqgJtIS2ikSGAvYsFDg4S6U3jQToSOxMS0QUT4t7ivMPh0B-DliujcSQTaMKTdYGBUSFiY5kRASaTNw8TaME5KokRmT0tWTLlrlUB2SLjaSESJMeTuVhT+SpShTOBUAJicTOS6S6s5SeUDkxj+TFAr5RTXjVS0sdTyhtTa4lTqSxSVSJSvMjSiAtTSSfioiuc9T4T3iKcud+SF5UFlSuS6tPTLQPS4EGBSASkoBnSGBV0KCaowDFRc8thg1SBNQoNgBfQR4YAr9VcoTAybprJ-QthrgRSeQj1hRbsZNww7prhqAqCpFmj7S0sjkRswzLTXSvN5IjlNlkRqh+SQkmZiA0yjAal7BGyfS0t5JuzAxrVgR2pfUjjqQdJ0BlpuAD9EAD8xj8VQVrQxI8NuoySrd8lyAhxohAhbolQTAXcwzW8+imh9zogGY4gSA+c94wAlRQgMzJJdyry4ADz+A6Bn0+dTySzmtayHiGVENBycSLzQT5J2ztkmSgKFj1l6UOyGBmVgxvSDSJN5JaVoLqgS4Y5-gnCXwGcSN7k1RpikK2tnomZnAcDBRTcSdksrSS5ML1lsKGA3dVohc6dHdxcEVQ9xDN1sU4t4QQ0xMRzlAsKQLcKARALpVEjggJJUA4KS55KDl34yBLwhz0KvMVLUALyWizdScLc1cudNwEwDl2L1IXIzLSsaZCj+AdKD93YGEC83wfgoMOodLnFRxMpAwkRhNSswBTKFLLEXBlZioTlLhDc+k4Bpgth4khI3w2QshdgOo2NOFQgUFLRccDVscKAq12l8QKo6h-ioA6g2pzomZUB2lnzVNAgVkrEAAvaoWxMSNcQUM0XYGyNoOACgAqZSdARaTsSQNqtZF5IgTrVCVAMwWeUQldM5SI6bey6yi8-uNSF+EmIKg5NZdSsgVaxUEbFgJKTxUILxeSM0TkDy6y30KSFYWgJQAHJBfa6oecK0GAC8tcMk6IHStS8gXaogmmJrBI3rRaAyhi5s5S6yg-Cyv2QNUE6I3zfgTahIUwCzNSHSwUOwUgEQUg1eINWjBy+0fgBMCgaQp8tzQ4fgZkEIUmt6FdNsDMG+YIBKJCTnRSr+UKM5EMPcjeRG6y58jOdGzGkQULWTGqKdB-AiuHHqjy3opSjQaWtYjqZU3okI1aTQDMBgZjHaekmOdqNcGEQ4xwmcvreisnfneXXW0gaG+gsbUcKFaWsSaBeW9qRy-6iW425wjJK0H4TUJCQA2cgkBcpcgAZjXMJVQy3LVlBrNs83fI+C-LABsQOjcVXj-Jd2tr9k+hxthv-AAFJc7diYjEDvpfpvyDxSAhYHAUbybnADp9R+R+QPasZRxk7vbhMB8BLbA452Yvoe7RDnKEQPzohW7V4IkkI-zRDhASgB7+BYIp6fyHo446YrZp4LyXN7D1JIt3bgblgk9JB7B5F-bXBlhVRvax7MInQ5zCRFzEBQ6Orw6NyZjUaTbEswbIi47rz+AbE96D7r9GN-yM6G4c6YjaDn7apRwf7VEeCZ6wBIH5EtFKINEq0O6fJjqargkIQOoORf7F09oRaa0a7caxIYitSwHm64G8geC7LCASA3KYAKH09tFk997VEEGYZ2a9p+LYjaGrgYAu9TN+A0GUkXBPo6HUcWH5FcHpY3oCG60iH-xfNg7I7jYKGqGDtrg0zSAGGOH7pEGSYKG2GkHY0uH7KNHEx+GPF1b0GEQzGsGJHbDb8aZxa1It7qRH8gDo6jK0tRHeGKHAGcIdR6aeAUHuacpMGKLKl0xEBXz4KIA6GKHDbt6lLolNGjywz9QpJVbPIc64kmoHBQSUnEwEnlHwGfLkRrxEHuAYGzwpA2SOZsHWHmk7yXBg71sXGaoMosokQKmKCB78bbGEmga5KExxrqgj6QbTavGHiRnalbymYIB-HYUgEgrRmGBmCSZ5LVm5n7ydGgDytBMtZPpfqBGW8rGUkcJtnCDAajad65UrzxngDzdGKmYrz-G6arzfYmbCgFoZQ6A3EEUnLOaZQbrYB3w7myRnBhQnghUAd783HJaEZfFLa6LX6Y60sbFeQvV7b2o3nRxMWkJsXHN1IrlCir0fcSZEWSBXbNEmn5mDmGbZYOCc4UH+AR6faet+4e7OZuZFEwAtAXFs40YasIg66G7EFRCmW0YWXYH7HOWs7kMuZS7kpj5ml+1K7xBBW9phXa767G7HHpM4WIx9LJnGLKWIAD9YxaWSB-H5G6szWLWrXpQIhQHoysi2X26gWfI9ELFmQGVEdiK3LbA+lGYdnRCuWFWeXog-nxAK7wZNXaYmHWWU72Xx7dm1Jl7j416ZRVRqApHDYxba0RolQc67WvUHWQ2nXdiSnyH7HhNqGzXCXtH+7E2wAamtkhU38dILRipQzAmryAd+72ckofGGA+G03yJPX+BvXIhantl-WTkRpPpaxHW821JSyhnidUWpnySiF8XrRLWK2bWS2oTd2vUD3mmQHq23Xk2PW+CvX9FfWOz53VlA2mkK3u75WS6eYy6Y31X43qiW22Xz7Q2b4M3V7J3IAIJV2yFVpZGi3bWT2z092SBz35mSGr3XBAJVGb562sXLam3QOW2222TiYqKu3CUe3dQgmB3QOh2SYR2x3+6IPp3H253cdiLF2SBl332b8DXYON2PGTXwaG38P7HcW+2MwQmh7Z7wndkomYmS4RPpbimBOtcisbH5EjzQgVdN2Bs37aMisr8oawGPcgJrgrlYlHaNm8hqWOt7BDras0tDObOZLEj1OwQWBTJdOnnwaisPO0RjPXXTPGJPON5qH5J-O4BbODrtQDOGC4BIvaDVPj6zh-g-JaxEzaxWnvPDLGKbF30Xl-HTOCu4zqHMvWm3b4WPawcnTshnkr5gbHncvwaMWnkilrQiv4ueM2uXkNzyWZQ6v2uqXRlIED1nXDXq1Jb1O8oNWcv9O6sbEhFOvbahErOlYNpIp4ibnEjT1d8Wk5u0W2iiE2XcX3X6EIPyAu7x2lRP3AJI2f3Y3hZ-2xDAPk3gPCCT1p6W256vvEGnKHoV7Ygs2fIc3oPRbtuDvt2fld3MHcXsPv0W2DG6ZAW73BGzmJoXB7Bqg7GcHeO13kuJmt3GLdu4BkOIBCXcWyfCXfYSXvIyXbKnbT3U2aWK36WiWNJJXOGIOgPfbrQ5WOYI2lX+WiBnv1JtXRW9W8GJWg9jGIOCPY1w2v3eWp5YhVW6A-2Zqq1xfdW7CAaJv3GtdmxrI2wOwHnPHiex05Em9-HU1qBlmWwTfqgqm+Z2oSZFgjeMFVjZb4RtXvyWRcQapBR3gMB0ceq+M7S1bEp7fjem9neAZXfBwPfHe6VveZLjiHTlKHem9FbGyVbXX1aeBNa1QdpT9EmqvbnUA9IqLGAIIEMUW9PDvHSIcjBNwq+iBcXW+3EiAhIKyENfZy4SZ-NruTGwAxlckD6rITs2-h5hN+AFDp9lC58F9jpl8tC19dDN9DDt9hBgggzhBD8hwxiAAWCw4-w-aw9M671wOfuIRQmfJftQlfzQ7Q9fPQmKrfMQHftUG6A-4-0-o-uoGMQv5-0b4N-KfEoRULL8l8z-dfhvn0If81Au-H-kfj-4oCABwdYAWDzCwOEkmT+RqCIHr4+c4aXOfAct24yjh8BSefMm0krLRBbgLAV2q50h6MV6BuMGAIFw6Yt0b20rKCNZGDBtIrID1Ani+G2T9l7yOXLJn7AgJdYoCgSNZkfwQIyZAIgoUQe1G-ayhhAqg+ZnUCXCHwwAWQPuPCAj64DWsOoQIKtkkCG4lKvhHqpFSNzgV5qrrfnOYLsHCDdQF6TIghDJJlwPB6TTJq6xXQeD4yiZYQMACXIH5YCuAEsm4IkiHgqKgQNQgJHUCJEmu83D4r4QzqLBEiNIXwhjSeDY1UwCHB4r4UJpgAdmoObIThHh6tYJ2d7UJu0kTBDUS0voRoXkKxrCBz4ywciHRwG6YNV2XQ8Hq1lcZToegYAcMLdiAA).

## Sponsors

`{shinyMobile}` is supported/funded by [AthlyticZ](https://linktr.ee/athlyticz).

<img src="man/figures/DARKathlyticzlogoArtboard1.png" style="display: block; margin-left: auto; margin-right: auto; width: 25%;">

AthlyticZ offers top notch Shiny courses developed by [Veerle van Leemput](https://hypebright.nl/):

- Productionizing Shiny Applications [course](https://athlyticz.com/shiny-ii).
- Outstanding InterfaceZ with Shiny [course](https://athlyticz.com/shiny-iii).
- Build outstanding mobile applications with shiny [course](https://athlyticz.com/shiny-mobile).

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
