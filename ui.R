# # ui script for unifyr

# load dependencies
source("run.R")
# UI ----------------------------------------------------------------------


# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = shinytheme("readable"),
  # insert html head with link to source code
  HTML(
  "<!DOCTYPE html>
    <html>
      <head>
        <title>unifyR</title>
        <a href='https://github.com/r-leyshon/unifyr' target='_blank' style='float:right'>View code on GitHub</a>
      </head>
    </html>
    "
  ),

  # Application title
  titlePanel("unifyR v1.5"),
  sidebarLayout(
    sidebarPanel(
      width = 4,
      fluidRow(
        tags$h3("Step 1. Select data to join."),

# 1. dataframe selectors -----------------------------------------------------
# shinyhelper lhs
helper(
        selectInput("df_a",
          "Select Data 1:",
          available_data,
          selected = "gapminder_africa"
        ),
        type = "markdown",
        content = "lhs"
        ),

# shinyhelper rhs
helper(
        selectInput("df_b",
          "Select Data 2:",
          available_data,
          selected = "gapminder_full"
        ),
        type = "markdown",
        content = "rhs"
)
      ),
      tags$hr(),

# 2. select a join type ------------------------------------------------------

      # specify join

      fluidRow(
        # ui changes dependent on user selected join 
        htmlOutput("dynamic_helper"),
        selectInput("join_type",
          "Select the type of join to perform:",
          c(
            "left_join", "right_join", "inner_join",
            "semi_join", "full_join", "anti_join"
          ),
          selected = "left_join"
        )
      ),

      tags$hr(),

    # 3. select columns to join by --------------------------------------------

      tags$h3("Step 3 (optional). Select columns to join by."),
      tags$h5(
        "Choose the columns by clicking on the tables in the panel to the right"
        ),

# shinyhelper keys
helper(
      # display selected key column names
      fluidRow(
        # LHS
        h5("Data 1 selected column(s)"),

        verbatimTextOutput("table_a_userselected"),

        # RHS
        h5("Data 2 selected column(s)"),
        verbatimTextOutput("table_b_userselected")
      ),
      type = "markdown",
      content = "keys",
      size = "l")
      
    ), # end of sidebarlayout


    mainPanel(
      width = 8,
      tabsetPanel(
        type = "tabs",


# first tabpanel ----------------------------------------------------------


        tabPanel(
          "Input DFs",
          tags$p("Please scroll down for more..."),
          # LHS
          fluidRow(
            # add column to control total width
            column(width = 4,
            # shinyhelper nrow
            helper(
            # input to determine number of rows to render
            numericInput("n1", "Number of rows to display", value = 5, min = 1, step = 1),
            type = "markdown",
            content = "nrow")
            ),
            
            column(width = 12,
                   # dynamic title 
            tags$h3(textOutput("df_a_title")),
            DTOutput(outputId = "table_a_head"),
            #shinyhelper dimensions
            helper(
            verbatimTextOutput("dimensions_a"),
            type = "markdown",
            content = "dimensions"),
            # shinyhelper colnames
            helper(
            verbatimTextOutput("colnames_a"),
            type = "markdown",
            content = "colnames")
          )
          ),

          tags$hr(), # horizontal rule
          # RHS
          fluidRow(
            # add column to control total width
            column(width = 4,
                   # shinyhelper nrow
                   helper(
            # input to determine number of rows to render
            numericInput("n2", "Number of rows to display", value = 5, min = 1, step = 1),
            type = "markdown",
            content = "nrow")),
            
            
            column(width = 12,
            # dynamic title 
            tags$h3(textOutput("df_b_title")),
            h3("Head of Data 2"),
            DTOutput("table_b_head"),
            #shinyhelper dimensions
            helper(
            verbatimTextOutput("dimensions_b"),
            type = "markdown",
            content = "dimensions"),
            # shinyhelper colnames
            helper(
            verbatimTextOutput("colnames_b"),
            type = "markdown",
            content = "colnames")
          )
          )
        ), # end of tabpanel 1



# tabpanel 2 output df ----------------------------------------------------

        tabPanel(
          "Output DF",


          fluidRow(
            column(width = 4,
                   # shinyhelper nrow
                   helper(
            # input to determine number of rows to render
            numericInput("n3", "Number of rows to display", value = 5, min = 1, step = 1),
            type = "markdown",
            content = "nrow")
            ),
            
            column(width = 12,
                   #shinyhelper output_df
                   column(width = 12,
                   helper(
                  # dynamic title 
                  tags$h3(textOutput("joined_title")),
            type = "markdown",
            content = "output_df")
            ),
            column(width = 12,
            DTOutput("table_out"),
            #shinyhelper dimensions
            helper(
            verbatimTextOutput("dimensions_output"),
            type = "markdown",
            content = "dimensions"),
            # shinyhelper colnames
            helper(
            verbatimTextOutput("colnames_output"),
            type = "markdown",
            content = "colnames")
            )
          )
          )
        )#end of tabpanel 2

      ) # end of tabset panel
    ) # end of mainPanel
  ) # end of sidebarlayout
) # end of fluid page
