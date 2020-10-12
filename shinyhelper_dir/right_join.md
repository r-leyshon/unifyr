### Step 2: Selected Right Join


***

The join type that you select will determine which function ```dplyr``` will use to execute the join between the data that you selected in step 1. 

There are several joins to choose from and they all have their specific uses.

***
### Right Join

All rows from y, and all columns from x and y. Rows in y with no match in x will have NA values in the new columns.

![Right join animation](../www/right-join.gif)

[Source gadenbuie GitHub](https://github.com/gadenbuie/tidyexplain)