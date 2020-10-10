# server script for unifyr

# load dependencies
source("run.R")

# Define server logic
server <- function(input, output, session) {

  # df_a --------------------------------------------------------------------

  # generate df for selection 1
  df_a_full <- reactive({
    a <- data.frame(listed_data[[input$df_a]])
    return(a)
  })

  # df_b --------------------------------------------------------------------

  # generate df for selection 2
  df_b_full <- reactive({
    b <- data.frame(listed_data[[input$df_b]])
    return(b)
  })

# select_join to use----------------------------------------------------------

  join_function <- reactive({
    joining_with <- join_list[[input$join_type]]
    return(joining_with)
  })



  # render previews ---------------------------------------------------------

  # render the heads for display
  output$table_a_head <- renderDT(head(df_a_full()),
    selection = list(target = "column")
  )

  output$table_b_head <- renderDT(head(df_b_full()),
    selection = list(target = "column")
  )



  # generate key column names -----------------------------------------------

  # specify keys for join execution
  key_a <- reactive({
    names(df_a_full())[as.numeric(input$table_a_head_columns_selected)]
  })
  # render prints of the columns selected by user
  output$table_a_userselected <- renderPrint({
    key_a()
  })

  # specify keys for join execution
  key_b <- reactive({
    names(df_b_full())[as.numeric(input$table_b_head_columns_selected)]
  })
  # render prints of the columns selected by user
  output$table_b_userselected <- renderPrint({
    key_b()
  })


  # join the data -----------------------------------------------------------

  joined_df <- reactive({
    .execute_join(df_a_full(),
      df_b_full(),
      join_function(),
      key_columns_a = key_a(),
      key_columns_b = key_b()
    )
  })

  # render the joined df ----------------------------------------------------

  # render the joined df head
  output$table_out <- renderDT({
    DT::datatable(head(joined_df(),
      rownames = FALSE,
      # remove visual clutter
      options = list(dom = "t")
    ))
  })




  # table a summaries ---------------------------------------------------------

  output$dimensions_a <- renderPrint({
    paste(
      "Dimensions =",
      paste(dim(df_a_full()),
        collapse = " x "
      )
    )
  })

  output$colnames_a <- renderPrint({
    paste(
      "Column names =",
      paste(names(df_a_full()),
        collapse = ", "
      )
    )
  })


  # table b summaries  ------------------------------------------------------

  output$dimensions_b <- renderPrint({
    paste(
      "Dimensions =",
      paste(dim(df_b_full()),
        collapse = " x "
      )
    )
  })

  output$colnames_b <- renderPrint({
    paste(
      "Column names =",
      paste(names(df_b_full()),
        collapse = ", "
      )
    )
  })


  # output table summaries  -------------------------------------------------

  output$dimensions_output <- renderPrint({
    paste(
      "Dimensions =",
      paste(dim(joined_df()),
        collapse = " x "
      )
    )
  })

  output$colnames_output <- renderPrint({
    paste(
      "Column names =",
      paste(names(joined_df()),
        collapse = ", "
      )
    )
  })


} # End of server
