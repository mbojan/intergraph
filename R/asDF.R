#============================================================================
# conversion of networks to two data frames
#============================================================================

asDF <- function(object, ...) UseMethod("asDF")

asDF.network <- function(object, ...)
{
	# get edge list and substitute vertex names
    dfedge <- as.data.frame(network::as.matrix.network(object, "edgelist"),
        stringsAsFactors=FALSE)
	# add edge attributes, if any
    eattr <- dumpAttr(object, "edge")
    if( length(eattr) > 0 )
        dfedge <- cbind(dfedge, as.data.frame(eattr, stringsAsFactors=FALSE))
    # make vertex data frame
    dfvertex <- data.frame(id=seq(1, network::network.size(object)))
    # add vertex attributes if any
    vattr <- dumpAttr(object, "vertex")
    if( length(vattr) > 0 )
        dfvertex <- cbind( dfvertex, as.data.frame(vattr, stringsAsFactors=FALSE))
    list(edges=dfedge, vertexes=dfvertex)
}

asDF.igraph <- function(object, ...)
{
    # get edgelist
    dfedge <- as.data.frame(igraph0::get.edgelist(object, names=FALSE), 
        stringsAsFactors=FALSE)
	# add edge attributes, if any
    eattr <- dumpAttr(object, "edge")
    if( length(eattr) > 0 )
        dfedge <- cbind(dfedge, as.data.frame(eattr, stringsAsFactors=FALSE))
    # make vertex data frame
    dfvertex <- data.frame(id=seq(0, igraph0::vcount(object) - 1))
    # add vertex attributes, if any
    vattr <- dumpAttr(object, "vertex")
    if( length(vattr) > 0 )
        dfvertex <- cbind( dfvertex, as.data.frame(vattr, stringsAsFactors=FALSE))
    list(edges=dfedge, vertexes=dfvertex)
}
