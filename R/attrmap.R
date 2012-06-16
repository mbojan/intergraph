
# attribute renaming table

.attrmap <- matrix(ncol=5, byrow=TRUE, c(
        "network" , "network" , "directed"     , "igraph"  , NA             , 
        "network" , "network" , "bipartite"    , "igraph"  , NA             , 
        "network" , "network" , "loops"        , "igraph"  , NA             , 
        "network" , "network" , "mnext"        , "igraph"  , NA             , 
        "network" , "network" , "multiple"     , "igraph"  , NA             , 
        "network" , "network" , "n"            , "igraph"  , NA             , 
        "network" , "network" , "hyper"        , "igraph"  , NA             , 
        "vertex"  , "igraph"  , "name"         , "network" , "vertex.names"
        ) )
.attrmap <- as.data.frame(.attrmap, stringsAsFactors=FALSE)
names(.attrmap) <- c("type", "fromcls", "fromattr", "tocls", "toattr")


# get and set attrmap table
attrmap <- function(newdf=NULL)
{
  cur <- getFromNamespace(".attrmap", "intergraph")
  if( is.null(newdf) )
  {
    # return current
    return(cur)
  } else
  {
    # assign new
    assignInNamespace(".attrmap", newdf, "intergraph")
    # return old invisibly
    invisible(cur)
  }
}

# subset of attrmap depending on type and from/to classes
attrmapmat <- function(from, to, atype)
{
  db <- attrmap()
  i <- with(db, type==atype & fromcls==from & tocls==to)
  as.matrix( db[i, c("fromattr", "toattr")] )
}

