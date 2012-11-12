
# wrapper over get.adjacency / get.edgelist
as.matrix.igraph <- function(x, matrix.type=c("adjacency", "edgelist"), attrname=NULL, sparse=FALSE, ...)
{
  mt <- match.arg(matrix.type)
  switch(mt,
      adjacency = igraph::get.adjacency(graph=x, attr=attrname, sparse=sparse, ...),
      edgelist = igraph::get.edgelist(graph=x, ...) )
}
