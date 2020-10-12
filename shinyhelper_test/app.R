#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyhelper)

ui = fluidPage(
    sidebarLayout(
        sidebarPanel(
            selectInput("var", 
                        label = "var",
                        choices = c("A", "B", "C", "D")) %>% 
                helper(icon="question",                                          
                       type="markdown",
                       content="herp")),        
        mainPanel(
            htmlOutput("selected"))
    ))




server = function(input, output,session) {
    observeEvent(input$join_type  , {
        if(input$var=="B"){
            output$selected <- renderUI({ 
                fluidRow(
                    column(4,textInput(inputId="derp",
                                       label="derp") %>% 
                               helper(icon="question", 
                                      type="markdown",                                                                 
                                      content="flerp")),
                    column(8))})
        }})
    
    observeEvent(input$derp, {print(input$derp)})
    
    observe_helpers()  
    
}

runApp(list(ui = ui, server = server))
