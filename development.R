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
  data_joined <-  join_type(df_a, df_b,
                                 by = key_columns)
  return(data_joined)
}

#the below works well
execute_join(gapminder_africa, gapminder_full,
             join_type = left_join,
             key_columns = c('country' = 'country'
                             )
             )






#now need to test whether we can map columns with select()
key_a <- names(select(gapminder_africa, country))

key_b <- names(select(gapminder_full, country))

#first time unique key error received
execute_join(gapminder_africa, gapminder_full,
             join_type = left_join,
             key_columns = c(key_a = key_b))


#not picking up name of column for key...

names(gapminder_africa) == key_a
names(gapminder_full) == key_b









