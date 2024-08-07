% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predict.R
\name{predict.singleRStaticCountData}
\alias{predict.singleRStaticCountData}
\title{\loadmathjax
Predict method for \code{singleRStaticCountData} class}
\usage{
\method{predict}{singleRStaticCountData}(
  object,
  newdata,
  type = c("response", "link", "mean", "popSize", "contr"),
  se.fit = FALSE,
  na.action = NULL,
  weights,
  cov,
  ...
)
}
\arguments{
\item{object}{an object of \code{singleRStaticCountData} class.}

\item{newdata}{an optional \code{data.frame} containing new data.}

\item{type}{the type of prediction required, possible values are:
\itemize{
\item \code{"response"}-- For matrix containing estimated distributions
parameters.
\item \code{"link"}    -- For matrix of linear predictors.
\item \code{"mean"}    -- For fitted values of both \mjseqn{Y} and
\mjseqn{Y|Y>0}.
\item \code{"contr"}   -- For inverse probability weights (here named for
observation contribution to population size estimate).
\item \code{"popSize"} -- For population size estimation. Note
this results in a call to \code{redoPopEstimation} and it is
usually better to call this function directly.
} by default set to \code{"response"}.}

\item{se.fit}{a logical value indicating whether standard errors should be
computed. Only matters for \code{type} in \code{"response", "mean", "link"}.}

\item{na.action}{does nothing yet.}

\item{weights}{optional vector of weights for \code{type} in \code{"contr", "popSize"}.}

\item{cov}{optional matrix or function or character specifying either
a covariance matrix or a function to compute that covariance matrix.
By default \code{vcov.singleRStaticCountData} can be set to e.g. \code{vcovHC}.}

\item{...}{arguments passed to other functions, for now this only affects
\code{vcov.singleRStaticCountData} method and \code{cov} function.}
}
\value{
Depending on \code{type} argument if one of \code{"response", "link", "mean"}
a matrix with fitted values and possibly standard errors if \code{se.fit}
argument was set to \code{TRUE}, if \code{type} was set to \code{"contr"}
a vector with inverses of probabilities, finally for \code{"popSize"}
an object of class \code{popSizeEstResults} with its own methods containing
population size estimation results.
}
\description{
A method for \code{predict} function, works analogous to \code{predict.glm}
but gives the possibility to get standard errors of
mean/distribution parameters and directly get pop size estimates for new data.
}
\details{
Standard errors are computed with assumption of regression
coefficients being asymptotically normally distributed, if this assumption
holds then each of linear predictors i.e. each row of
\mjseqn{\boldsymbol{\eta}=\boldsymbol{X}_{vlm}\boldsymbol{\beta}}
is asymptotically normally distributed and their variances are expressed by
well known formula. The mean \mjseqn{\mu} and distribution parameters
are then differentiable functions of asymptotically normally distributed
variables and therefore their variances can be computed using (multivariate)
delta method.
}
\seealso{
\code{\link[=redoPopEstimation]{redoPopEstimation()}} \code{\link[stats:summary.glm]{stats::summary.glm()}} \code{\link[=estimatePopsize]{estimatePopsize()}}
}
