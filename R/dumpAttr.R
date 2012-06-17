#============================================================================
# dumping attributes to lists
#============================================================================

dumpAttr <- function(x, ...) UseMethod("dumpAttr")

dumpAttr.network <- function(x, type=c("all", "network", "vertex", "edge"), ...)
{
	type <- match.arg(type)
	if(type == "all")
	{
		n <- c("network", "vertex", "edge")
		rval <- lapply( n, function(nam) dumpAttr(x, type=nam))
		names(rval) <- n
		return(rval)
	} else
	{
		type <- match.arg(type)
		nam <- switch(type,
		network = network::list.network.attributes(x),
		edge = network::list.edge.attributes(x),
		vertex = network::list.vertex.attributes(x) )
		rval <- switch( type,
		network = lapply( nam, function(a) network::get.network.attribute(x, a)),
		edge = lapply( nam, function(a) network::get.edge.attribute(x$mel, a)),
		vertex = lapply( nam, function(a) network::get.vertex.attribute(x, a)) )
		names(rval) <- nam
		return(rval)
	}
}


dumpAttr.igraph <- function(x, type=c("all", "network", "vertex", "edge"), ...)
{
	type <- match.arg(type)
	if(type == "all")
	{
		n <- c("network", "vertex", "edge")
		rval <- lapply( n, function(nam) dumpAttr(x, type=nam))
		names(rval) <- n
		return(rval)
	} else
	{
		nams <- switch( type,
			network = igraph::list.graph.attributes(x),
			edge = igraph::list.edge.attributes(x),
			vertex = igraph::list.vertex.attributes(x) )
		rval <- switch( type,
			network = lapply( nams, function(a) igraph::get.graph.attribute(x, a) ),
			edge = lapply( nams, function(a) igraph::get.edge.attribute(x, a) ),
			vertex = lapply( nams, function(a) igraph::get.vertex.attribute(x, a) ) )
		names(rval) <- nams
		return(rval)
	}
}

