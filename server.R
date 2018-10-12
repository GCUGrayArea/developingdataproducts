#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
require(stats)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  params <- reactive({c(input$n, input$mu, as.numeric(input$sig), input$power)})
  missing <- reactive({
    if(sum(complete.cases(params())) != 3) {"ERROR! NEED EXACTLY ONE NULL PARAMETER!"}
    else if(is.na(input$n)) {
      answer <- power.t.test(n = NULL, delta = input$mu, sig.level = as.numeric(input$sig),
        power = input$power)$n
      paste0("Your chosen experiment requires a sample size of ", ceiling(answer), ".")
    } else if(is.na(input$mu)) {
        answer <- power.t.test(n = input$n, delta = NULL,
          sig.level = as.numeric(input$sig), power = input$power)$delta
        paste("Your experiment will be able to detect an effect size of",
          round(answer, digits = 1), "standard deviations.")
    } else if(is.na(as.numeric(input$sig))) {
        answer <- power.t.test(n = input$n, delta = input$mu, sig.level = NULL,
          power = input$power)$sig.level
        paste0("Your experiment will deliver a significance level of ", answer,".")
    } else if(is.na(input$power)) {
        answer <- power.t.test(n = input$n, delta = input$mu,
          sig.level = as.numeric(input$sig), power = NULL)$power
        paste0("Your experiment will deliver statistical power of ",
          round(answer, digits = 3), ".")
    }
    
  })
  output$calc <- renderText({
    missing()
  })
  output$doc <- renderText({
    "This app will give you the required sample size, detectable effect size,\n significance level or statistical power of a t-test experiment given the other \nthree values. It will return its own error message if you provide an \nunusable number of values, or R-generated error messages if the inputs result in an \ninsoluble equation. Hit the 'Calculate!' button with three fields filled in to \nfind the fourth value."
  })
  
})
