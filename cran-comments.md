## Test environments
* local OS X install, R 3.6.1
* `rhub::check_for_cran()`
* Ubuntu 16.04.6 LTS (on travis-ci), R 3.6.1 (2017-01-27)
* win-builder (devel and release)

## R CMD check results
Remove V8 from package suggest to fix the Fedora issue (mail received from Prof Brian Ripley). The note raised [here](https://win-builder.r-project.org/incoming_pretest/shinyMobile_0.7.0_20200609_085042/Debian/00check.log) is a FALSE positive since no folder framework7-5.1.3 exists in the current version of the package. It is currently framework7-5.5.0
