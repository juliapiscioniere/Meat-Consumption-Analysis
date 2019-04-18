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