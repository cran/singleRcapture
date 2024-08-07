% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/updates.R
\name{redoPopEstimation}
\alias{redoPopEstimation}
\alias{redoPopEstimation.singleRStaticCountData}
\title{Updating population size estimation results.}
\usage{
redoPopEstimation(object, newdata, ...)

\method{redoPopEstimation}{singleRStaticCountData}(
  object,
  newdata,
  cov,
  weights,
  coef,
  control,
  popVar,
  offset,
  weightsAsCounts,
  ...
)
}
\arguments{
\item{object}{object for which update of population size estimation results will be done.}

\item{newdata}{optional \code{data.frame} with new data for pop size estimation.}

\item{...}{additional optional arguments, currently not used in \code{singleRStaticCountData} class method.}

\item{cov}{an updated covariance matrix estimate.}

\item{weights}{optional vector of weights to use in population size estimation.}

\item{coef}{optional vector of coefficients of regression on which to base
population size estimation. If missing it is set to \code{coef(object)}.}

\item{control}{similar to \code{controlPopVar} in \code{\link[=estimatePopsize]{estimatePopsize()}}.
If missing set to controls provided on call to \code{object}.}

\item{popVar}{similar to \code{popVar} in \code{\link[=estimatePopsize]{estimatePopsize()}}.
If missing set to \code{"analytic"}.}

\item{offset}{offset argument for new data}

\item{weightsAsCounts}{for \code{singleRStaticCountData} method used to specify
whether weights should be treated as number of occurrences for rows in data}
}
\value{
An object of class \code{popSizeEstResults} containing updated
population size estimation results.
}
\description{
A function that applies all post-hoc procedures that were taken
(such as heteroscedastic consistent covariance matrix estimation or bias
reduction) to population size estimation and standard error estimation.
}
\details{
\loadmathjax

Any non specified arguments will be inferred from the \code{object}
}
\examples{
# Create simple model
Model <- estimatePopsize(
  formula = capture ~ nation + gender, 
  data = netherlandsimmigrant, 
  model = ztpoisson, 
  method = "IRLS"
)
# Apply heteroscedasticity consistent covariance matrix estimation
require(sandwich)
cov <- vcovHC(Model, type = "HC3")
summary(Model, cov = cov,
popSizeEst = redoPopEstimation(Model, cov = cov))
# Compare to results with usual covariance matrix estimation
summary(Model)

## get confidence interval with larger significance level
redoPopEstimation(Model, control = controlPopVar(alpha = .000001))
}
