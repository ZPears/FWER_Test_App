finalCalc <- function(data, errorCorrection, alpha) {
  
  results <- ""

  if (errorCorrection == "Bonferroni") {
    
    alpha_FWER <- alpha / length(data)
    
    for (i in 1:length(data)) {
      
      if (data[i] < alpha_FWER)
        
        results <- paste(results, ", ", i, sep="")
      
    }
    
    
  } else {
    
    numbers <- 1:length(data)
    
    frame <- data.frame(numbers, data)
    
    frame <- frame[order(data),]
    
    for (i in 1:length(frame$data)){
      
      if (frame$data[i] <= (alpha * (i/length(data)))) {
        
        results <- paste(results, ", ", frame$numbers[i], sep="")
        
      }
      
    }
    
  }
  
  if (results == "") {
    
    return("No results were found signficant. Sorry!")
    
  } else if (nchar(results) == 3) {
    
    paste("Only P-Value number ", substr(results, 3, 3), " is significant.")
    
  } else {
    
    paste(
      "P-Values ",
      substr(results, 3, nchar(results)-3),
      " and ",
      substr(results, (nchar(results)), nchar(results)),
      " are significant."
    )
    
  }
  
}

inputError <- function() {
  "Sorry, your results aren't formatted correctly."
}