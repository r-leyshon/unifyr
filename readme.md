# Unifyr

## Introduction

Unifyr is an educational application, helping learners to develop an intuition for the different types of join available within Dplyr. The app is built with Shiny and is currently hosted on [shinyapps.io](https://richleysh84.shinyapps.io/UnifyR/).

## Changelog

### Version 1.4

**Backend**
* lintr styling applied to code
* dataframes moved to separate environment df_env
* available_data adjusted to ignore objects other than dataframes

### Version 1.3

**Frontend**
* App converted to sidebar layout with tabsets in main panel
* Heads of DFs now rendered within renderDT calls
**Backend**
* Separate app.R to ui.R & server.R. Dependencies sourced from run.R


### Version 1.2

**Frontend**
* Include dimensions of each df as an output
* Change sequence of interface to step 3 = select key columns

### Version 1.1

**Frontend**
* Table outputs changed to DT
* Column selection enabled
* Selected columns specify the keys to perform join on
**Backend**
* .gitignore updated to include reprex folder

### Version 1.0

**Frontend**
* 2 DataFrames available, full gapminder and gapminder_africa (subset of former)
* Dropdown selection of join type to perform
* Both input DFs and output DF visualised with head
**Backend**
* .gitignore added
* Output dataframe executed based on a natural join - when both DFs have a common key


## Known Issues

* nest_join is not compatible with the join function used
* selecting uneven column names causes an error in rendered table output
* Removal of visual clutter around DT::datatable not working

## To do

* Include row number selectors for all head functions
* Upload own datasets to perform joins
* Output joined df to file
* include a run button and pause join execution until ready
* Dynamic df titles, head of gaminder_africa etc
* Improve UI -
  * improve appearance of DT output
  * shinyhelper guidance
  * shinyhelper gif animations