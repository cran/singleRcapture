% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimatePopsize.R
\name{estimatePopsize}
\alias{estimatePopsize}
\alias{estimatePopsize.default}
\title{Single source capture-recapture models}
\usage{
estimatePopsize(formula, ...)

\method{estimatePopsize}{default}(
  formula,
  data,
  model = c("ztpoisson", "ztnegbin", "ztgeom", "zotpoisson", "ztoipoisson",
    "oiztpoisson", "ztHurdlepoisson", "Hurdleztpoisson", "zotnegbin", "ztoinegbin",
    "oiztnegbin", "ztHurdlenegbin", "Hurdleztnegbin", "zotgeom", "ztoigeom", "oiztgeom",
    "ztHurdlegeom", "ztHurdlegeom", "zelterman", "chao"),
  ratioReg = FALSE,
  weights = NULL,
  subset = NULL,
  naAction = NULL,
  method = c("optim", "IRLS"),
  popVar = c("analytic", "bootstrap", "noEst"),
  controlMethod = NULL,
  controlModel = NULL,
  controlPopVar = NULL,
  modelFrame = TRUE,
  x = FALSE,
  y = TRUE,
  contrasts = NULL,
  offset,
  ...
)
}
\arguments{
\item{formula}{formula for the model to be fitted, only applied to the "main"
linear predictor. Only single response models are available.}

\item{...}{additional optional arguments passed to other methods eg.
\code{estimatePopsizeFit}.}

\item{data}{data frame or object coercible to data.frame class containing
data for the regression and population size estimation.}

\item{model}{model for regression and population estimate full description in \code{\link[=singleRmodels]{singleRmodels()}}.}

\item{ratioReg}{Not yet implemented}

\item{weights}{optional object of prior weights used in fitting the model.
Can be used to specify number of occurrences of rows in data see \code{\link[=controlModel]{controlModel()}}}

\item{subset}{a logical vector indicating which observations should be used
in regression and population size estimation. It will be evaluated on \code{data} argument provided on call.}

\item{naAction}{Not yet implemented.}

\item{method}{method for fitting values currently supported: iteratively
reweighted least squares (\code{IRLS}) and maximum likelihood (\code{optim}).}

\item{popVar}{a method of constructing confidence interval either analytic
or bootstrap. Bootstrap confidence interval type may be specified in
\code{controlPopVar.} There is also the third possible value of \code{noEst}
which skips the population size estimate all together.}

\item{controlMethod}{a list indicating parameters to use in fitting the model
may be constructed with \code{singleRcapture::controlMethod} function.
More information included in \code{\link[=controlMethod]{controlMethod()}}.}

\item{controlModel}{a list indicating additional formulas for regression
(like formula for inflation parameter/dispersion parameter) may be
constructed with \code{singleRcapture::controlModel} function.
More information will eventually be included in \code{\link[=controlModel]{controlModel()}}.}

\item{controlPopVar}{a list indicating parameters to use in estimating variance
of population size estimation may be constructed with
\code{singleRcapture::controlPopVar} function.
More information included in \code{\link[=controlPopVar]{controlPopVar()}}.}

\item{modelFrame, x, y}{logical value indicating whether to return model matrix,
dependent vector and model matrix as a part of output.}

\item{contrasts}{not yet implemented.}

\item{offset}{a matrix of offset values with number of columns matching the
number of distribution parameters providing offset values to each of
linear predictors.}
}
\value{
Returns an object of class \code{c("singleRStaticCountData", "singleR", "glm", "lm")}
with type \code{list} containing:\cr
\itemize{
\item{\code{y} -- Vector of dependent variable if specified at function call.}
\item{\code{X} -- Model matrix if specified at function call.}
\item{\code{formula} -- A list with formula provided on call and additional formulas specified in \code{controlModel}.}
\item{\code{call} -- Call matching original input.}
\item{\code{coefficients} -- A vector of fitted coefficients of regression.}
\item{\code{control} -- A list of control parameters for \code{controlMethod} and \code{controlModel}, \code{controlPopVar} is included in populationSize.}
\item{\code{model} -- Model which estimation of population size and regression was built, object of class family.}
\item{\code{deviance} -- Deviance for the model.}
\item{\code{priorWeights} -- Prior weight provided on call.}
\item{\code{weights} -- If \code{IRLS} method of estimation was chosen weights returned by \code{IRLS}, otherwise same as \code{priorWeights}.}
\item{\code{residuals} -- Vector of raw residuals.}
\item{\code{logL} -- Logarithm likelihood obtained at final iteration.}
\item{\code{iter} -- Numbers of iterations performed in fitting or if \code{stats::optim} was used number of call to loglikelihood function.}
\item{\code{dfResiduals} -- Residual degrees of freedom.}
\item{\code{dfNull} -- Null degrees of freedom.}
\item{\code{fittValues} -- Data frame of fitted values for both mu (the expected value) and lambda (Poisson parameter).}
\item{\code{populationSize} -- A list containing information of population size estimate.}
\item{\code{modelFrame} -- Model frame if specified at call.}
\item{\code{linearPredictors} -- Vector of fitted linear predictors.}
\item{\code{sizeObserved} -- Number of observations in original model frame.}
\item{\code{terms} -- terms attribute of model frame used.}
\item{\code{contrasts} -- contrasts specified in function call.}
\item{\code{naAction} -- naAction used.}
\item{\code{which} -- list indicating which observations were used in regression/population size estimation.}
\item{\code{fittingLog} -- log of fitting information for \code{"IRLS"} fitting if specified in \code{controlMethod}.}
}
}
\description{
\code{estimatePopsize} first fits appropriate (v)glm model and
then estimates full (observed and unobserved) population size.
In this types of models it is assumed that the response vector
(i.e. the dependent variable) corresponds to the number of times a given unit
was observed in the source.
Population size is then usually estimated by Horvitz-Thompson type estimator:

\mjsdeqn{\hat{N} = \sum_{k=1}^{N}\frac{I_{k}}{\mathbb{P}(Y_{k}>0)} = 
\sum_{k=1}^{N_{obs}}\frac{1}{1-\mathbb{P}(Y_{k}=0)}}

where \mjseqn{I_{k}=I_{Y_{k} > 0}} are indicator
variables, with value 1 if kth unit was observed at least once and 0 otherwise.
}
\details{
The generalized linear model is characterized by equation
\mjsdeqn{\boldsymbol{\eta}=\boldsymbol{X}\boldsymbol{\beta}}
where \mjseqn{\boldsymbol{X}} is the (lm) model matrix.
The vector generalized linear model is similarly characterized by equations
\mjsdeqn{\boldsymbol{\eta}_{k}=\boldsymbol{X}_{k}\boldsymbol{\beta}_{k}}
where \mjseqn{\boldsymbol{X}_{k}} is a (lm) model
matrix constructed from appropriate formula
(specified in \code{controlModel} parameter).

The \mjseqn{\boldsymbol{\eta}} is then a vector constructed as:

\mjsdeqn{\boldsymbol{\eta}=\begin{pmatrix}
\boldsymbol{\eta}_{1} \cr 
\boldsymbol{\eta}_{2} \cr
\dotso \cr
\boldsymbol{\eta}_{p}
\end{pmatrix}^{T}}

and in cases of models in our package the (vlm) model matrix
is constructed as a block matrix:

\mjsdeqn{\boldsymbol{X}_{vlm}=
\begin{pmatrix}
\boldsymbol{X}_{1} & \boldsymbol{0} &\dotso &\boldsymbol{0}\cr
\boldsymbol{0} & \boldsymbol{X}_{2} &\dotso &\boldsymbol{0}\cr
\vdots & \vdots & \ddots & \vdots\cr
\boldsymbol{0} & \boldsymbol{0} &\dotso &\boldsymbol{X}_{p}
\end{pmatrix}}

this differs from convention in \code{VGAM} package (if we only consider our
special cases of vglm models) but this is just a convention and does not
affect the model, this convention is taken because it makes fitting with
IRLS (explanation of algorithm in \code{\link[=estimatePopsizeFit]{estimatePopsizeFit()}}) algorithm easier.
(If \code{constraints} matrixes in \code{vglm} match the ones we implicitly
use the \code{vglm} model matrix differs with respect to order of
\code{kronecker} multiplication of \code{X} and \code{constraints}.)
In this package we use observed likelihood to fit regression models.

As mentioned above usually the population size estimation is done via:
\mjsdeqn{\hat{N} = \sum_{k=1}^{N}\frac{I_{k}}{\mathbb{P}(Y_{k}>0)} = 
\sum_{k=1}^{N_{obs}}\frac{1}{1-\mathbb{P}(Y_{k}=0)}}

where \mjseqn{I_{k}=I_{Y_{k} > 0}} are indicator variables,
with value 1 if kth unit was observed at least once and 0 otherwise.
The \mjseqn{\mathbb{P}(Y_{k}>0)} are estimated by maximum likelihood.

The following assumptions are usually present when using
the method of estimation described above:
\enumerate{
\item The specified regression model is correct. This entails linear
relationship between independent variables and dependent ones and
dependent variable being generated by appropriate distribution.
\item No unobserved heterogeneity. If this assumption is broken there
are some possible (admittedly imperfect) workarounds see details in
\code{\link[=singleRmodels]{singleRmodels()}}.
\item The population size is constant in relevant time frame.
\item Depending on confidence interval construction (asymptotic) normality
of \mjseqn{\hat{N}} statistic is assumed.
}

There are two ways of estimating variance of estimate \mjseqn{\hat{N}},
the first being \code{"analytic"} usually done by application of
law of total variance to \mjseqn{\hat{N}}:

\mjsdeqn{\text{var}(\hat{N})=\mathbb{E}\left(\text{var}
\left(\hat{N}|I_{1},\dots,I_{n}\right)\right)+
\text{var}\left(\mathbb{E}(\hat{N}|I_{1},\dots,I_{n})\right)}

and then by \mjseqn{\delta} method to
\mjseqn{\hat{N}|I_{1},\dots I_{N}}:

\mjsdeqn{\mathbb{E}\left(\text{var}
\left(\hat{N}|I_{1},\dots,I_{n}\right)\right)=
\left.\left(\frac{\partial(N|I_1,\dots,I_N)}{\partial\boldsymbol{\beta}}\right)^{T}
\text{cov}\left(\boldsymbol{\beta}\right)
\left(\frac{\partial(N|I_1,\dots,I_N)}{\partial\boldsymbol{\beta}}\right)
\right|_{\boldsymbol{\beta}=\hat{\boldsymbol{\beta}}}}

and the \mjseqn{\text{var}\left(\mathbb{E}(\hat{N}|I_{1},\dots,I_{n})\right)}
term may be derived analytically (if we assume independence of
observations) since \mjseqn{\hat{N}|I_{1},\dots,I_{n}}
is just a constant.

In general this gives us:
\mjsdeqn{
\begin{aligned}
\text{var}\left(\mathbb{E}(\hat{N}|I_{1},\dots,I_{n})\right)&=
\text{var}\left(\sum_{k=1}^{N}\frac{I_{k}}{\mathbb{P}(Y_{k}>0)}\right)\cr
&=\sum_{k=1}^{N}\text{var}\left(\frac{I_{k}}{\mathbb{P}(Y_{k}>0)}\right)\cr
&=\sum_{k=1}^{N}\frac{1}{\mathbb{P}(Y_{k}>0)^{2}}\text{var}(I_{k})\cr
&=\sum_{k=1}^{N}\frac{1}{\mathbb{P}(Y_{k}>0)^{2}}\mathbb{P}(Y_{k}>0)(1-\mathbb{P}(Y_{k}>0))\cr
&=\sum_{k=1}^{N}\frac{1}{\mathbb{P}(Y_{k}>0)}(1-\mathbb{P}(Y_{k}>0))\cr
&\approx\sum_{k=1}^{N}\frac{I_{k}}{\mathbb{P}(Y_{k}>0)^{2}}(1-\mathbb{P}(Y_{k}>0))\cr
&=\sum_{k=1}^{N_{obs}}\frac{1-\mathbb{P}(Y_{k}>0)}{\mathbb{P}(Y_{k}>0)^{2}}
\end{aligned}
}

Where the approximation on 6th line appears because in 5th line we sum over
all units, that includes unobserved units, since \mjseqn{I_{k}} are
independent and \mjseqn{I_{k}\sim b(\mathbb{P}(Y_{k}>0))} the 6th line
is an unbiased estimator of the 5th line.

The other method for estimating variance is \code{"bootstrap"}, but since
\mjseqn{N_{obs}=\sum_{k=1}^{N}I_{k}} is also a random variable bootstrap
will not be as simple as just drawing \mjseqn{N_{obs}} units from data
with replacement and just computing \mjseqn{\hat{N}}.

Method described above is referred to in literature as \code{"nonparametric"}
bootstrap (see \code{\link[=controlPopVar]{controlPopVar()}}), due to ignoring variability in observed
sample size it is likely to underestimate variance.

A more sophisticated bootstrap procedure may be described as follows:
\enumerate{
\item Compute the probability distribution as:
\mjsdeqn{
\frac{\hat{\boldsymbol{f}}_{0}}{\hat{N}}, 
\frac{\boldsymbol{f}_{1}}{\hat{N}}, 
\dots,
\frac{\boldsymbol{f}_{\max{y}}}{\hat{N}}}
where \mjseqn{\boldsymbol{f}_{n}} denotes observed
marginal frequency of units being observed exactly n times.
\item Draw \mjseqn{\hat{N}} units from the distribution above
(if \mjseqn{\hat{N}} is not an integer than draw
\mjseqn{\lfloor\hat{N}\rfloor + b(\hat{N}-\lfloor\hat{N}\rfloor)}),
where \mjseqn{\lfloor\cdot\rfloor} is the floor function.
\item Truncated units with \mjseqn{y=0}.
\item If there are covariates draw them from original data with replacement from
uniform distribution. For example if unit drawn to new data has
\mjseqn{y=2} choose one of covariate vectors from original data that
was associated with unit for which was observed 2 times.
\item Regress \mjseqn{\boldsymbol{y}_{new}} on \mjseqn{\boldsymbol{X}_{vlm new}}
and obtain \mjseqn{\hat{\boldsymbol{\beta}}_{new}}, with starting point
\mjseqn{\hat{\boldsymbol{\beta}}} to make it slightly faster, use them
to compute \mjseqn{\hat{N}_{new}}.
\item Repeat 2-5 unit there are at least \code{B} statistics are obtained.
\item Compute confidence intervals based on \code{alpha} and \code{confType}
specified in \code{\link[=controlPopVar]{controlPopVar()}}.
}

To do step 1 in procedure above it is convenient to first draw binary vector of length
\mjseqn{\lfloor\hat{N}\rfloor + b(\hat{N}-\lfloor\hat{N}\rfloor)} with probability
\mjseqn{1-\frac{\hat{\boldsymbol{f}}_{0}}{\hat{N}}}, sum elements in that vector to
determine the sample size and then draw sample of this size uniformly from the data.

This procedure is known in literature as \code{"semiparametric"} bootstrap
it is necessary to assume that the have a correct estimate
\mjseqn{\hat{N}} in order to use this type of bootstrap.

Lastly there is \code{"paramteric"} bootstrap where we assume that the
probabilistic model used to obtain \mjseqn{\hat{N}} is correct the
bootstrap procedure may then be described as:
\enumerate{
\item Draw \mjseqn{\lfloor\hat{N}\rfloor + b(\hat{N}-\lfloor\hat{N}\rfloor)}
covariate information vectors with replacement from data according to
probability distribution that is proportional to: \mjseqn{N_{k}},
where \mjseqn{N_{k}} is the contribution of kth unit i.e.
\mjseqn{\dfrac{1}{\mathbb{P}(Y_{k}>0)}}.
\item Determine \mjseqn{\boldsymbol{\eta}} matrix using estimate
\mjseqn{\hat{\boldsymbol{\beta}}}.
\item Generate \mjseqn{\boldsymbol{y}} (dependent variable)
vector using \mjseqn{\boldsymbol{\eta}} and
probability mass function associated with chosen model.
\item Truncated units with \mjseqn{y=0} and construct
\mjseqn{\boldsymbol{y}_{new}} and \mjseqn{\boldsymbol{X}_{vlm new}}.
\item Regress \mjseqn{\boldsymbol{y}_{new}} on \mjseqn{\boldsymbol{X}_{vlm new}}
and obtain \mjseqn{\hat{\boldsymbol{\beta}}_{new}}
use them to compute \mjseqn{\hat{N}_{new}}.
\item Repeat 1-5 unit there are at least \code{B} statistics are obtained.
\item Compute confidence intervals based on \code{alpha} and \code{confType}
specified in \code{\link[=controlPopVar]{controlPopVar()}}
}

It is also worth noting that in the \code{"analytic"} method \code{estimatePopsize}
only uses "standard" covariance matrix estimation. It is possible that improper
covariance matrix estimate is the only part of estimation that has its assumptions
violated. In such cases post-hoc procedures are implemented in this package
to address this issue.

Lastly confidence intervals for \mjseqn{\hat{N}} are computed
(in analytic case) either by assuming that it follows a normal distribution
or that variable \mjseqn{\ln(N-\hat{N})}
follows a normal distribution.

These estimates may be found using either \code{summary.singleRStaticCountData}
method or \code{popSizeEst.singleRStaticCountData} function. They're labelled as
\code{normal} and \code{logNormal} respectively.
}
\examples{
\donttest{
# Model from 2003 publication 
# Point and interval estimation of the
# population size using the truncated Poisson regression mode
# Heijden, Peter GM van der et al. (2003)
model <- estimatePopsize(
   formula = capture ~ gender + age + nation, 
   data = netherlandsimmigrant, 
   model = ztpoisson
)
summary(model)
# Graphical presentation of model fit
plot(model, "rootogram")
# Statistical test
# see documentation for summary.singleRmargin
summary(marginalFreq(model), df = 1, "group")

# We currently support 2 methods of numerical fitting
# (generalized) IRLS algorithm and via stats::optim
# the latter one is faster when fitting negative binomial models 
# (and only then) due to IRLS having to numerically compute
# (expected) information matrixes, optim is also less reliable when
# using alphaFormula argument in controlModel
modelNegBin <- estimatePopsize(
    formula = TOTAL_SUB ~ ., 
    data = farmsubmission, 
    model = ztnegbin, 
    method = "optim"
)
summary(modelNegBin)
summary(marginalFreq(modelNegBin))

# More advanced call that specifies additional formula and shows
# in depth information about fitting procedure
pseudoHurdleModel <- estimatePopsize(
    formula = capture ~ nation + age,
    data = netherlandsimmigrant,
    model = Hurdleztgeom,
    method = "IRLS",
    controlMethod = controlMethod(verbose = 5),
    controlModel = controlModel(piFormula = ~ gender)
)
summary(pseudoHurdleModel)
# Assessing model fit
plot(pseudoHurdleModel, "rootogram")
summary(marginalFreq(pseudoHurdleModel), "group", df = 1)


# A advanced input with additional information for fitting procedure and
# additional formula specification and different link for inflation parameter.
Model <- estimatePopsize(
 formula = TOTAL_SUB ~ ., 
 data = farmsubmission, 
 model = oiztgeom(omegaLink = "cloglog"), 
 method = "IRLS", 
 controlMethod = controlMethod(
   stepsize = .85, 
   momentumFactor = 1.2,
   epsilon = 1e-10, 
   silent = TRUE
 ),
 controlModel = controlModel(omegaFormula = ~ C_TYPE + log_size)
)
summary(marginalFreq(Model), df = 18 - length(Model$coefficients))
summary(Model)
}
}
\references{
General single source capture recapture literature:

Zelterman, Daniel (1988). ‘Robust estimation in truncated discrete distributions
with application to capture-recapture experiments’. In: Journal of statistical
planning and inference 18.2, pp. 225–237.

Heijden, Peter GM van der et al. (2003). ‘Point and interval estimation of the
population size using the truncated Poisson regression model’.
In: Statistical Modelling 3.4, pp. 305–322. doi: 10.1191/1471082X03st057oa.

Cruyff, Maarten J. L. F. and Peter G. M. van der Heijden (2008). ‘Point and
Interval Estimation of the Population Size Using a Zero-Truncated Negative
Binomial Regression Model’. In: Biometrical Journal 50.6, pp. 1035–1050.
doi: 10.1002/bimj.200810455

Böhning, Dankmar and Peter G. M. van der Heijden (2009). ‘A covariate adjustment
for zero-truncated approaches to estimating the size of hidden and
elusive populations’. In: The Annals of Applied Statistics 3.2, pp. 595–610.
doi: 10.1214/08-AOAS214.

Böhning, Dankmar, Alberto Vidal-Diez et al. (2013). ‘A Generalization of
Chao’s Estimator for Covariate Information’. In: Biometrics 69.4, pp. 1033–
1042. doi: 10.1111/biom.12082

Böhning, Dankmar and Peter G. M. van der Heijden (2019). ‘The identity of the
zero-truncated, one-inflated likelihood and the zero-one-truncated likelihood
for general count densities with an application to drink-driving in Britain’.
In: The Annals of Applied Statistics 13.2, pp. 1198–1211.
doi: 10.1214/18-AOAS1232.

Navaratna WC, Del Rio Vilas VJ, Böhning D. Extending Zelterman's approach for
robust estimation of population size to zero-truncated clustered Data.
Biom J. 2008 Aug;50(4):584-96. doi: 10.1002/bimj.200710441.

Böhning D. On the equivalence of one-inflated zero-truncated and zero-truncated
one-inflated count data likelihoods. Biom J. 2022 Aug 15. doi: 10.1002/bimj.202100343.

Böhning, D., Friedl, H. Population size estimation based upon zero-truncated,
one-inflated and sparse count data. Stat Methods Appl 30, 1197–1217 (2021).
doi: 10.1007/s10260-021-00556-8

Bootstrap:

Zwane, PGM EN and Van der Heijden, Implementing the parametric bootstrap in capture-recapture
models with continuous covariates 2003 Statistics & probability letters 65.2 pp 121-125

Norris, James L and Pollock, Kenneth H Including model uncertainty in estimating variances
in multiple capture studies 1996 in Environmental and Ecological Statistics 3.3 pp 235-244

Vector generalized linear models:

Yee, T. W. (2015). Vector Generalized Linear and Additive Models:
With an Implementation in R. New York, USA: Springer. ISBN 978-1-4939-2817-0.
}
\seealso{
\code{\link[stats:glm]{stats::glm()}} -- For more information on generalized linear models.

\code{\link[stats:optim]{stats::optim()}} -- For more information on \code{optim} function used in
\code{optim} method of fitting regression.

\code{\link[=controlMethod]{controlMethod()}} -- For control parameters related to regression.

\code{\link[=controlPopVar]{controlPopVar()}} -- For control parameters related to population size estimation.

\code{\link[=controlModel]{controlModel()}} -- For control parameters related to model specification.

\code{\link[=estimatePopsizeFit]{estimatePopsizeFit()}} -- For more information on fitting procedure in
\code{esitmate_popsize}.

\code{\link[=popSizeEst]{popSizeEst()}} \code{\link[=redoPopEstimation]{redoPopEstimation()}} -- For extracting population size
estimation results are applying post-hoc procedures.

\code{\link[=summary.singleRStaticCountData]{summary.singleRStaticCountData()}} -- For summarizing important information about the
model and population size estimation results.

\code{\link[=marginalFreq]{marginalFreq()}} -- For information on marginal frequencies and comparison
between observed and fitted quantities.

\code{\link[VGAM:vglm]{VGAM::vglm()}} -- For more information on vector generalized linear models.

\code{\link[=singleRmodels]{singleRmodels()}} -- For description of various models.
}
\author{
Piotr Chlebicki, Maciej Beręsewicz

\loadmathjax
}
