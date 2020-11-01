# server script for unifyr

# load dependencies
source("run.R")

# Define server logic
server <- function(input, output, session) {
  

  # df_a --------------------------------------------------------------------
# generate df_a ame for use in dynmic title
  output$df_a_title <- renderText({paste("Head of Data 1:", input$df_a)})
  # generate df for selection 1
  df_a_full <- reactive({
    a <- data.frame(listed_data[[input$df_a]])
    return(a)
  })

  # df_b --------------------------------------------------------------------
  # generate df_a ame for use in dynmic title
  output$df_b_title <- renderText({paste("Head of Data 2:", input$df_b)})
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



# dynamic shinyhelper for join --------------------------------------------

  
# observe changes made by user selection
  observeEvent(
    # look for changes within the specified input
    input$join_type, {
      output$dynamic_helper <- renderUI({
        helper(
        tags$h3("Step 2. Select a join type to execute."),
        type = "markdown",
        size = "l",
        colour = "#ce3487",
        content = input$join_type)
        
})# end of render UI
      })# end of observe event
  
  

  # render previews ---------------------------------------------------------

  # render the heads for display
  output$table_a_head <- renderDT(head(df_a_full(), input$n1),
    selection = list(target = "column"),
    # remove visual clutter
    options = list(dom = "t")
  )

  output$table_b_head <- renderDT(head(df_b_full(), input$n2),
    selection = list(target = "column"),
    # remove visual clutter
    options = list(dom = "t")
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


  # generate output df name for use in dynamic title
  output$joined_title <- renderText({paste("Head of Output Data:",
                                           input$df_a,
                                           paste0(input$join_type, "ed to "),
                                           input$df_b)})
  
  # render the joined df head
  output$table_out <- renderDT({
    DT::datatable(head(joined_df(), input$n3),
      rownames = FALSE,
      # remove visual clutter
      options = list(dom = "t")
    )
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


# shinyhelper -------------------------------------------------------------

# provide UI modals with route to shinyhelper directory
observe_helpers(help_dir = "shinyhelper_dir")

} # End of server
