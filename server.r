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
    
    MethaneCow = 575.6052162/824.75 #amount of methane per cow divided by average carcass weight
    MethanePoultry = 0.033241905/ 3.31
    MethanePork = 20.8676603/180
    MethaneLambSheep = 44.33085392/50
    
    
    Cows= c(fromWeekToYear(input$Cow)*1845, fromWeekToYear(input$Cow)*13.3, fromWeekToYear(input$Cow)*MethaneCow) #for methane, each one is divided by the size of the average animal because the value is pounds/head/year, so this is to get pound per pound of meat
    Poultry= c(fromWeekToYear(input$Poultry)*515, fromWeekToYear(input$Poultry)*3.5, fromWeekToYear(input$Poultry)*MethanePoultry)
    Pork= c(fromWeekToYear(input$Pork)*719, fromWeekToYear(input$Pork)*3.3, fromWeekToYear(input$Pork)*MethanePork)
    # Fish = Sheep = c(((((input$Sheep*4)/16)*12)*), ((((input$Sheep*4)/16)*12)*), 14),
    Sheep = c(fromMonthToYear(input$Sheep)*1246.19, fromMonthToYear(input$Sheep)*86.42, fromMonthToYear(input$Sheep)*MethaneLambSheep) #water data from thepoultrysite.com, carbon data from grist.org
    
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