apastylr
--------
[![Build Status](https://travis-ci.org/cedricbatailler/apastylr.svg?branch=master)](https://travis-ci.org/cedricbatailler/apastylr) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/apastylr)]

Many psychology journals request articles to adopt an APA-norm result reporting. `apastylr` eases the R to articles step by creating a list of linear model coefficients which is is APA formatted.

## Installation

`apastylr` has not been  submitted on CRAN yet because of the few functions it adds (namely, one) and because of its status (namely, experimental). The latest version can be found on GitHub and can be installed using `devtools`:

``` r
library(devtools)
devtools::install_github("cedricbatailler/apastylr")
```

## Example

`apastylr()` can be used the following way to produce APA formatted results:

``` r
library(apastylr)

model <- lm(Score ~ 1)
apastylr(model)

#>          Term                    APA
#> 1 (Intercept) t(34) = 1.13, p = .265
```
