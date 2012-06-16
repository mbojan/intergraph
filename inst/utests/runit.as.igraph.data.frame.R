
test.as.igraph.data.frame <- function()
{
  ## convert to data frames and assemble back to igraph object
  l <- asDF(exIgraph)
  g <- as.igraph( l$edges, vertices=l$vertexes)
  g$layout <- exIgraph$layout
  checkEquals(g, exIgraph)

  ## testing 'vnames' argument
  # non-existent column in 'vertices'
  checkException( as.igraph(l$edges, vertices=l$vertexes, vnames="foo"))

  # existing column in 'vertices'
  l <- asDF(exIgraph)
  g <- as.igraph( l$edges, vertices=l$vertexes, vnames="label")
  checkEquals(l$vertexes$label, igraph::get.vertex.attribute(g, "name"))

  ## above tests but for the undirected network
  ## convert to data frames and assemble back to igraph object
  l <- asDF(exIgraph2)
  g <- as.igraph( l$edges, vertices=l$vertexes, directed=FALSE)
  g$layout <- exIgraph2$layout
  checkEquals(g, exIgraph2)

  ## testing 'vnames' argument
  # non-existent column in 'vertices'
  checkException( as.igraph(l$edges, vertices=l$vertexes, vnames="foo"))

  # existing column in 'vertices'
  l <- asDF(exIgraph2)
  g <- as.igraph( l$edges, vertices=l$vertexes, vnames="label", directed=FALSE)
  checkEquals(l$vertexes$label, igraph::get.vertex.attribute(g, "name"))
}
