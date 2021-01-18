#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),
    textInput(inputId = "try", label="input here"),
    textOutput(outputId = "print_text")
   
    # Sidebar with a slider input for number of bins 
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$print_text<-renderText(input$try)
}

# Run the application 
shinyApp(ui = ui, server = server)

## 1 At the end of the application file, s​hinyApp() takes the user interface and server objects and combines them into an application.

##2 R​Studio

## 3 user interface server​ function

##S​hiny is an approach for designing interactive web applications based on R.

##5 f​luidpPage() sets up the layout for an application.
 ## 6 nputId
## 7 T​he user input will be assigned to the value input$my_input.

## p​lotOutput() can be included as part of the fluidPage function in the UI section of a Shiny app to display a plot object created in the server function.

##9 r​enderPlot() takes an expression that generates a plot (like ggplot()) and will assign that to an output slot that can be used in plotOutput()

## 10 A​fter you've written all the code, click "Run App" in RStudio
## After you've written all the code, select all the code and execute it, with shinyApp() being the last line.







