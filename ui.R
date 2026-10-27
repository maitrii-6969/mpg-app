library(shiny)

shinyUI(fluidPage(
  titlePanel("Car MPG Predictor"),

  sidebarLayout(
    sidebarPanel(
      h4("Describe your car"),
      sliderInput("wt", "Weight (1000 lbs):",
                  min = 1.5, max = 5.5, value = 3, step = 0.1),
      sliderInput("hp", "Horsepower:",
                  min = 50, max = 340, value = 120, step = 5),
      radioButtons("trans", "Transmission:",
                   choices = c("Automatic", "Manual"),
                   selected = "Automatic"),
      helpText("Move the sliders or change the transmission. ",
               "The prediction updates automatically.")
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Prediction",
                 br(),
                 h3(textOutput("predText")),
                 p(textOutput("rangeText")),
                 plotOutput("mpgPlot")),

        tabPanel("How to use this app",
                 br(),
                 h4("What does this app do?"),
                 p("It predicts a car's fuel efficiency (miles per gallon)",
                   "from its weight, horsepower and transmission type.",
                   "The prediction comes from a linear regression model",
                   "fitted on R's built-in mtcars dataset (32 cars)."),
                 h4("How to use it"),
                 tags$ol(
                   tags$li("Use the Weight slider on the left to set the car's weight."),
                   tags$li("Use the Horsepower slider to set the engine power."),
                   tags$li("Choose Automatic or Manual transmission."),
                   tags$li("Open the Prediction tab. The predicted MPG and a likely range appear at the top.")
                 ),
                 h4("Reading the plot"),
                 p("Red dots are automatic cars and blue dots are manual cars from the dataset.",
                   "The large green triangle is YOUR predicted car.")
        )
      )
    )
  )
))
