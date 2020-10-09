# hold dependencies for ui.R & server.R
library(shiny, quietly = TRUE)
library(dplyr, quietly = TRUE)
library(DT, quietly = TRUE)
library(shinythemes, quietly = TRUE)

# load_cache --------------------------------------------------------------
gapminder_full <- readRDS("cache/gapminder.rds")
gapminder_africa <- readRDS("cache/gapminder_africa.rds")

#list the data available at this point
.available_data <- objects(sorted = TRUE, all.names = FALSE)

# Create a named list of all the dataframes available
# set names of all slots to their object names
.listed_data <- setNames(
  list(gapminder_africa, gapminder_full),
  .available_data)



# source functions
source('func/functions.R')


.join_list <- list(left_join =  left_join,
                  right_join = right_join,
                  inner_join = inner_join,
                  semi_join = semi_join,
                  full_join = full_join,
                  anti_join = anti_join)