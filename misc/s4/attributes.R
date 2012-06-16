
#============================================================================
# network attribute methods
#============================================================================

setMethod("vcount", "network",
function(object) network::network.size(object) )

setMethod("vcount", "igraph",
function(object) igraph::vcount(object))

setMethod("ecount", "network",
function(object, na.omit=TRUE) 
network::network.edgecount(object, na.omit=na.omit))

setMethod("ecount", "igraph",
function(object) igraph::ecount(object))

setMethod("isDirected", "network",
function(object) network::is.directed(object))

setMethod("isDirected", "igraph",
function(object) igraph::is.directed(object))


#============================================================================
# vertex attributes
#============================================================================

# getting attributes

setMethod("vattr", signature("network", "character"),
function(object, name, ...)
{
    network::get.vertex.attribute(x=object, attrname=name, ...)
} )

setMethod("vattr", signature("igraph", "character"),
function(object, name, ...)
{
    igraph::get.vertex.attribute(graph=object, name=name, ...)
} )



# setting attributes

setMethod("vattr<-", signature(object="network", name="character", value="ANY"),
function(object, name, ..., value)
{
    rval <- network::network.copy(object)
    network::set.vertex.attribute(x=rval, attrname=name, value=value, ...)
    rval
} )

setMethod("vattr<-", signature(object="igraph", name="character", value="ANY"),
function(object, name, ..., value)
{
    igraph::set.vertex.attribute(graph=object, name=name, value=value, ...)
} )

