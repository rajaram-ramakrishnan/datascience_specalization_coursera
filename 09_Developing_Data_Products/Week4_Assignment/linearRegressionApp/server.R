#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(recipes)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
  lm_formula <- reactive({
      mtcars %>%
          recipe() %>%
          update_role(mpg, new_role ="outcome") %>%
          update_role(!!!input$cols, new_role = "predictor") %>%
          formula()
  })
  
  lm_reg <- reactive({
      lm(lm_formula(), data = mtcars)
  })
  
  output$RegOut  <- renderPrint({
      summary(lm_reg())
  })
   
  output$RegPlot <- renderPlot({
    par(mfrow = c(2,2))
    plot(lm_reg())
  })
   
  output$plotOut <- renderPlot({
    p <- ggplot(data=mtcars, aes_string(x= input$x, y= input$y)) + geom_point()
    p <- p + labs(x =input$x, y = input$y)
    if(input$color != "None") {
      p <- p + aes_string(color = input$color)
    }
    
    if (input$size != "None") {
      p <- p + aes_string(size = input$size)
    }
    
    if(input$smooth){
      p <- p + geom_smooth()
    }
    
    facets <- paste(input$fac_row,"~",input$fac_col)
    if (facets != ".~."){
      p <- p + facet_grid(facets)
    }
    p
  }) 
  
})
