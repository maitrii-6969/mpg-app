library(shiny)

# Prepare data and fit the model once, when the app starts
cars <- mtcars
cars$trans <- factor(cars$am, levels = c(0, 1),
                     labels = c("Automatic", "Manual"))
model <- lm(mpg ~ wt + hp + trans, data = cars)

shinyServer(function(input, output) {

  # Reactive calculation: runs whenever an input changes
  prediction <- reactive({
    newdata <- data.frame(
      wt = input$wt,
      hp = input$hp,
      trans = factor(input$trans, levels = c("Automatic", "Manual"))
    )
    predict(model, newdata, interval = "prediction")
  })

  output$predText <- renderText({
    paste0("Predicted MPG: ", round(prediction()[1, "fit"], 1))
  })

  output$rangeText <- renderText({
    p <- prediction()
    paste0("Likely range (95%): ", round(p[1, "lwr"], 1),
           " to ", round(p[1, "upr"], 1), " MPG")
  })

  output$mpgPlot <- renderPlot({
    plot(cars$wt, cars$mpg,
         col = ifelse(cars$trans == "Manual", "blue", "red"),
         pch = 19, xlab = "Weight (1000 lbs)", ylab = "Miles per gallon",
         main = "mtcars data and your predicted car")
    points(input$wt, prediction()[1, "fit"],
           pch = 17, cex = 2.5, col = "darkgreen")
    legend("topright", legend = c("Automatic", "Manual", "Your car"),
           col = c("red", "blue", "darkgreen"), pch = c(19, 19, 17))
  })
})
