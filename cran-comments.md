## Test environments
* local OS X install, R 3.6.1
* Ubuntu 16.04.6 LTS (on travis-ci), R 3.6.1 (2017-01-27)
* win-builder (devel and release)

## R CMD check results
Regarding the [NOTE](https://www.r-project.org/nosvn/R.check/r-patched-solaris-x86/shinyMobile-00check.html), the pkg size has been reduced (remove png from documentation as well as icons in the inst/ folder). This should fix the NOTE.
