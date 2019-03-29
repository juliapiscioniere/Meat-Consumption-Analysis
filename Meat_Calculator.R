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
   titlePanel("Meat Consumption Analysis"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput(inputId = "Cow",
                     "How many servings of beef do you eat per week? One serving is about 4 ounces.",
                     min = 0,
                     max = 20,
                     value = 2),
      
        sliderInput("Poultry",
                    "How many servings of poultry do you eat per week?",
                    min = 0,
                    max = 20,
                    value = 4),
        sliderInput("Pork",
                    "How many servings of pork do you eat per week?",
                    min = 0,
                    max = 20,
                    value = 2),
        sliderInput("Lamb/Sheep",
                    "How many servings of lamb do you eat per month?",
                    min = 0,
                    max = 35,
                    value = 5),
        sliderInput("Fish",
                    "How many servings of fish do you eat per week?",
                    min = 0,
                    max = 20,
                    value = 5)
      ),
      
      
      # Show a plot of the generated distribution
      mainPanel(
        h3("Resources Used and Emissions Consumed", align = 'center'),
        textOutput("cowOutput")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$calcOutput <- renderTable({
     "Cow:"
      
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

