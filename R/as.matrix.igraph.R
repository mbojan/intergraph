
# wrapper over get.adjacency / get.edgelist
as.matrix.igraph <- function(x, matrix.type=c("adjacency", "edgelist"), attrname=NULL, ...)
{
  mt <- match.arg(matrix.type)
  switch(mt,
      adjacency = igraph0::get.adjacency(graph=x, attr=attrname, ...),
      edgelist = igraph0::get.edgelist(graph=x, ...) )
}
