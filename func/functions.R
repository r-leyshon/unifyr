'Purpose of script:
Location for custom functions used within app.R server
'

# define function to execute join
.execute_join <- function(df_a, df_b, join_type, key_columns_a, key_columns_b) {
  # set key_columns names to values provided by user
  names(key_columns_b) <- key_columns_a
  # perform join
  data_joined <-  join_type(df_a, df_b,
                            by = key_columns_b)
  print(paste('Joining on',
              paste(names(key_columns_b), collapse = ', ')
  ))
  return(data_joined)
}