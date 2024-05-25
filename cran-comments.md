## Test environments
* Local R-4.4.0.
* `rhub::check_for_cran()`.
* win-builder (devel and release).

## R CMD check results
There were no ERRORs or WARNINGs or NOTEs.

## Reverse dependencies

This release slightly affects `{LFApp}` with 2 deprecation warnings. Authors have been contacted and a pull request has been submited: https://github.com/fpaskali/LFApp/pull/8.

*   checking whether package ‘LFApp’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: The `hairlines` argument of `f7Block()` is deprecated as of shinyMobile 2.0.0.
      Warning: The `multiCollapse` argument of `f7Accordion()` is deprecated as of shinyMobile
    See ‘/Users/davidgranjon/david/RinteRface/shinyMobile/revdep/checks.noindex/LFApp/new/LFApp.Rcheck/00install.out’ for details.
    ```

