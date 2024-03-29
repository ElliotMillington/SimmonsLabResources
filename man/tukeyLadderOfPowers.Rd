% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tukeyLadderOfPowers.R
\name{tukeyLadderOfPowers}
\alias{tukeyLadderOfPowers}
\title{Tukey Ladder of Powers Transformation}
\usage{
tukeyLadderOfPowers(
  x,
  start = -3,
  end = 3,
  by = 0.025,
  printResult = FALSE,
  plotResult = FALSE
)
}
\arguments{
\item{x}{A vector of numeric values to be transformed}

\item{start}{The lowest value of lambda to be tested}

\item{end}{The highest value of lambda to be tested}

\item{by}{The step value between lambdas}

\item{printResult}{Whether or not to print the chosen value of lambda}

\item{plotResult}{Whether or not to plot the Anderson-Darling A values}
}
\value{
A numeric vector
}
\description{
Returns a numeric vector transformed using Tukey's Ladder of powers to be more approximately normal.
}
\examples{
old_vector = stats::rnorm(100)
transformed_vector = tukeyLadderOfPowers(old_vector)

}
