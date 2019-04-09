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
                  value = 5),
      
      selectInput("substitue", "Which of the following meat substitutes are you most likely to eat?", 
                  choices = c("Tofu", "Seitan (vital wheat gluten)", "Legumes (Lentils, Beans, Peanuts)", "Vegan and Vegetarian Meats (ex: Gardein Products"))
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Resources Used and Animals Consumed", align = 'center'),
      numericInput("timeFrame",
                   "What time frame do you want the calculations so show? (1 year, 10 years, etc.)",
                   min = .5, max = 100,
                   value = 10),
      tableOutput("calculator"),
      tableOutput("animals")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) { 
  
  output$timeFrame <- renderText({
    timeFrame()
  })
  
  meatCalculator <- reactive({
    
    fromWeekToYear <- function(servingsPerWeek){
      ouncesPerWeek <- servingsPerWeek*4
      ouncesPerYear <- ouncesPerWeek*52
      poundsPerYear <- ouncesPerYear/16
      poundsPerTimeFrame <- poundsPerYear*input$timeFrame
      return(poundsPerTimeFrame)
    }
    
    fromMonthToYear <- function(servingsPerMonth){
      ouncesPerMonth <- servingsPerMonth*4
      ouncesPerYear <- ouncesPerMonth*12
      poundsPerYear <- ouncesPerYear/16
      poundsPerTimeFrame <- poundsPerYear*input$timeFrame
      return(poundsPerTimeFrame)
    }
    
    Cows= c(fromWeekToYear(input$Cow)*1845, fromWeekToYear(input$Cow)*13.3, fromWeekToYear(input$Cow)*(166.89/824.75))
    Poultry= c(fromWeekToYear(input$Poultry)*515, fromWeekToYear(input$Poultry)*3.5, fromWeekToYear(input$Poultry)*(.22/3.31))
    Pork= c(fromWeekToYear(input$Pork)*719, fromWeekToYear(input$Pork)*3.3, fromWeekToYear(input$Pork)*(31.967/180))
    # Fish = Sheep = c(((((input$Sheep*4)/16)*12)*), ((((input$Sheep*4)/16)*12)*), 14),
    Sheep = c(fromMonthToYear(input$Sheep)*1246.19, fromMonthToYear(input$Sheep)*86.42, fromMonthToYear(input$Sheep)*(1.1/70)) #water data from thepoultrysite.com, carbon data from grist.org
    
    data.frame(
      'Your Consumption' = 
        c("Gallons of Water:",
          "Pounds of Carbon Dioxide:",
          "Pounds of Methane"),
      Cows,
      Poultry,
      Pork,
      # Fish = Sheep = c(((((input$Sheep*4)/16)*12)*), ((((input$Sheep*4)/16)*12)*), 14),
      Sheep, #water data from thepoultrysite.com, carbon data from grist.org
      Total = c((Cows[1] + Poultry[1] + Pork[1] + Sheep[1]), (Cows[2] + Poultry[2] + Pork[2] + Sheep[2]), (Cows[3] + Poultry[3] + Pork[3] + Sheep[3])))
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
