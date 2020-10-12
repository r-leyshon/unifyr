### Column Names

***

The column names of the dataframe presented above are shown here. 

If you have duplicate column names on either side of the join and have not specified to use them as key columns, ```dplyr``` functions will preserve both columns in the output and prefix the column names with *x.* or *y.* to identify which side that column originated.

Good column names in R are referred to as **standard** names. They should not have spaces or certain special characters within them. 

The CRAN package ```janitor``` can be used to automate the standardisation of column names, try using the function ```clean_names()``` and check out the [janitor CRAN documentation here](https://cran.r-project.org/web/packages/janitor/vignettes/janitor.html).

