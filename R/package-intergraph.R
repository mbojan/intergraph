#' Coercion routines for network data objects in R
#' 
#' This package contains methods for coercion between various classes used to
#' represent network data in .
#' 
#' Functions implemented in this package allow to coerce (i.e., convert) network
#' data between classes provided by other R packages. Currently supported
#' packages are: \pkg{network}, \pkg{igraph}.
#' 
#' The main functions are: \itemize{ \item \code{asNetwork} and its method
#' \code{\link{asNetwork.igraph}} to create objects of class "network".
#' 
#' \item \code{\link{asIgraph}} and its methods to create objects of class
#' "igraph". } See their help pages for more information and examples.
#' 
#' As all the supported packages are written using S3 methods, so are the
#' methods in this package. This may change in the future.
#' 
#' If you find this package useful in your work please cite it. Type
#' \code{citation(package="intergraph")} for the information how to do that.
#' 
#' @name intergraph-package
#' @aliases intergraph-package intergraph
#' @docType package
#' @author Written and maintained by Michal Bojanowski
#' \email{mbojan@@icm.edu.pl}.
#' @keywords package
#' @example examples/package-intergraph.R
NULL
