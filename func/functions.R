'Purpose of script:
Location for custom functions used within app.R server
'

# function to execute join
execute_join <- function(df_a, df_b, join_type) {
  data_joined <-  join_type(df_a, df_b)
  return(data_joined)
}

