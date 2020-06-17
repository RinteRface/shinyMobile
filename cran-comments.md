## Test environments
* local OS X install, R 3.6.1
* `rhub::check_for_cran()`
* Ubuntu 16.04.6 LTS (on travis-ci), R 3.6.1 (2017-01-27)
* win-builder (devel and release)

## R CMD check results
This version 0.7.0 fixes:
  - 1 ERROR from CRAN check: Remove V8 from package suggest to fix the Fedora issue (mail received from Prof Brian Ripley).  
  - 1 NOTE from the previous version 0.1.0: installed package size.
