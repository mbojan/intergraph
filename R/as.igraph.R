#   vim:shiftwidth=4:tabstop=4
# converting 'network' to 'igraph'



as.igraph.network <- function(x, attrmap=attrmap(), ...)
{
    object <- x
    # hypergraphs not supported
    if(network::is.hyper(object))
        stop("hypergraphs are not supported")
    if(network::is.bipartite(object))
        stop("bipartite networks are not supported")
    na <- dumpAttr(object, "network")
    l <- asDF(object)

    ### prepare edge attributes
    eats <- attrmapmat("network", "igraph", "edge")
    # drop some
    todrop <- eats[ is.na(eats[,"toattr"]) , "fromattr" ]
    edges <- l$edges[ !( names(l$edges) %in% todrop ) ]
    # rename some
    names(edges) <- recode(names(edges), eats)

    ### prepare vertex attributes
    vats <- attrmapmat("network", "igraph", "vertex")
    # drop some
    todrop <- vats[ is.na(vats[,"toattr"]) , "fromattr" ]
    vertexes <- l$vertexes[ !( names(l$vertexes) %in% todrop )  ]
    # rename some
    names(vertexes) <- recode(names(vertexes), vats)

    ### make 'igraph' object
    rval <- as.igraph( edges,
        directed=network::is.directed(object),
        vertices=vertexes, ...)

    ### apply/rename/drop network attributes
    nats <- attrmapmat("network", "igraph", "network")
    todrop <- nats[ is.na(nats[,"toattr"]) , "fromattr" ]
    na <- na[ - which( names(na) %in% todrop ) ]
    names(na) <- recode(names(na), nats)
    if( length(na) > 0 )
    {
      for( naname in names(na) )
        rval <- igraph::set.graph.attribute(rval, naname, na[[naname]])
    }
    rval
}


as.igraph.data.frame <- function(x, directed=TRUE, vertices=NULL, vnames=NULL, ...)
{
    object <- x
    rval <- igraph::graph.data.frame( object, directed=directed,
        vertices=vertices)
    if(is.null(vnames))
    {
      rval <- igraph::remove.vertex.attribute(rval, "name")
    } else
    {
      if( !(vnames %in% names(vertices)) )
            stop("no column ", vnames, " in 'vertices'")
      rval <- igraph::set.vertex.attribute(rval, "name", value=vertices[[vnames]])
    }
    rval
}
