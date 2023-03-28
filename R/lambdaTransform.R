lambdaTransform = function(x, lambda) {
  if (lambda > 0) {
    return(x^lambda)
  }
  if (lambda == 0) {
    return(log(x))
  }
  return(-x^lambda)
}
