## Test environments
* RStudio Workbench, R-4.2.1.
* `rhub::check_for_cran()`.
* win-builder (devel and release).

## R CMD check results
There were no ERRORs or WARNINGs or NOTEs.

## Note
This is a re-submission: 
Reverse dependency LFApp appears to be broken, which was not initially 
captured by revdepcheck package during the first submission. A pull request was proposed: https://github.com/fpaskali/LFApp/pull/4 to fix the issue. However the package does
not seem active anymore since about 2 years and the authors did not answer my mail.
