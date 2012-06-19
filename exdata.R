library(intergraph, lib="../bin")
library(igraph)

# directed igraph
g <- igraph::graph( c(2,1, 3,1, 4,1, 5,1, # star
	 6,7, 8,9, # two dyads
	 10,11, 11,12, 12,13, 13,14, 14,12), # stem-leaf
	 n=15, directed=TRUE)
# add some vertex attributes
vl <- letters[seq(1, vcount(g))]
g <- igraph::set.vertex.attribute(g, "label", value=vl)
# add some edge attributes
m <- igraph::get.edgelist(g)
l <- matrix(vl[m], ncol=2)
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
m <- igraph::get.adjacency(exIgraph, sparse=FALSE)
g <- network::network(m, vertex.attr=list(label=V(exIgraph)$label),
    vertex.attrnames="label", directed=TRUE)
network::set.vertex.attribute(g, "vertex.names", value=V(exIgraph)$label)
network::set.edge.attribute(g, "label", igraph::get.edge.attribute(exIgraph, "label"))
exNetwork <- network::network.copy(g)

# copy as a 'network' object through adjacency matrix
m <- igraph::get.adjacency(exIgraph2, sparse=FALSE)
g <- network::network(m, vertex.attr=list(label=V(exIgraph2)$label),
    vertex.attrnames="label", directed=FALSE)
network::set.vertex.attribute(g, "vertex.names", value=V(exIgraph2)$label)
network::set.edge.attribute(g, "label", igraph::get.edge.attribute(exIgraph2, "label"))
exNetwork2 <- network::network.copy(g)

# save objects to files
setwd("data")
save( exIgraph, file="exIgraph.rda")
save( exIgraph2, file="exIgraph2.rda")
save( exNetwork, file="exNetwork.rda")
save( exNetwork2, file="exNetwork2.rda")
