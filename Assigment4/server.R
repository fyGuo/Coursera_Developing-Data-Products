#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
      model1 <- lm(hp ~ mpg, data = mtcars)
      model2 <- lm(hp ~ mpg + cyl, data = mtcars)
      hp_pre <- reactive({
            mpg_input <- input$mpg
            cyl_input <- input$num_cyl
            if(input$Include_cyl){
                        predict(model2, newdata = data.frame(mpg = mpg_input, 
                                                             cyl = cyl_input))
            }
            else{
            hp_pred <- predict(model1, newdata = data.frame(mpg = mpg_input))
            }
            })
      
  output$plot <- renderPlot({
        cyl_input <- input$num_cyl
        mpg_input <- input$mpg
              plot(mtcars$mpg, mtcars$hp,
                   xlab = "Miles Per Gallon",
                   ylab = "Horsepower")
        if (input$Include_cyl){
              model2pre <- predict(model2, newdata = data.frame(mpg = 10 : 34, cyl = cyl_input))
              lines(10 : 34, model2pre, col = "blue")
              text(30, 270, paste("Miles Per Gallon", mpg_input, sep = "="),
                   font = 4, cex = 1.2)
              text(30, 250, paste("Numer of Cylinders", cyl_input, sep = "="),
                   font = 4, cex = 1.2)
              text(30, 230, paste("Predicted housepower", hp_pre(), sep = "="),
                   font = 4, cex = 1.2)
        }
        else{
              lines(10 : 34, 
                    predict(model1, newdata = data.frame(mpg = 10 : 34)), col = "red")
                    text(30, 270, paste("Miles Per Gallon", mpg_input, sep = "="),
                         font = 4, cex = 1.2)
                    text(30, 250, paste("Predicted housepower", hp_pre(), sep = "="),
                         font = 4, cex = 1.2)
                    
              }
              legend(16, 350, c("Model 1 Prediction only Including MPG",
                                "Model 2 Prediction Including MPG and CYL"), 
                     col = c("red", "blue"),
                     pch = 16,
                     bty = "n", cex = 1.2)
              points(mpg_input, hp_pre(), cex = 1.6, pch = 19, col = "Orange")
              })
})
