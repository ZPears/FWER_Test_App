library(shiny)
library(shinydashboard)

dashboardPage(skin="green",
        
  dashboardHeader(title = "FWER Calculator"),
  
  dashboardSidebar(
    
    img(src="logo.png",
        width=230),
    
    h2("App settings:"),
    
    sliderInput("confLvlSetting", "Confidence Level:", 1, 100, 95),
    
    radioButtons(
      "errorCorrection", "Error Correction Method:",
      c("Bonferroni", "Benjamini Hochberg")
    )
    
  ),
  
  dashboardBody(
  
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
        actionButton(inputId = "calcButton", label = "Calculate p-value!",
                     icon = icon("gear")),
        width = 9
      ),
      box(
        title = "Your tests' p-values:",
        textOutput("OutputPVals"),
        width= 3, height = 285
      )
    ),
    
    h2(strong("Step 2:"), "Enter your tests' p-values in the box below."),
    
    fluidRow(

      box(
        textInput("UserPVals", "P Values:"),
        width = 12,
        actionButton(inputId = "FWERbutton", label = "Find Signficant Results!",
                     icon = icon("gear"))
      )
      
    ),
    
    h2(strong("Step 3:"), "Use your results to make smarter marketing decisions!"),
    
    fluidRow(
      
      box(
        textOutput("result"),
        width = 12
      )
    
    ),
    
    includeCSS("www/custom.css")
    
  )
  
)