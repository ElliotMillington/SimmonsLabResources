andersonDarlingTest = function (x) {
  x = sort(x[complete.cases(x)])
  n = length(x)

  logp1 = pnorm( (x-mean(x))/sd(x), log.p=TRUE)
  logp2 = pnorm(-(x-mean(x))/sd(x), log.p=TRUE)
  h = (2*seq(1:n)-1)*(logp1+rev(logp2))

  A = -n-mean(h)
  return(A)
}
