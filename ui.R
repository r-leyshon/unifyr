# # ui script for unifyr

# load dependencies
source('run.R')
# UI ----------------------------------------------------------------------


# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("readable"),
                
                # Application title
                titlePanel("unifyR v1.4"),
                sidebarLayout(
                  
                  sidebarPanel(width = 4,
                               fluidRow(tags$h3('Step 1. Select datasets to join.'),
                                        
                                        # 1. dataframe selectors -----------------------------------------------------
                                        
                                        selectInput("df_a",
                                                    "Select First Dataset:",
                                                    .available_data,
                                                    selected = "gapminder_africa"),
                                        
                                        selectInput("df_b",
                                                    "Select Second Dataset:",
                                                    .available_data,
                                                    selected = "gapminder_full")
                               ),
                               tags$hr(),
                               # 2. select a join type ------------------------------------------------------
                               
                               #specify join
                               
                               fluidRow(
                                 
                                 tags$h3('Step 2. Select a join type to execute.'),
                                 
                                 
                                 selectInput("join_type",
                                             "Select the type of join to perform:",
                                             c('left_join', 'right_join', 'inner_join',
                                               'semi_join', 'full_join', 'anti_join'),
                                             selected = "left_join")
                               ),
                               
                               tags$hr(),
                               
                               # 3. select columns to join by --------------------------------------------
                               
                               tags$h3('Step 3 (optional). Select columns to join by.'),
                               tags$h5('Choose the columns by clicking on the tables in the panel to 
               the right'),
                               
                               # display selected key column names
                               fluidRow(
                                 #LHS
                                 h5("L.H.S. selected column(s)"), 
                                 verbatimTextOutput('table_a_userselected'),
                                 
                                 #RHS
                                 h5("R.H.S. selected column(s)"), 
                                 verbatimTextOutput('table_b_userselected')
                               )
                               
                               
                  ),# end of sidebarlayout
                  
                  
                  mainPanel(width = 8,
                            tabsetPanel(type = 'tabs',
                                        
                                        
                                        # first tabpanel ----------------------------------------------------------
                                        
                                        
                                        tabPanel("Input DFs",
                                                 #LHS
                                                 fluidRow(h3("Head of data 1"), DTOutput(outputId = 'table_a_head'),
                                                          verbatimTextOutput('dimensions_a'),
                                                          verbatimTextOutput('colnames_a')),
                                                 
                                                 tags$hr(),#horizontal rule
                                                 #RHS
                                                 fluidRow(h3("Head of data 2"), DTOutput('table_b_head'),
                                                          verbatimTextOutput('dimensions_b'),
                                                          verbatimTextOutput('colnames_b')
                                                 )
                                        ),# end of tabpanel 1
                                        
                                        
                                        
                                        # tabpanel 2 output df ----------------------------------------------------
                                        
                                        tabPanel("Output DF", 
                                                 
                                                 
                                                 fluidRow(h3("Head of output data"), DTOutput('tableOut'),
                                                          verbatimTextOutput('dimensions_output'),
                                                          verbatimTextOutput('colnames_output'))
                                                 
                                        )#, #end of tabpanel 2
                                        
                                        # tabPanel("Bring your own data",
                                        #          
                                        #          tags$p('Upload one or more files.'),
                                        #          # input for file upload
                                        #          fileInput("userfile", NULL, accept = c(".csv", ".tsv", ".rds")),
                                        #          tags$p('Once uploaded, visit the first tab to specify your data & join parameters.'),
                                        #          # input to deterrmine number of rows to render
                                        #          numericInput("n", "Rows", value = 5, min = 1, step = 1),
                                        #          # view the head with the assigned no. of rows
                                        #          tableOutput("head")
                                        #          
                                        #          
                                        #          
                                        #          
                                        #          )
                                        
                            ) # end of tabset panel
                            
                  )#end of mainPanel
                  
                )#end of sidebarlayout
                
)#end of fluid page

