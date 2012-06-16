test.bug1926 <- function()
{
  # converting igraph->network with NAs on edge attributes
  require(igraph)
  require(network)

  # network with NA on edge attribute
  g <- graph( c(0,1, 1,2, 2,3, 3,4, 4,2), directed=TRUE)
  g$layout <- layout.fruchterman.reingold
  E(g)$label <- c(1,2,3,NA,4)

  # convert to 'network'
  net <- as.network(g)
  # warning that NA is converted to "NA"?

  checkTrue( is.na(net %e% "label")[4] )

  # as.network.data.frame checks replaces NA in the whole edge list (including
  # edge attributes), it should only do that for first two columns
}
