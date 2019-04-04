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
         sliderInput("Cow",
                     "How many servings of beef (including veal) do you eat per week? One serving is about 4 ounces.",
                     min = 0,
                     max = 20,
                     value = 4),
      
        sliderInput("Poultry",
                    "How many servings of poultry do you eat per week?",
                    min = 0,
                    max = 20,
                    value = 5),
        sliderInput("Pork",
                    "How many servings of pork do you eat per week?",
                    min = 0,
                    max = 20,
                    value = 3),
        sliderInput("Sheep",
                    "How many servings of sheep/lamb do you eat per month?",
                    min = 0,
                    max = 15,
                    value = 2),
        sliderInput("Fish",
                    "How many servings of fish do you eat per month?",
                    min = 0,
                    max = 20,
                    value = 5)
      ),
      
      
      # Show a plot of the generated distribution
      mainPanel(
        h3("Resources Used and Animals Consumed", align = 'center'),
        tableOutput("calculator"),
        tableOutput("animals")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) { 
   meatCalculator <- reactive({
     data.frame(
       'You Consume These After 10 Years of Eating Meat' = 
         c("Gallons of Water:",
            "Pounds of Carbon Dioxide:",
            "Pounds of Methane"),
       Cow = c(((((input$Cow*4)/16)*52)*1845*10), ((((input$Cow*4)/16)*52)*13.3*10), ((((input$Cow*4)/16)*52)*(166.89/824.75)*10)),
       Poultry = c(((((input$Poultry*4)/16)*52)*515*10), ((((input$Poultry*4)/16)*52)*3.5*10), ((((input$Poultry*4)/16)*52)*(.22/3.31)*10)),
       Pork = c(((((input$Pork*4)/16)*52)*719*10), ((((input$Pork*4)/16)*52)*3.3*10), ((((input$Pork*4)/16)*52)*(31.967/180)*10)),
      # Fish = Sheep = c(((((input$Sheep*4)/16)*12)**10), ((((input$Sheep*4)/16)*12)**10), 14),
       Sheep = c(((((input$Sheep*4)/16)*12)*1246.19*10), ((((input$Sheep*4)/16)*12)*86.42*10), ((((input$Sheep*4)/16)*12)*(1.1/70)*10)), #water data from thepoultrysite.com, carbon data from grist.org
       
       Total = c(((((input$Cow*4)/16)*52)*1845*10) + ((((input$Poultry*4)/16)*52)*515*10) + ((((input$Pork*4)/16)*52)*719*10) + ((((input$Sheep*4)/16)*12)*1246.19*10), 
                  ((((input$Cow*4)/16)*52)*13.3*10) + ((((input$Poultry*4)/16)*52)*3.5*10) + ((((input$Pork*4)/16)*52)*3.3*10) + ((((input$Sheep*4)/16)*12)*86.42*10),
                  ((((input$Cow*4)/16)*52)*(166.89/824.75)*10) + ((((input$Poultry*4)/16)*52)*(.22/3.31)*10) + ((((input$Pork*4)/16)*52)*(31.967/180)*10) + ((((input$Sheep*4)/16)*12)*(1.1/70)*10)))
     })
   
   animalsEaten <- reactive({
     data.frame(
       Animal = c('Cow', 'Chicken and Turkeys', 'Pork', "Sheep"),
       'The Number of Animals Eaten in 10 Years' = c(((((input$Cow*4)/16)*52)/801)*10, ((((input$Poultry*4)/16)*52)/2.6)*10, ((((input$Pork*4)/16)*52)/213)*10, ((((input$Sheep*4)/16)*12)/49)*10)
     )
   })
   
   output$calculator <- renderTable({
     meatCalculator()
  })
   
   output$animals <- renderTable({
     animalsEaten()
   })
   
}

# Run the application 
shinyApp(ui = ui, server)

