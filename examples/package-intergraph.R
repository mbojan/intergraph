
# example of converting objects between classes 'network' and 'igraph'

if( require(network) & require(igraph) )
{

  ### convert 'network' -> 'igraph'

  # example network
  summary(exNetwork)

  # convert to igraph
  g <- asIgraph(exNetwork)

  # check if 'exNetwork' and 'g' are the same
  all.equal( as.matrix(exNetwork, "edgelist"), 
    igraph::get.edgelist(g) + 1 )   
    # +1 because igraph's vertex ids start from 0

  # compre results using 'netcompare'
  netcompare(exNetwork, g)

  ### convert 'igraph' -> 'network'

  # example network: same as above but of class 'igraph'
  summary(exIgraph)

  # convert to network class
  gg <- asNetwork(exIgraph)

  # check if they are the same
  all.equal( get.edgelist(exIgraph), as.matrix(gg, "edgelist"))
  # compre results using 'netcompare'
  netcompare(exIgraph, g)
}
