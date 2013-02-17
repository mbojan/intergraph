#'Sample network structure
#'
#'An examples of networks together with network, edge and vertex attributes
#'used primarly for testing. The same networks are stored in objects of class
#'\code{network} and \code{igraph}.
#'
#'Vertices and edges has attribute \code{label}. For vertices these are simply
#'letters from "a" to "o". For edges these are two-letter sequences
#'corresponding to the neightboring vertices, i.e. the label for the edges
#'linking nodes "b" and "c" will be "bc". The order is irrelevant.
#'
#'In the \code{exNetwork} object the \code{label} attribute is also copied to
#'the \code{vertex.names} attribute to facilitate plotting.
#'
#'The \code{exIgraph} object has additional graph attribute \code{layout} so
#'that by default Fruchterman-Reingold placement is used for plotting.
#'
#'@name exNetwork
#'@aliases exNetwork exIgraph exNetwork2 exIgraph2
#'@docType data
#'@format \describe{ \item{exNetwork,exNetwork2}{is of class \code{network}}
#'\item{exIgraph,exIgraph2}{is of class \code{igraph}} } Objects
#'\code{exNetwork} and \code{exIgraph} store directed version of the network.
#'Objects \code{exNetwork2} and \code{exIgraph2} store the undirected version:
#'all direction information from the edges is removed.
#'
#'The network consists of 15 vertices and 11 edges. \itemize{ \item Vertex 1 is
#'an isolate.  \item Vertices 2-6 constitute a star with vertex 2 as a center.
#'\item Vertices 7-8 and 9-10 make two dyads \item Vertcies 11, 12, 13,14 and
#'15 make a stem-and-leaf network. }
#'@keywords datasets
#'@examples
#'
#'if(require(network, quietly=TRUE) ) print(exNetwork)
#'if( require(igraph, quietly=TRUE) ) print(exIgraph)
#'
#'
#'# showing-off 'network' versions
#'if(require(network, quietly=TRUE))
#'{
#'  op <- par(mar=c(1,1,1,1))
#'  layout( matrix(1:2, 1, 2, byrow=TRUE) )
#'  # need to change the family to device default because of faulty 'igraph'
#'  plot(exNetwork, main="Directed, class 'network'", displaylabels=TRUE)
#'  plot(exNetwork2, main="Undirected, class 'network'", displaylabels=TRUE)
#'  par(op)
#'}
#'
#'# not running because of a bug in 'igraph': plot.igraph wants to set default
#'# font for vertex labels to 'serif', which is not supported on all devices
#'\dontrun{
#'# showing-off 'igraph' versions
#'if(require(igraph, quietly=TRUE))
#'{
#'  op <- par(mar=c(1,1,1,1))
#'  layout( matrix(1:2, 1, 2, byrow=TRUE) )
#'  plot(exIgraph, main="Directed, class 'igraph'")
#'  plot(exIgraph2, main="Undirected, class 'igraph'")
#'  par(op)
#'}
#'}
#'
#'# The data was generated with the following code
#'\dontrun{
#'# directed igraph
#'g <- igraph::graph( c(2,1, 3,1, 4,1, 5,1, # star
#'	 6,7, 8,9, # two dyads
#'	 10,11, 11,12, 12,13, 13,14, 14,12), # stem-leaf
#'	 n=14, directed=TRUE)
#'# add some vertex attributes
#'vl <- letters[seq(1, vcount(g))]
#'g <- igraph::set.vertex.attribute(g, "label", value=vl)
#'# add some edge attributes
#'m <- igraph::get.edgelist(g)
#'l <- matrix(vl[m+1], ncol=2)
#'el <- apply(l, 1, paste, collapse="")
#'g <- igraph::set.edge.attribute(g, "label", value=el)
#'g <- igraph::set.graph.attribute(g, "layout", igraph::layout.fruchterman.reingold)
#'rm(vl, l, m, el)
#'exIgraph <- g
#'
#'# undirected igraph
#'exIgraph2 <- igraph::as.undirected(exIgraph)
#'exIgraph2 <- igraph::set.edge.attribute(exIgraph2, "label", 
#'	value=igraph::get.edge.attribute(exIgraph, "label"))
#'
#'
#'# copy as a 'network' object through adjacency matrix
#'m <- igraph::get.adjacency(exIgraph)
#'g <- network::network(m, vertex.attr=list(label=vattr(exIgraph, "label")),
#'    vertex.attrnames="label", directed=TRUE)
#'network::set.vertex.attribute(g, "vertex.names", value=vattr(exIgraph, "label"))
#'network::set.edge.attribute(g, "label", igraph::get.edge.attribute(exIgraph, "label"))
#'exNetwork <- network::network.copy(g)
#'
#'# copy as a 'network' object through adjacency matrix
#'m <- igraph::get.adjacency(exIgraph2)
#'g <- network::network(m, vertex.attr=list(label=vattr(exIgraph2, "label")),
#'    vertex.attrnames="label", directed=FALSE)
#'network::set.vertex.attribute(g, "vertex.names", value=vattr(exIgraph2, "label"))
#'network::set.edge.attribute(g, "label", igraph::get.edge.attribute(exIgraph2, "label"))
#'exNetwork2 <- network::network.copy(g)
#'}
#'
NULL





#'Coercion routines for network data objects in R
#'
#'This package contains methods for coercion between various classes used to
#'represent network data in .
#'
#'Functions implemented in this package allow to coerce (i.e., convert) network
#'data between classes provided by other R packages. Currently supported
#'packages are: \pkg{network}, \pkg{igraph}.
#'
#'The main functions are: \itemize{ \item \code{as.network} and its method
#'\code{\link{as.network.igraph}} to create objects of class "network".
#'
#'\item \code{\link{as.igraph}} and its methods to create objects of class
#'"igraph". } See their help pages for more information and examples.
#'
#'As all the supported packages are written using S3 methods, so are the
#'methods in this package. This may change in the future.
#'
#'If you find this package useful in your work please cite it. Type
#'\code{citation(package="intergraph")} for the information how to do that.
#'
#'@name intergraph-package
#'@aliases intergraph-package intergraph
#'@docType package
#'@author Written and maintained by Michal Bojanowski
#'\email{mbojan@@icm.edu.pl}.
#'@keywords package
#'@examples
#'
#'# example of converting objects between classes 'network' and 'igraph'
#'
#'if( require(network) & require(igraph) )
#'{
#'
#'  ### convert 'network' -> 'igraph'
#'
#'  # example network
#'  summary(exNetwork)
#'
#'  # convert to igraph
#'  g <- as.igraph(exNetwork)
#'
#'  # check if 'exNetwork' and 'g' are the same
#'  all.equal( as.matrix(exNetwork, "edgelist"), 
#'    igraph::get.edgelist(g) + 1 )   
#'    # +1 because igraph's vertex ids start from 0
#'
#'  # compre results using 'netcompare'
#'  netcompare(exNetwork, g)
#'
#'  ### convert 'igraph' -> 'network'
#'
#'  # example network: same as above but of class 'igraph'
#'  summary(exIgraph)
#'
#'  # convert to network class
#'  gg <- as.network(exIgraph)
#'
#'  # check if they are the same
#'  all.equal( get.edgelist(exIgraph), as.matrix(gg, "edgelist"))
#'  # compre results using 'netcompare'
#'  netcompare(exIgraph, g)
#'}
#'
NULL



