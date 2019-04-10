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