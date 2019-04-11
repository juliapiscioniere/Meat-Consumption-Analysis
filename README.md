# Meat-Consumption-Analysis
Objective:

This repo contains the code for a meat consumption calculator modeled after this one on blitzresults:
https://www.blitzresults.com/en/meat/

The main point in running and interacting with the meat consumption calculator is for people to see that meat is a major component to their overall waste and carbon footprint; the calculator displays the water, carbon, and methane that is used/ produced when supplying the specific amount of meat indicated in the calculator's inputs. People tend to be conscious of the amount of gas that they use while driving, the amount of plane rides they take, the amount of water they use in their home, the amount of waste they produce and the amount of energy they use in their homes, but they are blind to one of the main contributors to their overall consumption - meat.

Structure:

The repo contains different files related to the Rshiny App. The most important files include the server.r and the ui.r files; these are the ones that allow the app to be run locally on a person's machine. Both the Meat_Calculator.R and the RScript_Meat_Calculator.R have the full source code for the app, with the first one being the shiny web app document and the second being a basic rscript. These are if you want to see the server and ui in the same code/ as one document. The Data_Wrangling is not used in this project thus far, so it can be disregarded. 

Run App:

To run the rshiny app locally on your computer, make sure you have R installed on your computer, open an R Script and type: shiny::runGitHub('Meat-Consumption-Analysis', 'juliapiscioniere')

Acknowledgements:

The model of this calculator is based off of this calculator: https://www.blitzresults.com/en/meat/

DATA CREDITS:

Average meat consumption per capita in America values: USDA ERS Loss-Adjusted Food Availability for Meat, Poultry, Fish, Eggs, and Nuts
  Link - https://www.ers.usda.gov/data-products/food-availability-per-capita-data-system/food-availabili          ty-per-capita-data-system/#Loss-Adjusted%20Food%20Availability
  Column - Retail Per Capita Food Availability for 2016
  The data is coming from the loss-adjusted food availability rather than the main data sheet (which is   the one referenced on blitzresults) because it is the average per capita adjusted for food that is      spoiled along the way, goes bad, recalled, and overall not eaten.
  
Water and CO2 Consumption: Data table on blitzresults calculator, source is Water Footprint Network and Oko-Institute 

Calculation for slaughtered animals per year: the calculation that is on the blitzresults website
    Slaughtered Animals = (Meat Consumption in Pounds)/(Retail Weight of Meat Per Animal in Pounds)
    Data for Average Retail Weight is from blitzresults: 
              Pork = 213 lbs/pig
              Beef/Veal = 801 lbs/animal
              Poultry = 2.6 lbs/animal
              
Methane Consumption: Data is from Environmental Protection Agency, chapter_tables, table 5-10, kg/head/year in 2015
    I added the dairy and beef numbers together because dairy cows do end up being slaughtered for meat,     so it is not right to differentiate when analyzing for meat consumption. I also converted the           numbers to pounds/head/year for this meat calculator. 
    
  
  


