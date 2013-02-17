# create 'network' objects from data frame(s)
# inspired by igraph::graph.data.frame

df2network_old <- function(x, directed=TRUE, vertices=NULL, ...)
{
    # check for valid edgelist
    if (ncol(x) < 2) {
        stop("the data frame should contain at least two columns")
    }

    if (any(is.na(x[,1:2]))) {
        warning("In first two columns of `x' `NA' elements were replaced with string \"NA\"")
        x[,1:2][is.na(x[,1:2])] <- "NA"
    }
    if (!is.null(vertices) && any(is.na(vertices[, 1]))) {
        warning("In `vertices[,1]' `NA' elements were replaced with string \"NA\"")
        vertices[, 1][is.na(vertices[, 1])] <- "NA"
    }
    # get unique vertex names from edgelist
    names <- unique(c(as.character(x[, 1]), as.character(x[, 2])))
    if (!is.null(vertices)) {
        names2 <- names
        vertices <- as.data.frame(vertices)
        if (nrow(vertices) < 1) { # was 'ncol', a typo i believe
            stop("Vertex data frame contains no rows")
        }
        # check if vertex names from EL are in vertex df
        names <- as.character(vertices[, 1])
        if (any(duplicated(names))) {
            stop("Duplicate vertex names")
        }
        if (any(!names2 %in% names)) {
            stop("Some vertex names in edge list are not listed in vertex data frame")
        }
    }
    # TODO if numeric edge list or vertex df has 0s then add 1 to vertex ids (with warning)
    if(is.null(vertices))
    {
      # add 1 to edgelist
      if( min(x[,1:2]) == 0 )
      {
          x[,1:2] <- x[,1:2] + 1
          warning("vertex ids in edge list contain 0, adding one to all ids")
      }
      # without attributes
      rval <- network::network( data.matrix(x[,1:2]),
          directed=directed,
          multiple=any(duplicated(x[,1:2])),
          loops=any(x[,1] == x[,2]) )
    } else
    {
      # add 1 to edgelist and vertex id
      if( min( vertices[,1]) == 0 )
      {
          warning("vertex ids in edge list contain 0, adding one to all ids")
          x[,1:2] <- x[,1:2] + 1
          vertices[,1] <- vertices[,1] + 1
      }
      if( ncol(vertices) > 1 )
      {
        rval <- network::network( data.matrix(x[,1:2]),
            vertex.attr=vertices[-1],
            vertex.attrnames= as.list(names(vertices)[-1]),
            directed=directed,
            multiple=any(duplicated(x[,1:2])),
            loops=any(x[,1] == x[,2]) )
      } else
      {
        rval <- network::network( data.matrix(x[,1:2]),
            directed=directed,
            multiple=any(duplicated(x[,1:2])),
            loops=any(x[,1] == x[,2]) )
      }
    }
    # add edge attributes
    if( ncol(x) > 2 )
        for( nam in names(x)[ -c(1:2) ] )
            network::set.edge.attribute(rval, nam, x[[nam]])
    rval
}

# alternative function for creating network objects from data frames


