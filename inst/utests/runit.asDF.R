
test.asDF.network <- function()
{
  # directed network
	l <- asDF(exNetwork)
  checkEquals( nrow(l$edges), network::network.edgecount(exNetwork))
  checkEquals( nrow(l$vertexes), network::network.size(exNetwork))
  # undirected network
	l <- asDF(exNetwork2)
  checkEquals( nrow(l$edges), network::network.edgecount(exNetwork2))
  checkEquals( nrow(l$vertexes), network::network.size(exNetwork2))
}

