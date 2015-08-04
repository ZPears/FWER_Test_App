sampleSize1 <- 1000
noConv1 <- 90
sampleSize2 <- 1000
noConv2 <- 110

prob1 <- noConv1/sampleSize1 ## control
prob2 <- noConv2/sampleSize2 ## variant

var1 <- (prob1 * (1-prob1)) / sampleSize1
var2 <- (prob2 * (1-prob2)) / sampleSize2

pooledSD <- sqrt( var2 + var1 ) 

zScore <- (prob2 - prob1) / pooledSD

pScore <- pnorm(zScore)