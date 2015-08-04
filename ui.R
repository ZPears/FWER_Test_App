library(shiny)
library(shinydashboard)

dashboardPage(skin="green",
  dashboardHeader(title = "FWER Calculator"),
  
  dashboardSidebar(
    
    sliderInput("confidenceLvl", "Choose Confidence Level:", 1, 100, 95)
  ),
  
  dashboardBody(
  
    h2("Make smarter decisions. Calculate your A/B test p-values!"),
    
    fluidRow(
      box(
        title = "A/B Test p-value calculator",
        box(
          numericInput("sampleSize1", "Sample Size (Variation A)", 0),
          numericInput("noConv1", "Number of Conversions (Variation A)", 0)
        ),
        box(
        numericInput("sampleSize2", "Sample Size (Variation B)", 0),
        numericInput("noConv2", "Number of Conversions (Variation B)", 0)
        ),
        width = 9
      ),
      box(
        title = "Your tests' p-values:",
        
        width= 3
      )
    ),
    
    fluidRow(
      box(
        title = "Or, if you already know all your p Values, enter them here:",
        textInput("pVals", "P Value:")
      )
      
    )
    
  )
  
)