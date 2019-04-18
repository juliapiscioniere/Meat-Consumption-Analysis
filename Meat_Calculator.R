#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fluidPage(
   
   titlePanel("Meat Consumption Analysis"),
   
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
                    value = 2)
        
      #  selectInput("substitue", "Which of the following meat substitutes are you most likely to eat?", 
       #             choices <- c("Tofu", "Seitan (vital wheat gluten)", "Legumes (Lentils, Beans, Peanuts)", "Vegan and Vegetarian Meats (ex: Gardein Products"))
      ),
      

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

Resource_Factors <- read.csv('Data_Tables/Resource_Consumption_Factors.csv', row.names = 1)
Carcass_Weights <- read.csv('Data_Tables/Average_Carcass_Weights.csv', row.names = 1)

server <- function(input, output) { 
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
  
  output$timeFrame <- renderText({
    timeFrame()
  })
  
  meatCalculator <- reactive({
    

    
    Cows= c(fromWeekToYear(input$Cow)*Resource_Factors["Water/Pound", "Cow.Veal"], 
            fromWeekToYear(input$Cow)*Resource_Factors["Carbon/Pound", "Cow.Veal"], 
            fromWeekToYear(input$Cow)*Resource_Factors["Methane/Pound", "Cow.Veal"]) 
    
    Poultry= c(fromWeekToYear(input$Poultry)*Resource_Factors["Water/Pound", "Poultry"], 
               fromWeekToYear(input$Poultry)*Resource_Factors["Carbon/Pound", "Poultry"], 
               fromWeekToYear(input$Poultry)*Resource_Factors["Methane/Pound", "Poultry"])
    
    Pork= c(fromWeekToYear(input$Pork)*Resource_Factors["Water/Pound", "Pork"], 
            fromWeekToYear(input$Pork)*Resource_Factors["Carbon/Pound", "Pork"], 
            fromWeekToYear(input$Pork)*Resource_Factors["Methane/Pound", "Pork"])

    Sheep = c(fromMonthToYear(input$Sheep)*Resource_Factors["Water/Pound", "Lamb.Sheep"], 
              fromMonthToYear(input$Sheep)*Resource_Factors["Carbon/Pound", "Lamb.Sheep"], 
              fromMonthToYear(input$Sheep)*Resource_Factors["Methane/Pound", "Lamb.Sheep"]) 
    
    data.frame(
      'Your Consumption' = 
        c("Gallons of Water:",
          "Pounds of Carbon Dioxide:",
          "Pounds of Methane"),
      Cows,
      Poultry,
      Pork,
      Sheep, 
      Total = c((Cows[1] + Poultry[1] + Pork[1] + Sheep[1]), (Cows[2] + Poultry[2] 
              + Pork[2] + Sheep[2]), (Cows[3] + Poultry[3] + Pork[3] + Sheep[3])))
  })
  
  animalsEaten <- reactive({
    
      CowsEaten = (fromMonthToYear(input$Cow)/Carcass_Weights$Beef)*input$timeFrame
      PoultryEaten = (fromMonthToYear(input$Poultry)/Carcass_Weights$Poultry)*input$timeFrame
      PorkEaten = (fromMonthToYear(input$Pork)/Carcass_Weights$Pork)*input$timeFrame
      SheepEaten = (fromWeekToYear(input$Sheep)/Carcass_Weights$Lamb.Sheep)*input$timeFrame
      
      data.frame(
        Animal = c('Cow', 'Chicken and Turkeys', 'Pork', "Sheep"),
        'Animals Eaten in Time Frame' = c(CowsEaten, PoultryEaten, PorkEaten,
                                          SheepEaten)
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
shinyApp(ui <- ui, server)
