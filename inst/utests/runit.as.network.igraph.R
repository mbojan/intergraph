test.as.network.igraph <- function()
{
  require(network)
  require(igraph)
  # directed network
  data(exIgraph)
  res <- netcompare( as.network(exIgraph), exIgraph, test=TRUE )
  checkTrue(res)

  # undirected network
  data(exIgraph2)
  res2 <- netcompare( as.network(exIgraph2), exIgraph2, test=TRUE )
  checkTrue(res2)
}
