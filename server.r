server <- function(input, output) { 
  
  output$timeFrame <- renderText({
    timeFrame()
  })
  
  output$plots <- renderPlot({
    MeatAndVeg <- 
      barplot(height = c())
  })
  
  fromWeekToYear <- function(servingsPerWeek){
    ouncesPerWeek = servingsPerWeek*4
    ouncesPerYear = ouncesPerWeek*52
    poundsPerYear = ouncesPerYear/16
    poundsPerTimeFrame = poundsPerYear*input$timeFrame
    return(poundsPerTimeFrame)
  }
  
  fromMonthToYear <- function(servingsPerMonth){
    ouncesPerMonth = servingsPerMonth*4
    ouncesPerYear = ouncesPerMonth*12
    poundsPerYear = ouncesPerYear/16
    poundsPerTimeFrame = poundsPerYear*input$timeFrame
    return(poundsPerTimeFrame)
  }
  
  meatCalculator <- reactive({
    
    Cows<- c(fromWeekToYear(input$Cow)*Resource_Factors["Water/Pound", "Cow.Veal"], 
             fromWeekToYear(input$Cow)*Resource_Factors["Carbon/Pound", "Cow.Veal"], 
             fromWeekToYear(input$Cow)*Resource_Factors["Methane/Pound", "Cow.Veal"]) 
    
    Poultry<- c(fromWeekToYear(input$Poultry)*Resource_Factors["Water/Pound", "Poultry"], 
                fromWeekToYear(input$Poultry)*Resource_Factors["Carbon/Pound", "Poultry"],
                fromWeekToYear(input$Poultry)*Resource_Factors["Methane/Pound", "Poultry"])
    
    Pork<- c(fromWeekToYear(input$Pork)*Resource_Factors["Water/Pound", "Pork"], 
             fromWeekToYear(input$Pork)*Resource_Factors["Water/Pound", "Pork"], 
             fromWeekToYear(input$Pork)*Resource_Factors["Methane/Pound", "Pork"])
    
    Sheep <- c(fromMonthToYear(input$Sheep)*Resource_Factors["Water/Pound", "Sheep.Lamb"], 
               fromMonthToYear(input$Sheep)*Resource_Factors["Carbon/Pound", "Sheep.Lamb"], 
               fromMonthToYear(input$Sheep)*Resource_Factors["Carbon/Pound", "Sheep.Lamb"]) 
    #water data from thepoultrysite.com, carbon data from grist.org
    
    data.frame(
      'Your Consumption' = 
        c("Gallons of Water:",
          "Pounds of Carbon Dioxide:",
          "Pounds of Methane"),
      Cows,
      Poultry,
      Pork,
      Sheep, #water data from thepoultrysite.com, carbon data from grist.org
      Total = c((Cows[1] + Poultry[1] + Pork[1] + Sheep[1]), (Cows[2] + 
                                                                Poultry[2] + Pork[2] + Sheep[2]), (Cows[3] + Poultry[3] + Pork[3]
                                                                                                   + Sheep[3])))
  })
  
  animalsEaten <- reactive({
    
    CowsEaten = fromMonthToYear(input$Cow)
    PoultryEaten = fromMonthToYear(input$Poultry)
    PorkEaten = fromMonthToYear(input$Pork)
    SheepEaten = fromWeekToYear(input$Sheep)
    
    data.frame(
      Animal = c('Cow', 'Chicken and Turkeys', 'Pork', "Sheep"),
      'Animals Eaten in Time Frame' = c(CowsEaten, PoultryEaten, PorkEaten,
                                        SheepEaten))
  })
  
  output$calculator <- renderTable({
    meatCalculator()
  })
  
  output$animals <- renderTable({
    animalsEaten()
  })
  
  
  
}
