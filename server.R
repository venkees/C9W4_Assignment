library(shiny)
shinyServer(function(input, output) {
  model1 <- lm(RTEN~PHYS, USJudgeRatings)
  model2 <- lm(RTEN~PHYS+CONT, USJudgeRatings)
  
  model1pred <- reactive({
    PHYSinput <- input$sliderPHYS
    predict(model1, newdata = data.frame(PHYS = PHYSinput))
  })
  
  model2pred <- reactive({
    PHYSinput <- input$sliderPHYS
    CONTinput <- input$sliderCONT
    predict(model2, newdata = data.frame(PHYS = PHYSinput, CONT = CONTinput))
  })
  
    output$plot1 <- renderPlotly({
    PHYSinput <- input$sliderPHYS
    plot_ly(USJudgeRatings, x=~USJudgeRatings$PHYS, y=~USJudgeRatings$RTEN, 
            type = "scatter", name = "Given Retention Score") %>%
                layout(title = "Plotly chart", 
                       xaxis = list(title = "Physical Ability"), 
                       yaxis = list(title = "Judge Retention Score")) %>%
      add_trace(x=~USJudgeRatings$PHYS, y = ~fitted(model1), 
                mode = "lines", name = "Model Output (PHYS)")  %>%
      add_trace(x=~PHYSinput, y= ~model1pred(), marker = list(size =10,
                color = "red"), name = "Model 1 Predicted Score") %>%
      add_trace(x=~PHYSinput, y= ~model2pred(), marker = list(size =10,
                color = "yellow"), name = "Model 2 Predicted Score")
    
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
  
    
})
