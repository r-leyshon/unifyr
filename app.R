library(shiny, quietly = TRUE)
library(dplyr, quietly = TRUE)
library(DT, quietly = TRUE)
library(shinythemes, quietly = TRUE)

# source functions
source('func/functions.R')

# load_cache --------------------------------------------------------------
gapminder_full <- readRDS("cache/gapminder.rds")
gapminder_africa <- readRDS("cache/gapminder_africa.rds")

#list the data available at this point
available_data <- objects()

listed_data <- list(gapminder_africa = gapminder_africa,
                    gapminder_full = gapminder_full)


join_list <- list(left_join =  left_join,
                  right_join = right_join,
                  inner_join = inner_join,
                  semi_join = semi_join,
                  full_join = full_join,
                  anti_join = anti_join)


# UI ----------------------------------------------------------------------


# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("readable"),

    # Application title
    titlePanel("unifyR v1.2"),

wellPanel( 
fluidRow(
    column(width = 12,
tags$h1('Step 1. Select datasets to join.')),


# 1. dataframe selectors -----------------------------------------------------

column(width = 6,
       selectInput("df_a",
                   "Select First Dataset:",
                   available_data,
                   selected = "gapminder_africa")),

column(width = 6,
       selectInput("df_b",
                   "Select Second Dataset:",
                   available_data,
                   selected = "gapminder_full"))
)
),
tags$hr(),

# data heads --------------------------------------------------------------

fluidRow(
    #LHS
    column(width = 6, h3("Head of data 1"), DTOutput(outputId = 'table_a_head'),
           verbatimTextOutput('dimensions_a'),
           verbatimTextOutput('colnames_a')
           ),
    
    #RHS
    column(width = 6, h3("Head of data 2"), DTOutput('table_b_head'),
           verbatimTextOutput('dimensions_b'),
           verbatimTextOutput('colnames_b')
    ),

    tags$hr(),
    
    
# 2. select a join type ------------------------------------------------------

#specify join

fluidRow(

column(width = 12,
       tags$h1('Step 2. Select a join type to execute.')),


column(width = 12,
       selectInput("join_type",
                   "Select the type of join to perform:",
                   c('left_join', 'right_join', 'inner_join',
                     'semi_join', 'full_join', 'anti_join'),
                   selected = "left_join"))
),

tags$hr(),
# 3. select columns to join by --------------------------------------------

column(width = 12,
       tags$h1('Step 3 (optional). Select columns to join by.'),
       tags$h3('Choose the columns by clicking on the tables at the top 
               of the app')),
tags$hr(),
# display selected key column names
fluidRow(
  #LHS
  column(width = 6, h5("L.H.S. selected column(s)"), 
         verbatimTextOutput('table_a_userselected')),
  
  #RHS
  column(width = 6, h5("R.H.S. selected column(s)"), 
         verbatimTextOutput('table_b_userselected'))
),
tags$hr(),
# 4. view the output ---------------------------------------------------------

#output view
column(width = 12,
       tags$h1('Step 4. View the output data.')),

fluidRow(
    column(width = 12, h3("Head of output data"), DTOutput('tableOut')),
    verbatimTextOutput('dimensions_output'),
    verbatimTextOutput('colnames_output')
)


)#end of fluid page
)

# server ------------------------------------------------------------------

# Define server logic 
server <- function(input, output, session) {

# df_a --------------------------------------------------------------------

  #generate df for selection 1  
    df_a_full <- reactive({
        a <- data.frame(listed_data[[input$df_a]])
        return(a)
    })
    #generate head for display
    df_a_head <- reactive({
        a_head <- head(df_a_full())
        return(a_head)
        })
    

# df_b --------------------------------------------------------------------

    #generate df for selection 2
    df_b_full <- reactive({
        b <- data.frame(listed_data[[input$df_b]])
        return(b)
    })
#generate head for display
    df_b_head <- reactive({
        b_head <- head(df_b_full())
        return(b_head)
        })
    

# select_join -------------------------------------------------------------

    join_function <- reactive({

        joining_with <- join_list[[input$join_type]]
        return(joining_with)
    })
    
    

# render previews ---------------------------------------------------------

    #render the heads for display
    output$table_a_head <- renderDT(df_a_head(), selection = list(target = 'column'))
    
    output$table_b_head <- renderDT(df_b_head(), selection = list(target = 'column'))
    
    

# generate key column names -----------------------------------------------

    #specify keys for join execution
    key_a <- reactive(        {
        names(df_a_full())[as.numeric(input$table_a_head_columns_selected)]})
    # render prints of the columns selected by user
    output$table_a_userselected <- renderPrint(        {
        key_a()})
    
    #specify keys for join execution
    key_b <- reactive(        {
        names(df_b_full())[as.numeric(input$table_b_head_columns_selected)]})
    # render prints of the columns selected by user
    output$table_b_userselected <- renderPrint({
        key_b()})
    

# join the data -----------------------------------------------------------

joined_df <- reactive({
  execute_join(df_a_full(),
               df_b_full(),
               join_function(),
               key_columns_a = key_a(),
               key_columns_b = key_b()
  )
})

# render the joined df ----------------------------------------------------

    #render the joined df head
    output$tableOut <- renderDT(
        {
        DT::datatable(head(joined_df(),
                       rownames = FALSE,
             # remove visual clutter
             options = list(dom = 't'))

            )
        })
    
    
    

# table a summaries ---------------------------------------------------------

output$dimensions_a <- renderPrint({paste("Dimensions =",
                                      paste(dim(df_a_full()), collapse = ' x '))
  })

output$colnames_a <- renderPrint({paste("Column names =",
                                        paste(names(df_a_full()),
                                              collapse = ', '))
  })


# table b summaries  ------------------------------------------------------

output$dimensions_b <- renderPrint({paste("Dimensions =",
                                          paste(dim(df_b_full()), collapse = ' x '))
})

output$colnames_b <- renderPrint({paste("Column names =",
                                        paste(names(df_b_full()),
                                              collapse = ', '))
})
  

# output table summaries  -------------------------------------------------

output$dimensions_output <- renderPrint({paste("Dimensions =",
                                          paste(dim(joined_df()), collapse = ' x '))
})

output$colnames_output <- renderPrint({paste("Column names =",
                                        paste(names(joined_df()),
                                              collapse = ', '))
})
    

} # End of server
        




# Run the application 
shinyApp(ui = ui, server = server)
