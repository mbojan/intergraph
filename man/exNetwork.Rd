\name{exNetwork}
\alias{exNetwork}
\alias{exIgraph}
\alias{exNetwork2}
\alias{exIgraph2}
\docType{data}
\title{Sample network structure}
\description{
An examples of networks together with network, edge and vertex attributes used
primarly for testing. The same networks are stored in objects of class
\code{network} and \code{igraph}.
}
\usage{
exNetwork
exIgraph
exNetwork2
exIgraph2
}
\format{
\describe{
  \item{exNetwork,exNetwork2}{is of class \code{network}}
  \item{exIgraph,exIgraph2}{is of class \code{igraph}}
}
Objects \code{exNetwork} and \code{exIgraph} store directed version of the
network. Objects \code{exNetwork2} and \code{exIgraph2} store the undirected
version: all direction information from the edges is removed.

The network consists of 15 vertices and 11 edges.
\itemize{
  \item Vertex 1 is an isolate.
  \item Vertices 2-6 constitute a star with vertex 2 as a center.
  \item Vertices 7-8 and 9-10 make two dyads
  \item Vertcies 11, 12, 13,14 and 15 make a stem-and-leaf network.
}
}
\details{
Vertices and edges has attribute \code{label}. For vertices these are simply
letters from "a" to "o". For edges these are two-letter sequences corresponding
to the neightboring vertices, i.e. the label for the edges linking nodes "b"
and "c" will be "bc". The order is irrelevant.

In the \code{exNetwork} object the \code{label} attribute is also copied to the
\code{vertex.names} attribute to facilitate plotting.

The \code{exIgraph} object has additional graph attribute \code{layout} so that
by default Fruchterman-Reingold placement is used for plotting.
}
\examples{
if(require(network, quietly=TRUE) ) print(exNetwork)
if( require(igraph0, quietly=TRUE) ) print(exIgraph)


# showing-off 'network' versions
if(require(network, quietly=TRUE))
{
  op <- par(mar=c(1,1,1,1))
  layout( matrix(1:2, 1, 2, byrow=TRUE) )
  # need to change the family to device default because of faulty 'igraph'
  plot(exNetwork, main="Directed, class 'network'", displaylabels=TRUE)
  plot(exNetwork2, main="Undirected, class 'network'", displaylabels=TRUE)
  par(op)
}

# not running because of a bug in 'igraph': plot.igraph wants to set default
# font for vertex labels to 'serif', which is not supported on all devices
\dontrun{
# showing-off 'igraph' versions
if(require(igraph0, quietly=TRUE))
{
  op <- par(mar=c(1,1,1,1))
  layout( matrix(1:2, 1, 2, byrow=TRUE) )
  plot(exIgraph, main="Directed, class 'igraph'")
  plot(exIgraph2, main="Undirected, class 'igraph'")
  par(op)
}
}

# The data was generated with the following code
\dontrun{
# directed igraph
g <- igraph0::graph( c(2,1, 3,1, 4,1, 5,1, # star
	 6,7, 8,9, # two dyads
	 10,11, 11,12, 12,13, 13,14, 14,12), # stem-leaf
	 n=14, directed=TRUE)
# add some vertex attributes
vl <- letters[seq(1, vcount(g))]
g <- igraph0::set.vertex.attribute(g, "label", value=vl)
# add some edge attributes
m <- igraph0::get.edgelist(g)
l <- matrix(vl[m+1], ncol=2)
el <- apply(l, 1, paste, collapse="")
g <- igraph0::set.edge.attribute(g, "label", value=el)
g <- igraph0::set.graph.attribute(g, "layout", igraph0::layout.fruchterman.reingold)
rm(vl, l, m, el)
exIgraph <- g

# undirected igraph
exIgraph2 <- igraph0::as.undirected(exIgraph)
exIgraph2 <- igraph0::set.edge.attribute(exIgraph2, "label", 
	value=igraph0::get.edge.attribute(exIgraph, "label"))


# copy as a 'network' object through adjacency matrix
m <- igraph0::get.adjacency(exIgraph)
g <- network::network(m, vertex.attr=list(label=vattr(exIgraph, "label")),
    vertex.attrnames="label", directed=TRUE)
network::set.vertex.attribute(g, "vertex.names", value=vattr(exIgraph, "label"))
network::set.edge.attribute(g, "label", igraph0::get.edge.attribute(exIgraph, "label"))
exNetwork <- network::network.copy(g)

# copy as a 'network' object through adjacency matrix
m <- igraph0::get.adjacency(exIgraph2)
g <- network::network(m, vertex.attr=list(label=vattr(exIgraph2, "label")),
    vertex.attrnames="label", directed=FALSE)
network::set.vertex.attribute(g, "vertex.names", value=vattr(exIgraph2, "label"))
network::set.edge.attribute(g, "label", igraph0::get.edge.attribute(exIgraph2, "label"))
exNetwork2 <- network::network.copy(g)
}
}
\keyword{datasets}
