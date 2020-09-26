# Unifyr v1.0

## Introduction

Unifyr is an educational application, helping learners to develop an intuition for the different types of join available within Dplyr. The app is built with Shiny and is currently hosted on [shinyapps.io](https://richleysh84.shinyapps.io/UnifyR/).

## Changelog

### Version 1.0

* .gitignore added
* 2 DataFrames available, full gapminder and gapminder_africa (subset of former)
* Dropdown selection of join type to perform
* Output dataframe executed based on a natural join - when both DFs have a common key
* Both input DFs and output DF visualised with head

## Known Issues

* nest_join is not compatible with the join function used

## To do

* Allow user to select which columns to use as keys (multiple cols)
* Include dimensions of each df as an output
* Upload own datasets to perform joins
* Output joined df to file
* include a run button and pause join execution until ready
* Improve UI -
  * Wellpanels
  * shinyhelper guidance
  * shinyhelper gif animations
* Separate app.R to ui.R & server.R