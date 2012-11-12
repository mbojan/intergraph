# create 'network' objects from data frame(s)
# inspired by igraph::graph.data.frame

as.network.data.frame <- function(x, directed=TRUE, vertices=NULL, ...)
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
df2network <- function(x, directed=TRUE, vertices=NULL, ...)
{
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



