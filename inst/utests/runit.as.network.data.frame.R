test.as.network.data.frame <- function()
{
  ## edge list data frame only
  el <- matrix(ncol=2, byrow=TRUE, c(1,2, 1,3, 2,4))
  d <- as.data.frame(el)
  as.network(d)

  ## convert to data frames and assemble back to network object
  l <- asDF(exNetwork)
  g <- as.network( l$edges, vertices=l$vertexes)
  checkEquals(g, exNetwork)

  l <- asDF(exNetwork2)
  g <- as.network( l$edges, vertices=l$vertexes, directed=FALSE)
  checkEquals(g, exNetwork2)

  # use data from an igraph object
  l <- asDF(exIgraph)
  g <- as.network(l$edges, vertices=l$vertexes)
  checkEquals( network::network.size(g), nrow(l$vertexes))
  checkEquals( network::network.edgecount(g), nrow(l$edges))

  l <- asDF(exIgraph2)
  g <- as.network(l$edges, vertices=l$vertexes, directed=FALSE)
  checkEquals( network::network.size(g), nrow(l$vertexes))
  checkEquals( network::network.edgecount(g), nrow(l$edges))
}
