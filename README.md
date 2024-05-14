<!-- README.md is generated from README.Rmd. Please edit that file -->
easteRme
========

The goal of easteRme is to ... tell you when Easter is! (Or Carnaval and/or Corpus Christi.)

Example
-------

Yes, now this common dilemma can be solved with the magic of R. No more wandering in desolate ignorance for you, my fRiend! With `easteRme`, you can simply let R do the 'hard' work for you. Why, we can even see when Easter will fall in 2032:

``` r
remotes::install_github("RobertMyles/easteRme")
library(easteRme)

easteR_me(year = 2032)
#> # A tibble: 1 x 2
#>    Year     Easter
#>   <chr>     <dttm>
#> 1  2032 2032-03-28
```

Phew! Anxiety over. Problem solved.
