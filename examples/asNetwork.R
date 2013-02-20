# require package 'network' as 'asNetwork' generic is defined there
if(require(network, quietly=TRUE))
{
  ### demonstrating method for data frames
  l <- asDF(exNetwork)
  g <- asNetwork( l$edges, vertices=l$vertexes)
  stopifnot(all.equal(g, exNetwork))

  ### method for igraph objects
  ig <- asNetwork(exIgraph)
  identical( as.numeric(as.matrix(g, "adjacency")),
            as.numeric(as.matrix(ig, "adjacency")))
}

