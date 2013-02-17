#' Coerce an object to class "igraph"
#' 
#' Coerce objects to class "igraph".
#' 
#' \code{as.igraph} is a generic function with methods written for data frames
#' and objects of class "network".
#' 
#' If \code{x} is a data frame, the method used is a wrapper around
#' \code{\link[igraph]{graph.data.frame}} in package \pkg{igraph}. The
#' \code{vnames} argument was added so that the user can specify which vertex
#' attribute from the data frame supplied through \code{vertices} argument is
#' used for vertex names (the \code{name} attribute in \code{igraph} objects) in
#' the returned result. By default the vertex names are not created.
#' 
#' If \code{x} is of class "network" (package \pkg{network}) the function
#' uses \code{\link{asDF}} to extract data on edges and vertex with their
#' attributes (if present).  Network attributes are extracted as well. Not all
#' vertex/edge/network attributes are worth preserving though. Attributes are
#' copied, dropped or renamed based on rules given in the \code{attrmap}
#' argument, see \code{\link{attrmap}} for details. The function currently does
#' not support objects that represent neither bipartite networks nor
#' hypergraphs.
#' 
#' @param x R object to be converted
#' @param directed logical, whether the created network should be directed
#' @param attrmap data.frame with attribute copy/rename rules, see
#' \code{\link{attrmap}}
#' @param vertices NULL or data frame, optional data frame containing vertex
#' attributes
#' @param vnames character, name of the column in \code{vertices} to be used as
#' a \code{name} vertex attribute, if \code{NULL} no vertex names are created
#' @param \dots other arguments from/to other methods
#'
#' @return Object of class "igraph".
#'
#' @seealso \code{\link[igraph]{graph.data.frame}}
#'
#' @examples example/as.igraph.R





#' @method as.igraph network
#' @export
#' @rdname as.igraph
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


#' @method as.igraph data.frame
#' @export
#' @rdname as.igraph
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
