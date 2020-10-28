#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Prediction of horsepower in mtcars"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("num_cyl", "Number of cylinders", 4, 8, value = 6),
       sliderInput("mpg", "Miles Per Gallon", 10, 35, value = 20),
       checkboxInput("Include_cyl", "Inlcude number of cylinders in the model", value = TRUE)
       ),
    
    # Show a plot of the generated distribution
    mainPanel(
       h4("This is an app to predict horsepower in dataset mtcars."),
       h4("If you choose not to include
          number of cylinders in the model, then the prediction will just use miles per gallon 
          to predict the horse power. The predicted horsepower will not change as you change
          the number of cylinders."),
       h4("If you choose to include the number of cylinders, then the 
          model will include miles per gallon and number of cylinders as covariates. 
          In this situation, both miles per gallon and number of cylinders will influence the predicted
          horsepower"),
       h4("The orange point present the predicted point."),
       plotOutput("plot"),
    )
  )
))
