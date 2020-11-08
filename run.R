# hold dependencies for ui.R & server.R
library(shiny, quietly = TRUE)
library(dplyr, quietly = TRUE)
library(DT, quietly = TRUE)
library(shinythemes, quietly = TRUE)
library(shinyhelper, quietly = TRUE)
library(cicerone)

# create environment for dataframes
df_env <- new.env()

# load_cache --------------------------------------------------------------
df_env$gapminder_full <- readRDS("cache/gapminder.rds")
df_env$gapminder_africa <- readRDS("cache/gapminder_africa.rds")
df_env$gapminder_zimbabwe <- readRDS("cache/gapminder_zimbabwe.rds")

# list the data available at this point
available_data <- objects(name = df_env, sorted = TRUE, all.names = FALSE)



# list all dataframes loaded ----------------------------------------------

# Create a named list of all the dataframes available
# set names of all slots to their object names
listed_data <- setNames(
list(df_env$gapminder_africa,
     df_env$gapminder_full,
     df_env$gapminder_zimbabwe),
available_data)


# import functions --------------------------------------------------------

# source functions
source("func/functions.R")


# joins available for user selection --------------------------------------

join_list <- list(
  left_join = left_join,
  right_join = right_join,
  inner_join = inner_join,
  semi_join = semi_join,
  full_join = full_join,
  anti_join = anti_join
)

# guide to application use using cicerone ---------------------------------

guide <- Cicerone$
  new()$ 
  step(
    el = "step1",
    title = "Select data to join.",
    description = "Here you can decide which of the available dataframes to
    join."
  )$
  step(
    el = "step2",
    title = "Select a join type to execute.",
    description = "Here you specify which of the dplyr join functions to
    execute."
  )$
  step(
    el = "optional",
    title = "Select Key Columns.",
    description = "In this step you can click on the dataframe columns to
    specify which to use as keys in the join. Multiple columns may be selected
    and the order of selection matters."
  )$
  step(
    el = "nrow1",
    title = "Number of rows to display.",
    description = "Here you can increase or decrease the number of rows to 
    show in the tables. This does not affect the data used to execute the join.
    ",
    tab = "Input DFs",
    tab_id = "tabz"
  )$
  step(
    el = "lhs",
    title = "Left hand side input data.",
    description = "Here a table of the first selected input data are 
    displayed.",
    tab = "Input DFs",
    tab_id = "tabz"
  )$
  step(
    el = "deets_lhs",
    title = "Left hand side details",
    description = "Here, details of the first selected input data are displayed,
     including number of rows, columns and column names.",
    tab = "Input DFs",
    tab_id = "tabz"
  )$
  step(
    el = "rhs",
    title = "Right hand side input data.",
    description = "Here, a table of the second selected input data are 
    displayed.",
    tab = "Input DFs",
    tab_id = "tabz"
  )$
  step(
    el = "deets_rhs",
    title = "Right hand side details",
    description = "Here, details of the second selected input data are 
    displayed, including number of rows, columns and column names.",
    tab = "Input DFs",
    tab_id = "tabz"
  )$
  step(
    el = "output_preview",
    title = "Output data.",
    description = "By clicking on the 'Output DF' tab, you can view the head
    of the output DataFrame created by the function parameters you previously
    selected.",
    tab = "Output DF",
    tab_id = "tabz"
  )