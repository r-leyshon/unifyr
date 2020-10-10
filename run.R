# hold dependencies for ui.R & server.R
library(shiny, quietly = TRUE)
library(dplyr, quietly = TRUE)
library(DT, quietly = TRUE)
library(shinythemes, quietly = TRUE)

# create environment for dataframes
df_env <- new.env()

# load_cache --------------------------------------------------------------
df_env$gapminder_full <- readRDS("cache/gapminder.rds")
df_env$gapminder_africa <- readRDS("cache/gapminder_africa.rds")
df_env$gapminder_zimbabwe <- readRDS("cache/gapminder_zimbabwe.rds")

# list the data available at this point
available_data <- objects(name = df_env, sorted = TRUE, all.names = FALSE)


# Create a named list of all the dataframes available
# set names of all slots to their object names
listed_data <- setNames(
list(df_env$gapminder_africa,
     df_env$gapminder_full,
     df_env$gapminder_zimbabwe),
available_data)



# source functions
source("func/functions.R")


join_list <- list(
  left_join = left_join,
  right_join = right_join,
  inner_join = inner_join,
  semi_join = semi_join,
  full_join = full_join,
  anti_join = anti_join
)
