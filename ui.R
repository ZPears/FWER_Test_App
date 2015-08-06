library(shiny)
library(shinydashboard)

dashboardPage(skin="green",
        
  dashboardHeader(title = "FWER Calculator"),
  
  dashboardSidebar(
    br(),
    
    img(src="logo.png",
        width=230),
    
    br(), br(),
    
    h2("App settings:"),
    
    sliderInput("confLvlSetting", "Confidence Level:", 90, 100, 95),
    
    radioButtons(
      "errorCorrection", "Error Correction Method:",
      c("BH (False Discovery Rate)", "Bonferroni")
    )
    
  ),
  
  dashboardBody(
  
    div(id = "header",
      h3("If you do a lot of A/B testing, then you need to take your tests' familywise error rate (FWER) into account before making marketing decisions."),
      h3("Greenough's ", strong("FWER Calculcator"), "can help!")
    ),
    
    h2(strong("Step 1:"), "Calculate your A/B tests' p-values!"),
    
    br(),
    
    p("If you already know your tests' p-values, you can skip to step 2."),
    
    fluidRow(
      
      box(
        title = "A/B Test p-value calculator:",
        box(
          numericInput("sampleSize1", "Sample Size (Variation A)", 0),
          numericInput("noConv1", "Number of Conversions (Variation A)", 0)
        ),
        box(
        numericInput("sampleSize2", "Sample Size (Variation B)", 0),
        numericInput("noConv2", "Number of Conversions (Variation B)", 0)
        ),
        br(),
        actionButton(inputId = "calcButton", label = "Calculate P-Value!",
                     icon = icon("gear")),
        width = 9
      ),
      box(
        title = "Your tests' p-values will appear here (separated by commas):",
        textOutput("OutputPVals"),
        width= 3, height = 285
      )
    ),
    
    h2(strong("Step 2:"), 'Copy and paste your test p-values (separated by commas) 
       in the box below!'),
    
    br(),
    
    p("If you want, you can edit your desired confidence level and error correction method 
       from the menu on the left."),
    
    fluidRow(

      box(
        title = "P-Values:",
        textInput("UserPVals", label = NULL, value = "For Example: 0.01, 0.02, 0.03, 0.04"),
        width = 12,
        actionButton(inputId = "FWERbutton", label = "Calculate Results!",
                     icon = icon("gear"))
      )
      
    ),
    
    h2(strong("Step 3:"), "Use your results to make smarter marketing decisions!"),
    
    br(),
    
    fluidRow(
    
      box(
        title = "The Statistically Significant Test P-Values Are:",
        textOutput("result"),
        width = 12
      )
    
    ),
    
    includeCSS("www/custom.css")
    
  )
  
)