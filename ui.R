# # ui script for unifyr

# load dependencies
source("run.R")
# UI ----------------------------------------------------------------------


# Define UI for application that draws a histogram
ui <- fluidPage(
  # Use theme to style with custom css
  theme = "style.css",
  # include the cicerone guide & dependencies
  use_cicerone(),
  # set content language for screen reader accessibility
  tags$head(HTML("<html lang='en'>")),
  # set page title for accessibility
  titlePanel(title = tags$header(
    class = "banner", tags$h1(
      # app name 
      tags$strong("unifyR v1.7"), id = "appname"),
    # github link
    tags$a(href = "https://github.com/r-leyshon/unifyr",
           target='_blank',
           style='float:right',
           tags$strong("View code on GitHub"),
           id = "sourcecode",
           class = "source")), windowTitle = "Explore data joins in Unifyr"),


  
  sidebarLayout(
# sidebar -----------------------------------------------------------------
    
    # div to apply css styling to sidebar
    sidebarPanel(class = "sidebar",
      width = 4,
      actionButton(inputId = "guide", label = "Take a tour"),
      fluidRow(id = "step1",
        tags$h3("Step 1. Select data to join."),
# 1. dataframe selectors -----------------------------------------------------
# shinyhelper lhs
helper(
        selectInput(inputId = "df_a",
          label = "Select Data 1:",
          available_data,
          selected = "gapminder_africa"
        ),
        type = "markdown",
        content = "lhs",
        colour = "#ce3487"
        ),

# shinyhelper rhs
helper(
        selectInput(inputId = "df_b",
          label = "Select Data 2:",
          available_data,
          selected = "gapminder_gdp"
        ),
        type = "markdown",
        content = "rhs",
        colour = "#ce3487"
)
      ),
      tags$hr(),


# 2. select a join type ------------------------------------------------------

      # specify join

      fluidRow(id = "step2",
        # ui changes dependent on user selected join 
        htmlOutput("dynamic_helper"),
        selectInput(inputId = "join_type",
          label = "Select the type of join to perform:",
          c(
            "left_join", "right_join", "inner_join",
            "semi_join", "full_join", "anti_join"
          ),
          selected = "left_join"
        )
      ),

      tags$hr(),

    # 3. select columns to join by --------------------------------------------


      tags$h3("Step 3 (optional). Select Key Columns.", id = "optional"),
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
      size = "l",
      colour = "#ce3487"),
tags$br(),
tags$hr(),
tags$h3(id = "execute_title", "Step 4: Execute The Join!",
        actionButton(
          inputId = "execute", label = "Go!", icon = icon("play-circle")))

      
    ),# end of sidebarlayout


    mainPanel(
      width = 8,
      tabsetPanel(id = "tabz",
        type = "tabs",


# first tabpanel ----------------------------------------------------------


        tabPanel(
          "Input DFs",
          tags$p("Please scroll down for more..."),
          # LHS
          fluidRow(
            # add column to control total width
            column(width = 4,
                   div(id = "nrow1",
            # shinyhelper nrow
            helper(
            # input to determine number of rows to render
            numericInput(inputId = "n1",
                         label = "Number of rows to display",
                         value = 5, min = 1, step = 1),
            type = "markdown",
            content = "nrow",
            colour = "#ce3487")
            )),
            
            column(width = 12,
                   div(id = "lhs",
                   # dynamic title 
            tags$h3(textOutput("df_a_title")),
            DTOutput(outputId = "table_a_head")),
            div(id = "deets_lhs",
            #shinyhelper dimensions
            helper(
            verbatimTextOutput("dimensions_a"),
            type = "markdown",
            content = "dimensions",
            colour = "#ce3487"),
            # shinyhelper colnames
            helper(
            verbatimTextOutput("colnames_a"),
            type = "markdown",
            content = "colnames",
            colour = "#ce3487"))
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
            content = "nrow",
            colour = "#ce3487")),
            
            
            column(width = 12,
                   div(id = "rhs",
            # dynamic title 
            tags$h3(textOutput("df_b_title")),
            DTOutput("table_b_head")),
            div(id = "deets_rhs",
            #shinyhelper dimensions
            helper(
            verbatimTextOutput("dimensions_b"),
            type = "markdown",
            content = "dimensions",
            colour = "#ce3487"),
            # shinyhelper colnames
            helper(
            verbatimTextOutput("colnames_b"),
            type = "markdown",
            content = "colnames",
            colour = "#ce3487"))
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
            content = "nrow",
            colour = "#ce3487")
            ),
            
            column(width = 12,
                   #shinyhelper output_df
                   column(width = 12,
                          div(id = "output_preview",
                   helper(
                  # dynamic title 

                  tags$h3(textOutput("joined_title")),
            type = "markdown",
            content = "output_df",
            colour = "#ce3487"),
            
            column(width = 12,
            DTOutput("table_out"))
            ),
            tags$br(),
            #shinyhelper dimensions
            helper(
            verbatimTextOutput("dimensions_output"),
            type = "markdown",
            content = "dimensions",
            colour = "#ce3487"),
            # shinyhelper colnames
            helper(
            verbatimTextOutput("colnames_output"),
            type = "markdown",
            content = "colnames",
            colour = "#ce3487")
            )
          )
          )
        )#end of tabpanel 2

      ) # end of tabset panel
    ) # end of mainPanel
  ) # end of sidebarlayout
) # end of fluid page
