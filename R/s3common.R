
#============================================================================ 
# common functions

igVcount <- function(x, ...) UseMethod("igVcount")

#' @export
igVcount.igraph <- function(x, ...)
  igraph::vcount(x)

#' @export
igVcount.network <- function(x, ...)
  network::network.size(x)

igEcount <- function(x, ...) UseMethod("igEcount")

#' @export
igEcount.igraph <- function(x, ...)
  igraph::ecount(x)

#' @export
igEcount.network <- function(x, ...)
  network::network.edgecount(x)

igDirected <- function(x) UseMethod("igDirected")

#' @export
igDirected.igraph <- function(x) {
  igraph::is_directed(x)
}

#' @export
igDirected.network <- function(x) {
  network::is.directed(x)
}


