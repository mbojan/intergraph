#============================================================================ 
# alternative print methods

print.igraph <- function(x, ...)
{
  cat("Vertices:", igraph::vcount(x), "\n")
  cat("Edges:", igraph::ecount(x), "\n")
  cat("Directed:", igraph::is.directed(x), "\n")
  cat("Vertex attributes:", paste( igraph::list.vertex.attributes(x), collapse=", "), "\n")
  cat("Edge attributes:", paste( igraph::list.edge.attributes(x), collapse=", "), "\n")
  cat("Network attributes:", paste( igraph::list.graph.attributes(x), collapse=", "), "\n")
  cat("\n")
}

print.network <- function(x, ...)
{
  cat("Vertices:", network::network.size(x), "\n")
  cat("Edges:", network::network.edgecount(x), "\n")
  cat("Directed:", network::is.directed(x), "\n")
  cat("Vertex attributes:", paste( network::list.vertex.attributes(x), collapse=", "), "\n")
  cat("Edge attributes:", paste( network::list.edge.attributes(x), collapse=", "), "\n")
  cat("Network attributes:", paste( network::list.network.attributes(x), collapse=", "), "\n")
  cat("\n")
}


