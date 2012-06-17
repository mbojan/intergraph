\name{as.igraph}
\alias{as.igraph}
\alias{as.igraph.network}
\alias{as.igraph.data.frame}
\title{Coerce to a object of class "igraph"}
\description{Convert objects to class "igraph".}
\usage{
as.igraph(object, ...)
\method{as.igraph}{network}(object, attrmap=attrmap(), ...)
\method{as.igraph}{data.frame}(object, directed=TRUE, vertices=NULL, vnames=NULL, ...)
}
\arguments{
  \item{object}{R object to be converted}
  \item{directed}{logical, whether the created network should be directed}
  \item{attrmap}{data.frame with attribute copy/rename rules, see
  \code{\link{attrmap}}}
  \item{vertices}{NULL or data frame, optional data frame containing
  vertex attributes}
  \item{vnames}{character, name of the column in \code{vertices} to be used as
  a \code{name} vertex attribute, if \code{NULL} no vertex names are created}
  \item{\dots}{other arguments from/to other methods}
}
\details{
\code{as.igraph} is a generic function with methods written for data frames and
objects of class \code{network}.

If \code{object} is a data frame, the method used is a wrapper around
\code{\link[igraph]{graph.data.frame}} in package \pkg{igraph}. The
\code{vnames} argument was added so that the user can specify which vertex
attribute from the data frame supplied through \code{vertices} argument is used
for vertex names (the \code{name} attribute in \code{igraph} objects) in the
returned result. By default the vertex names are not created.

If \code{object} is of class \code{network} (package \pkg{network}) the
function uses \code{\link{asDF}} to extract data on edges and vertex with their
attributes (if present).  Network attributes are extracted as well. Not all
vertex/edge/network attributes are worth preserving though. Attributes are
copied, dropped or renamed based on rules given in the \code{attrmap} argument,
see \code{\link{attrmap}} for details. The function currently does not support
objects that represent neither bipartite networks nor hypergraphs.
}
\value{
Object of class "igraph".
}
\seealso{
\code{\link[igraph]{graph.data.frame}}
}
\examples{
### using 'as.igraph' on objects of class 'network'

# package 'network' is required because 'as.network.matrix' is defined there
if(require(network))
{
  g <- as.igraph(exNetwork)

  # compare adjacency matrices
  netmat <- as.matrix(exNetwork, "adjacency")
  imat <- as.matrix(g, "adjacency")
  # drop the dimnames in 'netmat'
  dimnames(netmat) <- NULL
  # compare
  identical( netmat, imat )
}


### using 'as.igraph' on data.frames

# data frame with vertex ids and vertex attributes
v <- 1:4
vd <- data.frame(id = v + 5, label=letters[1:4])
print(vd)

# edge list (first two columns) and edge attributes
e <- c(1,2, 2,3, 3,4, 4,1)
ed <- data.frame(id1 = e[seq(1,8, by=2)]+5, id2=e[seq(2, 8, by=2)]+5, a=letters[1:4])
print(ed)

# build the network
# without vertex attributes
g <- as.igraph(ed, directed=FALSE)
# with vertex attributes
gv <- as.igraph(ed, vertices=vd, directed=FALSE)

# NOTE: Even though vertex ids start at 6 the network has 4 nodes:
range(vd$id) # min and max of node ids
if(require(igraph)) igraph::vcount(gv) # number of nodes in 'gv'
}
