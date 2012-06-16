#============================================================================ 
# generowanie zbiorów danych

# gdzie zapisywac dane
outdir <- file.path("..", "data")

# lista (z dim) z testowymi zbiorami danych
# n <- c("directed", "hyper", "loops", "multiple", "bipartite")
# dl <- vector( 2^length(n), mode="list")
# dim(dl) <- rep(2, length(n))
# dn <- rep(list(as.character(c(FALSE, TRUE))), length(n))
# names(dn) <- n
# dimnames(dl) <- dn
# exampleData <- dl
# rm(dl, dn, n)



#============================================================================ 
# proste sieci jednomodalne

### directed igraph
g <- igraph::graph( c(2,1, 3,1, 4,1, 5,1, # star
	 6,7, 8,9, # two dyads
	 10,11, 11,12, 12,13, 13,14, 14,12), # stem-leaf
	 n=14, directed=TRUE)
# add some vertex attributes
vl <- letters[seq(1, igraph::vcount(g))]
g <- igraph::set.vertex.attribute(g, "label", value=vl)
# add some edge attributes
m <- igraph::get.edgelist(g)
l <- matrix(vl[m+1], ncol=2)
el <- apply(l, 1, paste, collapse="")
g <- igraph::set.edge.attribute(g, "label", value=el)
# graph attribute 'layout'
g <- igraph::set.graph.attribute(g, "layout", igraph::layout.fruchterman.reingold)
rm(vl, l, m, el)
exIgraph <- g




### undirected igraph
exIgraph2 <- igraph::as.undirected(exIgraph)
exIgraph2 <- igraph::set.edge.attribute(exIgraph2, "label", 
	value=igraph::get.edge.attribute(exIgraph, "label"))





### 'network' version of the two igraph networks above



# copy as a 'network' object through adjacency matrix
m <- igraph::get.adjacency(exIgraph)
g <- network::network(m,
            vertex.attr=list(label=igraph::get.vertex.attribute(exIgraph, "label")),
            directed=igraph::is.directed(exIgraph))
network::set.vertex.attribute(g, "vertex.names", value=igraph::get.vertex.attribute(exIgraph, "label"))
network::set.edge.attribute(g, "label", igraph::get.edge.attribute(exIgraph, "label"))
exNetwork <- network::network.copy(g)





# copy as a 'network' object through adjacency matrix
m <- igraph::get.adjacency(exIgraph2)
g <- network::network(m, vertex.attr=list(label=igraph::get.vertex.attribute(exIgraph2, "label")),
    vertex.attrnames="label", directed=FALSE)
network::set.vertex.attribute(g, "vertex.names", value=igraph::get.vertex.attribute(exIgraph2, "label"))
network::set.edge.attribute(g, "label", igraph::get.edge.attribute(exIgraph2, "label"))
exNetwork2 <- network::network.copy(g)



#============================================================================ 
# hypergraph

# incidence matrix
im <- matrix(0, nrow=7, ncol=4)
im[1:2, 1] <- c(-1,1)
im[3:4, 2] <- c(-1,1)
im[1:3, 3] <- c(-1,-1,1)
im[5:6, 4] <- c(-1,1)

# directed
hnet <- network::network(im, matrix.type="incidence", directed=TRUE,
                         hyper=TRUE)
# undirected
hnetu <- network::network(im, matrix.type="incidence", directed=FALSE,
                         hyper=TRUE, loops=TRUE)

# node attribute
hnet <- network::set.vertex.attribute(hnet, "label", 
                                      value=letters[seq(1, network::network.size(hnet))])

hnetu <- network::set.vertex.attribute(hnetu, "label", 
                                      value=letters[seq(1, network::network.size(hnet))])


exNetworkHyper <- hnet
exNetworkHyper2 <- hnetu



# NOTE adding edge attribute does not seem to work...
# sp <- apply(im, 2, function(x)
#             {
#               a <- network::get.vertex.attribute(hnet, "label")
#               paste(a[ which(x == -1) ], collapse="")
#             } )
# ep <- apply(im, 2, function(x)
#             {
#               a <- network::get.vertex.attribute(hnet, "label")
#               paste(a[ which(x == 1) ], collapse="")
#             } )
# hnet <- network::set.edge.attribute(hnet, "label", paste(sp, ep, sep="-"))
# network::get.edge.attribute(hnet, "label")



#============================================================================ 
# networks with multiple ties

# NOTE supplying a matrix with multiple ties but not setting the attribute
# multiple is accepted: i.e. multiple ties are there, but not "recognized"

el <- matrix(c(1,2, 2,3, 3,1, 1,2), ncol=2, byrow=TRUE)


# network
net <- network::network(el, directed=FALSE)
net2 <- network::network(el, directed=FALSE, multiple=TRUE)
net3 <- network::network(el, directed=TRUE, multiple=TRUE)
if(FALSE)
{
network::print.network(net)
network::print.network(net2)
network::is.multiplex(net)
network::as.matrix.network(net, "edgelist")
network::as.matrix.network(net, "adjacency")
network::as.matrix.network(net2, "adjacency") # NOTE not supported
}
exNetworkMultiple <-net3
exNetworkMultiple2 <- net2

# igraph
exIgraphMultiple <- igraph::graph.edgelist(el, directed=TRUE)
igraph::print.igraph(exIgraphMultiple)
igraph::is.multiple(exIgraphMultiple)
exIgraphMultiple2 <- igraph::as.undirected(exIgraphMultiple)

#============================================================================ 
# networks with loops

# igraph
exIgraphLoops <- igraph::add.edges(exIgraph, c(1,1))
igraph::print.igraph(exIgraphLoops)
igraph::is.loop(exIgraphLoops)

exIgraphLoops2 <- igraph::add.edges(exIgraph2, c(1,1))


# network
exNetworkLoops <- network::add.edges(exNetwork, 1, 1)
exNetworkLoops2 <- network::add.edges(exNetwork2, 1, 1)




#============================================================================ 
# bipartite networks

# igraph: only undirected bipartite graphs are supported

# igraph
exIgraphBipartite <- igraph::graph.bipartite(rep(0:1, 2:3), c(0,2, 0,4, 1,3, 1,4))
igraph::E(exIgraphBipartite)$label <- letters[ seq(1, igraph::ecount(exIgraphBipartite)) ]

igraph::is.directed(exIgraphBipartite)

# network
m <- matrix(0, nrow=2, ncol=3)
m[1,1] <- 1
m[1,3] <- 1
m[2,2] <- 1
m[2,3] <- 1
  
exNetworkBipartite <- network::network(m, bipartite=TRUE)
network::print.network(exNetworkBipartite)
network::as.matrix.network(exNetworkBipartite)
network::plot.network(exNetworkBipartite)
network::is.directed(exNetworkBipartite) # not directed, just like igraph





#============================================================================ 
# saving to data dir

save(exIgraph, file=file.path(outdir, "exIgraph.rda"))
save(exIgraph2, file=file.path(outdir, "exIgraph2.rda"))
save(exNetwork, file=file.path(outdir, "exNetwork.rda"))
save(exNetwork2, file=file.path(outdir, "exNetwork2.rda"))

# saving to single testing object
save( exNetworkHyper, exNetworkHyper2, exIgraphMultiple, exIgraphMultiple2,
     exIgraphLoops, exIgraphLoops2, exIgraphBipartite,
     file="testnetworks.rda")
