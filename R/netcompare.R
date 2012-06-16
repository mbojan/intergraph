#============================================================================ 
# comparing and testing for (near) equality of networks
#
# Result of comparison:
#
# 1. computed network-level comparisons
#
# 2. built-in network-level comparisons
#
# 3. attributes
#
# 3a. attribute presence
#
# 3b. identical common attributes
#
# NOTE: Makes use of non-exported generic functions


compareEdges <- function(target, current, use.names=FALSE)
{
  tr <- try(getS3method("as.matrix", class=class(target)), silent=TRUE)
  if(inherits(tr, "try-error"))
    stop("cannot find 'as.matrix' method for class ", dQuote(class(target)))
  tr <- try(getS3method("as.matrix", class=class(current)), silent=TRUE)
  if(inherits(tr, "try-error"))
    stop("cannot find 'as.matrix' method for class ", dQuote(class(current)))
  mtar <- as.matrix(target, "adjacency")
  mcur <- as.matrix(current, "adjacency")
  # compare matrices (no dimnames)
  if(use.names)
    all.equal(mtar, mcur)
  else all.equal( structure(mtar, dimnames=NULL), structure(mcur,
            dimnames=NULL) )
}


# compare common components of a list (by name)
# return a list of all.equal results
compareAlist <- function(target, current)
{
  # common components
  nams <- intersect(names(target), names(current))
  if( length(nams) == 0 )
    return(as.character(NA))
  rval <- lapply(nams, function(n) all.equal( target[[n]], current[[n]]) )
  names(rval) <- nams
  rval
}



# given a lists of attributes compare

compareAttributes <- function(target, current)
{
  # compare number of attributes
  rval <- list()
  rval$n <- c(target=length(target), current=length(current))
  # compare names
  pre <- list()
  u <- union(names(target), names(current))
  r <- t(sapply(u, function(a)
      c( a %in% names(target),
          a %in% names(current) )
      ))
  pre <- c(pre, list(r))
  pre <- do.call("rbind", pre)
  dimnames(pre) <- list(rownames(pre), c("target", "current"))
  rval$presence <- pre
  rval$bycomp <- compareAlist(target, current)
  structure(rval, class="netcomparea")
}



netcompare <- function(target, current, test=FALSE, ...)
{
  # trivial checks
  rval <- list()
  # class
  rval$class <- c(target=class(target), current=class(current))
  # number of vertices
  rval$vcount <- c(target=igVcount(target), current=igVcount(current))
  # number of edges
  rval$ecount <- c( target=igEcount(target), current=igEcount(current))
  # directedness
  rval$directed <- c( target=igDirected(target), current=igDirected(current))
  # compare adjacency matrices
  rval$identical_am <- compareEdges(target, current)
  # compare attributes
  targeta <- dumpAttr(target)
  currenta <- dumpAttr(current)
  rval$network <- compareAttributes( targeta$network, currenta$network)
  rval$vertex <- compareAttributes( targeta$vertex, currenta$vertex)
  rval$edge <- compareAttributes( targeta$edge, currenta$edge)
  rval <- structure(rval, class="netcompare")
  if(test)
    compareTest(rval)
  else return(rval)
}


print.netcomparea <- function(x, ...)
{
  m <- do.call("rbind", lapply( x[c("n", "presence")], format))
  print(m, quote=FALSE)
  cat("Common attributes comparison (TRUE=identical)\n")
  if( identical( x$bycomp, as.character(NA)) )
  {
    cat("   No common attributes\n")
  } else
  {
    l <- sapply(x$bycomp, paste, collapse=", ")
    for(i in seq(along=l))
      cat(names(l)[i], ":", l[i], fill=TRUE, labels="   ")
  }
}





print.netcompare <- function(x, ...)
{
  cat("\n")
  cat("Identical adjacency matrices:\n")
  cat( paste(x$identical_am, collapse=", "), "\n", fill=TRUE, labels="   ")
  cat("Network-level features:\n")
  m <- do.call("rbind", lapply(x[c("vcount", "ecount", "directed")], format))
  print(m, quote=FALSE)
  cat("\n")
  cat("Presence of network-level attributes\n")
  print(x$network)
  cat("\n")
  cat("Presence of vertex-level attributes\n")
  print(x$vertex)
  cat("\n")
  cat("Presence of edge-level attributes\n")
  print(x$edge)
}



compareTest <- function(object)
{
  stopifnot(inherits(object, "netcompare"))
  rval <- logical()
  rval["adjacency"] <- object$identical_am
  rval["vcount"] <- object$vcount[1] == object$vcount[2]
  rval["ecount"] <- object$ecount[1] == object$ecount[2]
  rval["directed"] <- object$directed[1] == object$directed[2]
  all(rval)
}


