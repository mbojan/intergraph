\name{as.network.data.frame}
\alias{as.network.data.frame}
\alias{as.network.igraph}
\title{Convert objects to class "network"}
\description{Convert objects to class "network"}
\usage{
\method{as.network}{data.frame}(x, directed = TRUE, vertices = NULL, ...)
\method{as.network}{igraph}(x, attrmap=attrmap(), ...)
}
\arguments{
  \item{x}{an R object to be coerced, see Details for the description of
  available methods}
  \item{attrmap}{data.frame with attribute copy/rename rules, see
  \code{\link{attrmap}}}
  \item{directed}{logical, whether the created network should be directed}
  \item{vertices}{NULL or data frame, optional data frame containing
  vertex attributes}
  \item{\dots}{other arguments from/to other methods}
}
\details{
This is a generic function which dispatches on argument \code{x}.  It creates
objects of class "network" from other R objects.

The method for data frames is inspired by the similar function in package
\pkg{igraph}: \code{\link[igraph]{graph.data.frame}}.  It assumes that first
two columns of \code{x} constitute  an edgelist.  The remaining columns are
interpreted as edge attributes. Optional argument \code{vertices} allows for
including vertex attributes.  The first column is assumed to vertex id, the
same that is used in the edge list. The remaining colums are interpreted as
vertex attributes.

The method for objects of class "igraph" takes the network of that class and
converts it to data frames using \code{\link{asDF}}. The network is recreated
in class "network" using \code{as.network.data.frame}. The function currently
does not support bipartite "igraph" networks.
}
\value{
Object of class "network".
}
\seealso{
\code{\link[igraph]{graph.data.frame}}

\code{\link{as.igraph}} for conversion in the other direction.
}
\examples{
# require package 'network' as 'as.network' generic is defined there
if(require(network, quietly=TRUE))
{
  ### demonstrating method for data frames
  l <- asDF(exNetwork)
  g <- as.network( l$edges, vertices=l$vertexes)
  stopifnot(all.equal(g, exNetwork))

  ### method for igraph objects
  ig <- as.network(exIgraph)
  identical( as.numeric(as.matrix(g, "adjacency")),
            as.numeric(as.matrix(ig, "adjacency")))
}
}
