test.as.igraph.network <- function()
{
  require(igraph)
  require(network)

  # directed network
  data(exNetwork)
  res <- netcompare( as.igraph(exNetwork), exNetwork, test=TRUE )
  checkTrue(res)

  # undirected network
  data(exNetwork2)
  res2 <- netcompare( as.igraph(exNetwork2), exNetwork2, test=TRUE )
  checkTrue(res2)

  ### bipartite network (not yet supported)
  m <- matrix(0, ncol=2, nrow=3)
  m[1,1] <- m[2,1] <- m[1,2] <- m[3,2] <- 1
  net <- network::network(t(m), bipartite=TRUE, directed=FALSE)
  checkException(as.igraph(net))
}
