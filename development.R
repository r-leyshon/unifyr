#Function of script - import data, functions, execute joins

library(tidyverse, quietly = TRUE)

# import_data -------------------------------------------------------------

gapminder_full <- readRDS("cache/gapminder.rds")

gapminder_africa <- readRDS("cache/gapminder_africa.rds")


# join_function -----------------------------------------------------------

# execute_join <- function(df_a, df_b, join_type) {
#   data_joined <-  join_type(df_a, df_b)
#   return(data_joined)
# }



# function specifying key --------------------------------------------------



execute_join <- function(df_a, df_b, join_type, key_columns) {
  # set key_columns names to values provided by user
  names(key_columns) <- key_columns
  # perform join
  data_joined <-  join_type(df_a, df_b,
                                 by = key_columns)
  print(paste('Joining on',
              paste(names(key_columns), collapse = ', ')
              ))
  return(data_joined)
}

#the below works well
execute_join(gapminder_africa, gapminder_full,
             join_type = left_join,
             key_columns = c('country' = 'country',
                             'year' = 'year'
                             )
             )

#now need to test whether we can map columns with select()
key_a <- names(select(gapminder_africa, year, continent))

key_b <- names(select(gapminder_full, year, continent))

#first time unique key error received
execute_join(gapminder_africa, gapminder_full,
             join_type = left_join,
             key_columns = c(key_a = key_b))


# excellent. Now need to figure how I can create these vectors of key names
# from shiny ui interaction
# could use names subsetting, but would rather have users click on columns

key_a <- names(gapminder_africa)[c(1,2)]

#specify keys for join execution
key_b <- names(gapminder_full)[c(1,2)]


all_keys <- c(key_a =  key_b)


execute_join(gapminder_africa, gapminder_full, left_join, all_keys)

# this all seems to work fine,
# ideas for error handling once functional - selecting columns that cannot match
# selecting differing numbers of columns
# also data type conversions

# so what is the issue?
# Need to check the indices that come out of the DT column selection, are they 
# correct? 

# Failing this, it could be a reactive environment issue, investigate:
# server / client side calculation of column indices
# various reactive functions / observers


