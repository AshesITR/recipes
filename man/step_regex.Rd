% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/regex.R
\name{step_regex}
\alias{step_regex}
\alias{tidy.step_regex}
\title{Create Dummy Variables using Regular Expressions}
\usage{
step_regex(
  recipe,
  ...,
  role = "predictor",
  trained = FALSE,
  pattern = ".",
  options = list(),
  result = make.names(pattern),
  input = NULL,
  skip = FALSE,
  id = rand_id("regex")
)

\method{tidy}{step_regex}(x, ...)
}
\arguments{
\item{recipe}{A recipe object. The step will be added to the
sequence of operations for this recipe.}

\item{...}{A single selector functions to choose which variable
will be searched for the pattern. The selector should resolve
into a single variable. See \code{\link[=selections]{selections()}} for more
details. For the \code{tidy} method, these are not currently
used.}

\item{role}{For a variable created by this step, what analysis
role should they be assigned?. By default, the function assumes
that the new dummy variable column created by the original
variable will be used as a predictor in a model.}

\item{trained}{A logical to indicate if the quantities for
preprocessing have been estimated.}

\item{pattern}{A character string containing a regular
expression (or character string for \code{fixed = TRUE}) to be
matched in the given character vector. Coerced by
\code{as.character} to a character string if possible.}

\item{options}{A list of options to \code{\link[=grepl]{grepl()}} that
should not include \code{x} or \code{pattern}.}

\item{result}{A single character value for the name of the new
variable. It should be a valid column name.}

\item{input}{A single character value for the name of the
variable being searched. This is \code{NULL} until computed by
\code{\link[=prep.recipe]{prep.recipe()}}.}

\item{skip}{A logical. Should the step be skipped when the
recipe is baked by \code{\link[=bake.recipe]{bake.recipe()}}? While all operations are baked
when \code{\link[=prep.recipe]{prep.recipe()}} is run, some operations may not be able to be
conducted on new data (e.g. processing the outcome variable(s)).
Care should be taken when using \code{skip = TRUE} as it may affect
the computations for subsequent operations}

\item{id}{A character string that is unique to this step to identify it.}

\item{x}{A \code{step_regex} object.}
}
\value{
An updated version of \code{recipe} with the new step
added to the sequence of existing steps (if any). For the
\code{tidy} method, a tibble with columns \code{terms} (the
selectors or variables selected) and \code{result} (the
new column name).
}
\description{
\code{step_regex} creates a \emph{specification} of a recipe step that will
create a new dummy variable based on a regular expression.
}
\examples{
library(modeldata)
data(covers)

rec <- recipe(~ description, covers) \%>\%
  step_regex(description, pattern = "(rock|stony)", result = "rocks") \%>\%
  step_regex(description, pattern = "ratake families")

rec2 <- prep(rec, training = covers)
rec2

with_dummies <- bake(rec2, new_data = covers)
with_dummies
tidy(rec, number = 1)
tidy(rec2, number = 1)
}
\concept{dummy_variables}
\concept{preprocessing}
\concept{regular_expressions}
\keyword{datagen}
