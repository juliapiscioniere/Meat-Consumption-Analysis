Resource_Factors <- read.csv('Data_Tables/Resource_Consumption_Factors.csv', row.names = 1)
Carcass_Weights <- read.csv('Data_Tables/Average_Carcass_Weights.csv', row.names = 1)
Average_Consumption <- read.csv('Data_Tables/Average_Person_Consumption.csv', row.names = 1)
#Above code imports csv data from Data_Tables in the directory

server <- function(input, output) { 
  fromWeekToYear <- function(servingsPerWeek){ #Used to convert week input to year 
    #and makes it based on the timeFrame as well
    ouncesPerWeek <- servingsPerWeek*4
    ouncesPerYear <- ouncesPerWeek*52
    poundsPerYear <- ouncesPerYear/16
    poundsPerTimeFrame <- poundsPerYear*input$timeFrame
    return(poundsPerTimeFrame)
  }
  
  fromMonthToYear <- function(servingsPerMonth){ #Used to convert month input to year 
    #and makes it based on the timeFrame as well
    ouncesPerMonth <- servingsPerMonth*4
    ouncesPerYear <- ouncesPerMonth*12
    poundsPerYear <- ouncesPerYear/16
    poundsPerTimeFrame <- poundsPerYear*input$timeFrame
    return(poundsPerTimeFrame)
  }
  
  fromWeekToYearNoTimeFrame <- function(servingsPerWeek){ #same function as above
    #without the timeFrame variable, to make it just one year
    ouncesPerWeek <- servingsPerWeek*4
    ouncesPerYear <- ouncesPerWeek*52
    poundsPerYear <- ouncesPerYear/16
    return(poundsPerYear)
  }
  
  fromMonthToYearNoTimeFrame <- function(servingsPerMonth){ #same function as above
    #without the timeFrame variable, to make it just one year
    ouncesPerMonth <- servingsPerMonth*4
    ouncesPerYear <- ouncesPerMonth*12
    poundsPerYear <- ouncesPerYear/16
    return(poundsPerYear)
  }
  
  output$waterPlot <- renderPlot({
    
    water_data <- matrix(c(fromWeekToYearNoTimeFrame(input$Cow)*Resource_Factors["Water/Pound","Cow.Veal"], 
                           fromMonthToYearNoTimeFrame(input$Sheep)*Resource_Factors["Water/Pound","Lamb.Sheep"],
                           fromWeekToYearNoTimeFrame(input$Poultry)*Resource_Factors["Water/Pound","Poultry"],
                           fromWeekToYearNoTimeFrame(input$Pork)*Resource_Factors["Water/Pound","Pork"], 
                           Average_Consumption['Cow-Veal','Gallons.Water.Per.Year'],
                           Average_Consumption['Sheep-Lamb','Gallons.Water.Per.Year'], 
                           Average_Consumption['Poultry','Gallons.Water.Per.Year'],
                           Average_Consumption['Pork','Gallons.Water.Per.Year']),
                         nrow = 4)
    #matrix above used to make grouped bar plot for water consumption
    colnames(water_data) = c("Your Consumption", "Average Consumption")
    rownames(water_data) = c("Beef/Veal", "Lamb/Sheep", "Poultry", "Pork")
    barplot(water_data, col=c("darkblue", "red", "purple", "green"), border="white", font.axis=2, beside=T,
            legend=rownames(water_data), xlab="Consumer", ylab = "Gallons of Water", 
            font.lab=2, main = "Water Usage Per Animal- Your Consumption Versus the Average In One Year")
    
  })
  
  output$carbonPlot <- renderPlot({
    
    carbon_data <- matrix(c(fromWeekToYearNoTimeFrame(input$Cow)*Resource_Factors["Carbon/Pound","Cow.Veal"], 
                            fromMonthToYearNoTimeFrame(input$Sheep)*Resource_Factors["Carbon/Pound","Lamb.Sheep"],
                            fromWeekToYearNoTimeFrame(input$Poultry)*Resource_Factors["Carbon/Pound","Poultry"],
                            fromWeekToYearNoTimeFrame(input$Pork)*Resource_Factors["Carbon/Pound","Pork"], 
                            Average_Consumption['Cow-Veal','Pounds.CO2.Per.Year'],
                            Average_Consumption['Sheep-Lamb','Pounds.CO2.Per.Year'], 
                            Average_Consumption['Poultry','Pounds.CO2.Per.Year'],
                            Average_Consumption['Pork','Pounds.CO2.Per.Year']),
                          nrow = 4)
    colnames(carbon_data) = c("Your Consumption", "Average Consumption")
    rownames(carbon_data) = c("Beef/Veal", "Lamb/Sheep", "Poultry", "Pork")
    barplot(carbon_data, col=c("darkblue", "red", "purple", "green"), border="white", font.axis=2, beside=T,
            legend=rownames(carbon_data), xlab="Counsumer", font.lab=2, main = 
              "Carbon Emissions Per Animal- Your Consumption Versus the Average In One Year")
  })
  
  output$methanePlot <- renderPlot({
    methane_data <- matrix(c(fromWeekToYearNoTimeFrame(input$Cow)*Resource_Factors["Methane/Pound","Cow.Veal"], 
                             fromMonthToYearNoTimeFrame(input$Sheep)*Resource_Factors["Methane/Pound","Lamb.Sheep"],
                             fromWeekToYearNoTimeFrame(input$Poultry)*Resource_Factors["Methane/Pound","Poultry"],
                             fromWeekToYearNoTimeFrame(input$Pork)*Resource_Factors["Methane/Pound","Pork"], 
                             Average_Consumption['Cow-Veal','Pounds.Methane.Per.Year'],
                             Average_Consumption['Sheep-Lamb','Pounds.Methane.Per.Year'], 
                             Average_Consumption['Poultry','Pounds.Methane.Per.Year'],
                             Average_Consumption['Pork','Pounds.Methane.Per.Year']),
                           nrow = 4)
    colnames(methane_data) = c("Your Consumption", "Average Consumption")
    rownames(methane_data) = c("Beef/Veal", "Lamb/Sheep", "Poultry", "Pork")
    barplot(methane_data, col=c("darkblue", "red", "purple", "green"), border="white", font.axis=2, beside=T,
            legend=rownames(methane_data), xlab="Consumer", font.lab=2, main = "Methane 
            Emissions Per Animal- Your Consumption Versus the Average In One Year")
    
    
    
  })
  
  output$timeFrame <- renderText({
    timeFrame()
  })
  
  meatCalculator <- reactive({
    #These multiply the input for the year by the factor from the csv 
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
    #Amount of meat eaten is divided by the carcass weight to get number of 
    #animals eaten
    CowsEaten = (fromMonthToYear(input$Cow)/Carcass_Weights$Beef)
    PoultryEaten = (fromMonthToYear(input$Poultry)/Carcass_Weights$Poultry)
    PorkEaten = (fromMonthToYear(input$Pork)/Carcass_Weights$Pork)
    SheepEaten = (fromWeekToYear(input$Sheep)/Carcass_Weights$Lamb.Sheep)
    
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