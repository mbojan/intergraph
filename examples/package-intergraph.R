# example of converting objects between classes 'network' and 'igraph'
# needs packages igraph and network attached
if( require(network) & require(igraph) )
{

  ### convert 'network' -> 'igraph'

  # example network as object of class "network"
  summary(exNetwork)

  # convert to class "igraph"
  g <- asIgraph(exNetwork)

  # check if 'exNetwork' and 'g' are the same
  all.equal( as.matrix(exNetwork, "edgelist"), 
    igraph::get.edgelist(g) )   

  # compare results using 'netcompare'
  netcompare(exNetwork, g)


  ### convert 'igraph' -> 'network'

  # example network as object of class "igraph"
  summary(exIgraph)

  # convert to class "network"
  gg <- asNetwork(exIgraph)

  # check if they are the same
  all.equal( get.edgelist(exIgraph), as.matrix(gg, "edgelist"))
}
