library(shiny)
library(plotly)

shinyUI(fluidPage(
  titlePanel("Predict Lawyers ratings of state judges in the US Superior Court"),
  sidebarLayout(
    sidebarPanel(
      h5("Help: This is an interactive app. On selecting values for Physical ablity and Number of Contacts
         , the predictive model is executed and the retention score for judges is determined. The plot and the 
         predicted values can be seen on the right panel as you change the input values using the slider bar"), 
      sliderInput("sliderPHYS", "Physical ability score", 5, 10, value = 7),
      sliderInput("sliderCONT", "Number of Contacts with Judge", 5, 11, value = 7.5)
    ),
    mainPanel(
      h5("Help: Hover your mouse over the chart to view the values"),
      plotlyOutput("plot1"),
      h3("Model 1 - Judge Retention Score based on predictor Physical Ability"),
      textOutput("pred1"),
      h3("Model 2 - Judge Retention Score based on predictor Physical Ability & Number of Contacts"),
      textOutput("pred2")
    )                                                                    
    )
)
)
