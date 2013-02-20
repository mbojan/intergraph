\name{attrmap}
\alias{attrmap}
\title{Network attribute copying/renaming table}
\usage{
  attrmap(newdf = NULL)
}
\arguments{
  \item{newdf}{data.frame, new set of copy/rename rules,
  see Details}
}
\value{
  If \code{newdf} is NULL, a data frame with the current
  copy/rename rules. Otherwise \code{newdf} are set as new
  rules and the old ones are returned invisibly, much like
  \code{\link{par}}.
}
\description{
  Setting and retrieving rules through which
  network/edge/vertex attributes are copied or renamed when
  converting network objects.
}
\details{
  Different classes for network data use different
  attribute names to store the same information. Some of
  the classes define attributes not used by other classes.
  This function is used to retrieve or set the rules in
  which these attributes are copied, renamed or dropped
  when converting network objects.

  The rules are stored in a data frame with the following
  columns (all of mode character): \describe{
  \item{type}{type, or level of the attribute, one of
  "vertex", "edge" or "network"} \item{fromcls}{name of the
  class which is being coerced} \item{fromattr}{name of the
  "source" attribute} \item{tocls}{name of the class to
  which coercion is being done} \item{toattr}{name of the
  attribute in the result of coercion, or NA} } When
  converting network \code{x}, of class \code{xclass} to
  network \code{y} of class \code{yclass} the coercion
  method looks up the rows in this table for which
  \code{fromcls=xclass} and \code{tocls=yclass}. If network
  \code{x} has any of the attributes listed in the
  \code{fromattr} in the resulting subset of the table
  then, it is renamed to the corresponding value of
  \code{toattr}.  If \code{toattr} is \code{NA} the
  attribute is dropped from the result.
}
\examples{
# Current values
attrmap()
}
\seealso{
  This is used by \code{\link{asIgraph}} and
  \code{\link{as.network}}
}

