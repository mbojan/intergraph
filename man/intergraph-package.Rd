\docType{package}
\name{intergraph-package}
\alias{intergraph}
\alias{intergraph-package}
\title{Coercion routines for network data objects in R}
\description{
  This package contains methods for coercion between
  various classes used to represent network data in .
}
\details{
  Functions implemented in this package allow to coerce
  (i.e., convert) network data between classes provided by
  other R packages. Currently supported packages are:
  \pkg{network}, \pkg{igraph}.

  The main functions are: \itemize{ \item \code{as.network}
  and its method \code{\link{as.network.igraph}} to create
  objects of class "network".

  \item \code{\link{asIgraph}} and its methods to create
  objects of class "igraph". } See their help pages for
  more information and examples.

  As all the supported packages are written using S3
  methods, so are the methods in this package. This may
  change in the future.

  If you find this package useful in your work please cite
  it. Type \code{citation(package="intergraph")} for the
  information how to do that.
}
\examples{

# example of converting objects between classes 'network' and 'igraph'

if( require(network) & require(igraph) )
{

  ### convert 'network' -> 'igraph'

  # example network
  summary(exNetwork)

  # convert to igraph
  g <- asIgraph(exNetwork)

  # check if 'exNetwork' and 'g' are the same
  all.equal( as.matrix(exNetwork, "edgelist"), 
    igraph::get.edgelist(g) + 1 )   
    # +1 because igraph's vertex ids start from 0

  # compre results using 'netcompare'
  netcompare(exNetwork, g)

  ### convert 'igraph' -> 'network'

  # example network: same as above but of class 'igraph'
  summary(exIgraph)

  # convert to network class
  gg <- as.network(exIgraph)

  # check if they are the same
  all.equal( get.edgelist(exIgraph), as.matrix(gg, "edgelist"))
  # compre results using 'netcompare'
  netcompare(exIgraph, g)
}
}
\author{
  Written and maintained by Michal Bojanowski
  \email{mbojan@icm.edu.pl}.
}
\keyword{package}

