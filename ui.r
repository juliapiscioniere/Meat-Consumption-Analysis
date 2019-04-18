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
                  value = 2),
      tableOutput("animals")
    ),
    
    
    mainPanel(
      h3("Resources Used and Animals Consumed", align = 'center'),
      numericInput("timeFrame",
                   "What time frame do you want the calculations so show? (1 year, 10 years, etc.)",
                   min = .5, max = 100,
                   value = 10),
      tableOutput("calculator"),
      plotOutput("waterPlot"),
      plotOutput("carbonPlot"),
      plotOutput("methanePlot")
    )
  )
)
Resource_Factors <- read.csv('Data_Tables/Resource_Consumption_Factors.csv', row.names = 1)
Carcass_Weights <- read.csv('Data_Tables/Average_Carcass_Weights.csv', row.names = 1)
Average_Consumption <- read.csv('Data_Tables/Average_Person_Consumption.csv', row.names = 1)