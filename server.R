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
    
    results <- ""
    
    data <- unlist(strsplit(input$UserPVals, ", "))
    data <- as.numeric(data)
    
    if (input$errorCorrection == "Bonferroni") {
      
      alpha_FWER <- alphaInput() / length(data)
      
      for (i in 1:length(data)) {
        
        if (data[i] < alpha_FWER)
          
          results <- paste(results, i, ", ", sep="")  
        
      }
      
      paste("Your tests' familywise error rate (FWER) is ", 
            as.character(round(alpha_FWER, 4)), 
            ". Your significant tests are numbers ", results, sep="")
      
    } else {
      
      numbers <- 1:length(data)
      
      frame <- data.frame(numbers, data)
      
      frame <- frame[order(data),]
      
      for (i in 1:length(frame$data)){
        
        if (frame$data[i] <= (alphaInput() * (i/length(data)))) {
          
          results <- paste(results, frame$numbers[i], ", ", sep="")
            
        }
        
      }
      
      paste("Your tests' false discovery rate has been controlled. 
            Your significant test results are: ", results, sep="")
      
    }
    
  })
  
  # reactive functions
  alphaInput <- reactive({
    
    (100 - input$confLvlSetting) * 0.01
    
  })
  
  
  # output values
  output$OutputPVals <- renderText({
    PValsList()
  })
  
  output$result <- renderText({
    FWERcalc()
  })
  
  output$alpha_FWER <- renderText({
    as.character(round(alpha_FWER, 4))
  })
  
})