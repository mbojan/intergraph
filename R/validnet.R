# Validating data frames containing edge database (edge list with edge
# attributes) and vertex data bases (vertices with vertex attributes)


# Validates edge list
validateEL <- function(x)
{
  # must be data.frame
  stopifnot(inherits(x, "data.frame"))
  # at least two columns
  if (ncol(x) < 2) {
      stop("the data frame should contain at least two columns")
  }
  # Handling NAs
  if (any(is.na(x[,1:2]))) {
      warning("In first two columns of `x' `NA' elements were replaced with string \"NA\"")
      x[,1:2][is.na(x[,1:2])] <- "NA"
  }
  x
}


# validate vertex database
validateVDB <- function(x)
{
  stopifnot(inherits(x, "data.frame"))
  # duplicated vertex ids
  dups <- duplicated(x[,1])
  if( any(dups) )
    stop(paste("duplicated ids in vertex db:", paste(x[dups,1], collapse=", ")))
  # Handling NAs
  isna <- is.na(x[,1])
  if (any(isna))
  {
      warning("in `vertices[,1]' `NA' elements were replaced with string \"NA\"")
      x[isna, 1] <- "NA"
  }
}




validNetDB <- function(edb, vdb)
{
  edb <- validEL(edb)
  vdb <- validVDB(vdb)
  # TODO ids in el missing in vdb
}







