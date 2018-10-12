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
  titlePanel("Experimental Parameter Calculator"),
  
  # Sidebar with dropdown input to select the parameter to be calculated
  sidebarLayout(
    sidebarPanel(
      numericInput("n", "Sample size", NULL, step = 10),
      numericInput("mu", "Effect size in SD\'s", NULL, step = 0.25),
      radioButtons("sig", "Significance level", choices = c("TBD" = NA, ".05" = .05,
        ".01" = .01, ".001" = .001, "Five-sigma" =  2.86*10**-7), inline = TRUE),
      numericInput("power", "Statistical power", NULL, step = .05),
      submitButton("Calculate!"),
      verbatimTextOutput("doc")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      wellPanel(
        verbatimTextOutput("calc")
        )
      )
    )
  )
)