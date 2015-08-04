shinyServer(function(input, output) {
  
  pScores <- ""
  
  # pvalue calculator
  PValsList <- eventReactive(input$calcButton, {
    
    prob1 <- input$noConv1/input$sampleSize1 ## control
    prob2 <- input$noConv2/input$sampleSize2 ## variant
    
    var1 <- (prob1 * (1-prob1)) / input$sampleSize1
    var2 <- (prob2 * (1-prob2)) / input$sampleSize2
    
    pooledSD <- sqrt( var2 + var1 ) 
    
    zScore <- (prob2 - prob1) / pooledSD
    
    pScore <- round(pnorm(zScore), 3)
    
    if (pScores == "")
      pScores <<- as.character(1 - pScore)
    else
      pScores <<- paste(pScores, ", ", as.character(1 - pScore), sep="")
      
    pScores
  })
  
  #FWER Calculator
  FWERcalc <- eventReactive(input$FWERbutton, {
    
    data <- unlist(strsplit(input$UserPVals, ", "))
    data <- as.numeric(data)
    
    if (input$errorCorrection == "Bonferroni")
      
      results <- p.adjust(data, method = "bonferroni")
      
      paste("Test numbers ", as.character(results[1]), " are significant!", sep="")
    
  })
  
  # reactive functions
  confLvlInput <- reactive({
    
    input$confLvlSetting
    
  })
  
  
  # output values
  output$OutputPVals <- renderText({
    PValsList()
  })
  
  output$result <- renderText({
    FWERcalc()
  })
  
})