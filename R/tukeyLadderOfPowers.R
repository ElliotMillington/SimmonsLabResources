tukeyLadderOfPowers = function(x,
                               start = -3, end = 3, by = 0.025,
                               printResult = FALSE, plotResult = FALSE) {

  testTransform = function(lambda, x) {
    x = sapply(x, lambdaTransform, lambda = lambda)
    return(andersonDarlingTest(x))
  }

  lambdas = seq(start, end, by = by)
  A = sapply(lambdas, testTransform, x = x)
  iMin = which.min(A)

  if (printResult) { print(lambdas[iMin])}
  if (plotResult) { plot(lambdas, A)}

  return(lambdaTransform(x, lambdas[iMin]))
}
