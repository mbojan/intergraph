
# wrapper over get.adjacency / get.edgelist
as.matrix.igraph <- function(x, matrix.type=c("adjacency", "edgelist"), attrname=NULL, ...)
{
  mt <- match.arg(matrix.type)
  switch(mt,
      adjacency = igraph::get.adjacency(graph=x, attr=attrname, ...),
      edgelist = igraph::get.edgelist(graph=x, ...) )
}
