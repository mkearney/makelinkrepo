
<!-- README.md is generated from README.Rmd. Please edit that file -->

# makelinkrepo

> 🔗🔗 Create link repositories and share them on Github

## Installation

You can install the released version of makelinkrepo from Github with:

``` r
remotes::install_github("mkearney/makelinkrepo")
```

## Example

Create a test link repo.

``` r
## load pkg
library(makelinkrepo)

## vector of links
links <- c("https://testingtesting.com?q=test&n=500", 
    "http://test.org#test")

## repo name
repo_name <- "linkrepotest"

## make link repo
linkrepo(links, repo_name)
```

See the [example repo here](https://github.com/mkearney/linkrepotest).
