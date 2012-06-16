try(detach(package:intergraph, unload=TRUE))
try(detach(package:network, unload=TRUE))
try(detach(package:igraph, unload=TRUE))
library(intergraph, lib="../../bin")
search()

#============================================================================ 
# run unit tests

source(system.file("utests/runTests.R", package="intergraph"))
tests <- runTestSuite(testAll)
printTextProtocol(tests)

#============================================================================ 
# example figure

net1 <- as.network(exIgraph)
ig1 <- as.igraph(net1)
net2 <- as.network(ig1)
k <- layout.fruchterman.reingold(ig1)
layout(matrix(1:4, 2, 2, byrow=TRUE))
plot(exIgraph, layout=k, main="Original 'igraph'")
plot(net1, coord=k, main="'igraph' > 'network'", displaylabels=TRUE,
    label=net1 %v% "label")
plot(ig1, layout=k, main="'igraph' > 'network' > 'igraph'")
plot(net2, coord=k, main="'igraph' > 'network' > 'igraph' > 'network'",
    label=net2 %v% "label", displaylabels=TRUE)

savePlot("png", file="intergraph.png")


#============================================================================ 
# testing coercion for non-standard types of networks

library(network)
library(igraph)


# networks:
# multiple ties
# loops
# hyper edges
# bipartite


### network with multiple ties

# network -> igraph
mt <- matrix( c(1,2, 1,2, 2,3, 3,1), byrow=TRUE, ncol=2)
gmt1 <- network(mt, directed=FALSE, multiple=TRUE, matrix.type="edgelist")
gmt2 <- network(mt, directed=FALSE, multiple=FALSE, matrix.type="edgelist")
i1 <- as.igraph(gmt1)
i2 <- as.igraph(gmt2)
identical(i1, i2)

# igraph -> network
l <- list( g1 = graph(c(0,1, 1,2, 2,0, 0,1), directed=FALSE), 
          g2 = graph(c(0,1, 1,2, 2,0, 0,1), directed=TRUE))
l2 <- lapply(l, as.network)



### networks with loops
m <- matrix(c(0,1, 1,2, 2,3, 3,0, 0,0), ncol=2, byrow=TRUE)
net <- network(m+1, matrix.type="edgelist", directed=FALSE, loops=TRUE)
ig <- as.igraph(net)



### bipartite network
m <- matrix(0, ncol=2, nrow=3)
m[1,1] <- m[2,1] <- m[1,2] <- m[2,2] <- 1
net <- network(t(m), bipartite=TRUE, directed=FALSE)


#============================================================================ 
# bug w asDF?

# using method for 'network' objects
d1 <- asDF(exNetwork)

# using method for 'igraph' objects
d2 <- asDF(exIgraph)


library(igraph)
library(network)

get.edgelist(exIgraph)
as.matrix(exNetwork, "edgelist")

o1 <- order(d1$edges[,1], d1$edges[,2])
o2 <- order(d2$edges[,1], d2$edges[,2])

all( (data.matrix(d1$edges[o1,1:2]) - data.matrix(d2$edges[o2,1:2]+1) )   == 0 )

#============================================================================ 

v <- 1:4
e <- c(1,2, 2,3, 3,4, 4,1)

vd <- data.frame(id = v + 5, label=letters[1:4])
ed <- data.frame(id1 = e[seq(1,8, by=2)]+5, id2=e[seq(2, 8, by=2)]+5, a=letters[1:4])


ig <- as.igraph(ed, vertices=vd, directed=FALSE)





as.network(ed, vertices=vd, directed=FALSE)

net <- network( data.matrix(ed[,1:2]), directed=FALSE)
