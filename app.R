#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny, quietly = TRUE)
library(dplyr, quietly = TRUE)
library(DT, quietly = TRUE)
library(reactlog, quietly = TRUE)
#library(vctrs, quietly = TRUE)
library(magrittr, quietly = TRUE)


# source functions
source('func/functions.R')

reactlog_enable()
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
ui <- fluidPage(

    # Application title
    titlePanel("unifyR"),

 
fluidRow(
    column(width = 12,
tags$h1('Step 1. Select datasets to join.')),


# dataframe selectors -----------------------------------------------------

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
),


# data heads --------------------------------------------------------------

fluidRow(
    #LHS
    column(width = 6, h3("Head of data 1"), DTOutput(outputId = 'table_a_head'),
           verbatimTextOutput('table_a_userselected')),
    
    #RHS
    column(width = 6, h3("Head of data 2"), DTOutput('table_b_head'),
           verbatimTextOutput('table_b_userselected'))
    ),


# select a join type ------------------------------------------------------

#specify join
column(width = 12,
       tags$h1('Step 2. Select a join type to execute.')),


column(width = 12,
       selectInput("join_type",
                   "Select the type of join to perform:",
                   c('left_join', 'right_join', 'inner_join',
                     'semi_join', 'full_join', 'anti_join'),
                   selected = "left_join")),


# view the output ---------------------------------------------------------

#output view
column(width = 12,
       tags$h1('Step 3. View the output data.')),

fluidRow(
    column(width = 12, h3("Head of output data"), DTOutput('tableOut'))
)


)#end of fluid page

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
    
   

# render the joined df ----------------------------------------------------

    #render the joined df
    output$tableOut <- renderDT(
        {
        head(
            execute_join(df_a_full(),
                         df_b_full(),
                         join_function(),
                         key_columns_a = key_a(),
                         key_columns_b = key_b()
                         )
            )
        })

} # End of server
        




# Run the application 
shinyApp(ui = ui, server = server)