#'Convert objects to class "network"
#'
#'Convert objects to class "network"
#'
#'This is a generic function which dispatches on argument \code{x}.  It creates
#'objects of class "network" from other R objects.
#'
#'The method for data frames is inspired by the similar function in package
#'\pkg{igraph}: \code{\link[igraph]{graph.data.frame}}.  It assumes that first
#'two columns of \code{x} constitute an edgelist.  The remaining columns are
#'interpreted as edge attributes. Optional argument \code{vertices} allows for
#'including vertex attributes.  The first column is assumed to vertex id, the
#'same that is used in the edge list. The remaining colums are interpreted as
#'vertex attributes.
#'
#'The method for objects of class "igraph" takes the network of that class and
#'converts it to data frames using \code{\link{asDF}}. The network is recreated
#'in class "network" using \code{as.network.data.frame}. The function currently
#'does not support bipartite "igraph" networks.
#'
#'@aliases as.network.data.frame as.network.igraph
#'@param x an R object to be coerced, see Details for the description of
#'available methods
#'@param attrmap data.frame with attribute copy/rename rules, see
#'\code{\link{attrmap}}
#'@param directed logical, whether the created network should be directed
#'@param vertices NULL or data frame, optional data frame containing vertex
#'attributes
#'@param \dots other arguments from/to other methods
#'@return Object of class "network".
#'@seealso \code{\link[igraph]{graph.data.frame}}
#'
#'\code{\link{as.igraph}} for conversion in the other direction.
#'@examples
#'
#'# require package 'network' as 'as.network' generic is defined there
#'if(require(network, quietly=TRUE))
#'{
#'  ### demonstrating method for data frames
#'  l <- asDF(exNetwork)
#'  g <- as.network( l$edges, vertices=l$vertexes)
#'  stopifnot(all.equal(g, exNetwork))
#'
#'  ### method for igraph objects
#'  ig <- as.network(exIgraph)
#'  identical( as.numeric(as.matrix(g, "adjacency")),
#'            as.numeric(as.matrix(ig, "adjacency")))
#'}
#'
as.network.data.frame <- function(x, directed=TRUE, vertices=NULL, ...)
{
  edb <- validateEL(x)
  # got vertex DB?
  if(!is.null(vertices))
  {
    vdb <- validateVDB(vertices)
    stopifnot(validNetDB(edb, vdb))
  }
  # number of vertices
  if(is.null(vertices)) nv <- length(unique(c(edb[,1], edb[,2])))
  else nv <- nrow(vertices)
  # create an empty network object
  rval <- network::network.initialize(nv, directed=directed, hyper=FALSE,
                                      multiple=any(duplicated(edb[,1:2])),
                                      loops=any(edb[,1] == edb[,2]))
  # add edges
  rval <- network::add.edges(rval, as.list(edb[,1]), as.list(edb[,2]))
  # add edge attribbutes
  if( ncol(edb) > 2)
    for(i in seq(3, ncol(edb)))
    {
      rval <- network::set.edge.attribute(rval, attrname=names(edb)[i], value=edb[,i])
    }
  # vertex attributes
  if( !is.null(vertices) && ncol(vertices) > 1 )
  {
    for( i in seq(2, ncol(vdb)) )
    {
      rval <- network::set.vertex.attribute(rval, attrname=names(vdb)[i],
                                            value=vdb[,i])
    }
  }
  rval
}

# df2network testing
if(FALSE)
{
n <- network.initialize(3)
add.edges(n, list(1,2), list(2,3),
          names.eval = list(letters[1:2], letters[1:2]),
          vals.eval = list(a1=letters[1:2], a2=letters[11:12]) )
summary(n)


l <- asDF(exIgraph)
z <- df2network(l[[1]], vertices=l[[2]])
summary(z)
plot(z)
}

# convert igraph to network
as.network.igraph <- function(x, attrmap=attrmap(), ...)
{
  object <- x
    na <- dumpAttr(object, "network")
    l <- asDF(object)

    ### prepare edge attributes
    eats <- intergraph:::attrmapmat("igraph", "network", "edge")
    if( nrow(eats) > 0 )
    {
      # drop some
      todrop <- eats[ is.na(eats[,"toattr"]) , "fromattr" ]
      edges <- l$edges[ !( names(l$edges) %in% todrop ) ]
      # rename some
      names(edges) <- recode(names(edges), eats)
    } else
    {
      edges <-l$edges
    }

    ### prepare vertex attributes
    vats <- intergraph:::attrmapmat("igraph", "network", "vertex")
    if( nrow(vats) > 0 )
    {
      # drop some
      todrop <- vats[ is.na(vats[,"toattr"]) , "fromattr" ]
      vertexes <- l$vertexes[ !( names(l$vertexes) %in% todrop )  ]
      # rename some
      names(vertexes) <- recode(names(vertexes), vats)
    } else
    {
      vertexes <- l$vertexes
    }

    ### make 'igraph' object
    rval <- as.network( edges,
        directed=igraph::is.directed(object),
        multiple = any(igraph::is.multiple(object)),
        loops = any(igraph::is.loop(object)),
        vertices=vertexes, ...)

    ### apply/rename/drop network attributes
    nats <- intergraph:::attrmapmat("igraph", "network", "network")
    if( nrow(nats) > 0 )
    {
      todrop <- nats[ is.na(nats[,"toattr"]) , "fromattr" ]
      na <- na[ !( names(na) %in% todrop ) ]
      names(na) <- recode(names(na), nats)
    }
    if( length(na) > 0 )
    {
      for( naname in names(na) )
        network::set.network.attribute(rval, naname, na[[naname]])
    }
    if( is.function(network::get.network.attribute(rval, "layout")) )
      warning("network attribute 'layout' is a function, print the result might give errors")
    rval
}



