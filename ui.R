library(shiny)
library(shinydashboard)

dashboardPage(skin="green",
        
  dashboardHeader(title = "FWER Calculator"),
  
  dashboardSidebar(
    
    img(src="logo.png",
        width=230),
    
    h2("App settings:"),
    
    sliderInput("confidenceLvl", "Confidence Level:", 1, 100, 95),
    
    radioButtons(
      "errorCorrection", "Error Correction Method:",
      c("Bonferroni", "Benjamini Hochberg")
    )
    
  ),
  
  dashboardBody(
    
    includeCSS("www/custom.css"),
  
    h2(strong("Step 1:"), "Calculate your A/B tests' p-values!"),
    
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
        br(),
        submitButton(text = "Calculate p-value!", icon = NULL),
        width = 9
      ),
      box(
        title = "Your tests' p-values:",
        
        width= 3, height = 255
      )
    ),
    
    h2(strong("Step 2:"), "Enter your tests' p-values in the box below."),
    
    fluidRow(

      box(
        textInput("pVals", "P Values:"),
        width = 12
      )
      
    ),
    
    h2(strong("Step 3:"), "Use your results to make smarter marketing decisions!"),
    
    fluidRow(
      
      box(
        textInput("result", "The statistically significant test results are:"),
        width = 12
      )
      
    )
    
  )
  
)