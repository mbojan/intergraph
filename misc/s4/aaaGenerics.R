# network attributes
setGeneric("vcount", function(object) standardGeneric("vcount"))
setGeneric("ecount", function(object, ...) standardGeneric("ecount"))
setGeneric("isDirected", function(object) standardGeneric("isDirected"))

# vertex attributes
setGeneric("vattr", function(object, name, ...) standardGeneric("vattr"))
setGeneric("vattr<-", function(object, name, ..., value ) standardGeneric("vattr<-"))

# conversion to other data types
setGeneric("asDF", function(object, ...) standardGeneric("asDF"))

# other
setGeneric("dumpAttr", function(x, ...) standardGeneric("dumpAttr"))

# setGeneric("plot", function(x, y, ...) standardGeneric("plot"))
# setGeneric("print", function(x, ...) standardGeneric("print"))

# converting to 'igraph'
setGeneric("as.igraph", function(object, ...) standardGeneric("as.igraph"))

