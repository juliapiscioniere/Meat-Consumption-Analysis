# Meat-Consumption-Analysis

HOW TO RUN APP

To run the rshiny app locally on your computer, make sure you have R installed on your computer, open an R Script and type: 
shiny::runGitHub('Meat-Consumption-Analysis', 'juliapiscioniere')

OBJECTIVE

This repo contains the code for a meat consumption calculator modeled after this one on blitzresults:
https://www.blitzresults.com/en/meat/

The main points in running and interacting with the meat consumption calculator:
•	Calculate the carbon and methane polluted and water used when producing user’s meat 
•	Show how meat is a major component to a person’s carbon footprint

I have noticed that many people do not think about the implications of meat, or have no clue the impact that eating red meat can have. The goal of this calculator is to show people what an impact cutting out certain meats could have. 

STRUCTURE 

The repo contains different files related to the Rshiny App. 
List of Files and their Function:
1.	Server.r and ui.r – the two spit files of the app; it allows the app to run locally on user’s machine
2.	Meat_Calculator.R - the R file with the whole source code for the RShiny App 
3.	Data_Tables Folder – contains csv files with data for calculations 
  a.	Resource_Consumption_Factors.csv is the table with the amount of resource per one pound of meat per animal
  b.	Average_Carcass_Weight.csv is the average carcass weight of each type of animal; this is used to calculate       the animals consumed 
  c.	Average_Person_Consumption.csv is the average American’s meat consumption and resource usage; this is used       to compare against user’s input 
  d.	Slaughter_Counts_Per_Animal.csv is the total number of animals slaughtered in the U.S. in 2016

ACKNOWLEDGEMENTS:

The model of this calculator is based off of this calculator: https://www.blitzresults.com/en/meat/

Thank you Dr. McGlinn for teaching me R and assigning this project! 

DATA CREDITS:

*All data with correlated year came from 2016*

Data from Meat Calculator Website:
  •	Water and Carbon Resource Factors for Pork, Beef/Veal, and Poultry
  •	Tofu Resources

Data from USDA Economic Research Service:
Link: https://www.ers.usda.gov/data-products/livestock-meat-domestic-data/livestock-meat-domestic-data/#Livestock%20and%20poultry%20slaughter

Main Dataset “meatstatsfull.csv” = Link Above, Under ‘All Meat Statistics’, and then download ‘Historical’
  •	Carcass Weights:
    o	Poultry = Average of Chicken and Turkey = 14.3 lbs
    o	Beef/Veal = Weighted Average with cattle dressed weights and calve dressed weights (since more cattle are       eaten than calves) = 818.2 lbs
    o	Lamb/Sheep = Average of sheep and lambs dressed weight column = 68.7 lbs
    o	Pork = Average of total Hogs dressed weight column = 211.3 lbs

  •	Total Numbers of Meat Slaughter:
    o	Added up the columns without the ‘- -‘ in front under the “SlaughterCountsFull” tab
    o	Data shown in the Slaughter Counts Per Animal csv

Loss-Adjusted Availability Per Capita:
Link: https://www.ers.usda.gov/data-products/food-availability-per-capita-data-system/food-availability-per-capita-data-system/
  •	Average Consumption of Lamb/Sheep = .5 lb/year    
