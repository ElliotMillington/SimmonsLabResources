#' Tukey Ladder of Powers Transformation
#'
#' @description
#' Returns a numeric vector transformed using Tukey's Ladder of powers to be more approximately normal.
#'
#' @param x A vector of numeric values to be transformed
#' @param start The lowest value of lambda to be tested
#' @param end The highest value of lambda to be tested
#' @param by The step value between lambdas
#' @param printResult Whether or not to print the chosen value of lambda
#' @param plotResult Whether or not to plot the Anderson-Darling A values
#'
#' @return A numeric vector
#' @export
#'
#' @examples
#' old_vector = stats::rnorm(100)
#' transformed_vector = tukeyLadderOfPowers(old_vector)
#'
tukeyLadderOfPowers = function(x,
                               start = -3, end = 3, by = 0.025,
                               printResult = FALSE, plotResult = FALSE) {

  lambdaTransform = function(x, lambda) {
    if (lambda > 0) {
      return(x^lambda)
    }
    if (lambda == 0) {
      return(log(x))
    }
    return(-x^lambda)
  }

  andersonDarlingTest = function (x) {
    x = sort(x[stats::complete.cases(x)])
    n = length(x)

    logp1 = stats::pnorm( (x-mean(x))/stats::sd(x), log.p=TRUE)
    logp2 = stats::pnorm(-(x-mean(x))/stats::sd(x), log.p=TRUE)
    h = (2*seq(1:n)-1)*(logp1+rev(logp2))

    A = -n-mean(h)
    return(A)
  }

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
