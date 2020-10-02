# Unifyr v1.2

## Introduction

Unifyr is an educational application, helping learners to develop an intuition for the different types of join available within Dplyr. The app is built with Shiny and is currently hosted on [shinyapps.io](https://richleysh84.shinyapps.io/UnifyR/).

## Changelog

### Version 1.2

* Include dimensions of each df as an output
* Change sequence of interface to step 3 = select key columns

### Version 1.1

* Table outputs changed to DT
* Column selection enabled
* Selected columns specify the keys to perform join on
* .gitignore updated to include reprex folder

### Version 1.0

* .gitignore added
* 2 DataFrames available, full gapminder and gapminder_africa (subset of former)
* Dropdown selection of join type to perform
* Output dataframe executed based on a natural join - when both DFs have a common key
* Both input DFs and output DF visualised with head

## Known Issues

* nest_join is not compatible with the join function used
* selecting uneven column names causes an error in rendered table output
* Removal of visual clutter around DT::datatable not working

## To do

* Upload own datasets to perform joins
* Output joined df to file
* include a run button and pause join execution until ready
* Improve UI -
  * improve appearance of DT output
  * shinyhelper guidance
  * shinyhelper gif animations
* Separate app.R to ui.R & server.R