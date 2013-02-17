
if(require(network, quietly=TRUE) ) print(exNetwork)
if( require(igraph, quietly=TRUE) ) print(exIgraph)


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
if(FALSE) {
# showing-off 'igraph' versions
if(require(igraph, quietly=TRUE))
{
  op <- par(mar=c(1,1,1,1))
  layout( matrix(1:2, 1, 2, byrow=TRUE) )
  plot(exIgraph, main="Directed, class 'igraph'")
  plot(exIgraph2, main="Undirected, class 'igraph'")
  par(op)
}
}

# The data was generated with the following code
if(FALSE) {
# directed igraph
g <- igraph::graph( c(2,1, 3,1, 4,1, 5,1, # star
	 6,7, 8,9, # two dyads
	 10,11, 11,12, 12,13, 13,14, 14,12), # stem-leaf
	 n=14, directed=TRUE)
# add some vertex attributes
vl <- letters[seq(1, vcount(g))]
g <- igraph::set.vertex.attribute(g, "label", value=vl)
# add some edge attributes
m <- igraph::get.edgelist(g)
l <- matrix(vl[m+1], ncol=2)
el <- apply(l, 1, paste, collapse="")
g <- igraph::set.edge.attribute(g, "label", value=el)
g <- igraph::set.graph.attribute(g, "layout", igraph::layout.fruchterman.reingold)
rm(vl, l, m, el)
exIgraph <- g

# undirected igraph
exIgraph2 <- igraph::as.undirected(exIgraph)
exIgraph2 <- igraph::set.edge.attribute(exIgraph2, "label", 
	value=igraph::get.edge.attribute(exIgraph, "label"))


# copy as a 'network' object through adjacency matrix
m <- igraph::get.adjacency(exIgraph)
g <- network::network(m, vertex.attr=list(label=vattr(exIgraph, "label")),
    vertex.attrnames="label", directed=TRUE)
network::set.vertex.attribute(g, "vertex.names", value=vattr(exIgraph, "label"))
network::set.edge.attribute(g, "label", igraph::get.edge.attribute(exIgraph, "label"))
exNetwork <- network::network.copy(g)

# copy as a 'network' object through adjacency matrix
m <- igraph::get.adjacency(exIgraph2)
g <- network::network(m, vertex.attr=list(label=vattr(exIgraph2, "label")),
    vertex.attrnames="label", directed=FALSE)
network::set.vertex.attribute(g, "vertex.names", value=vattr(exIgraph2, "label"))
network::set.edge.attribute(g, "label", igraph::get.edge.attribute(exIgraph2, "label"))
exNetwork2 <- network::network.copy(g)
}

