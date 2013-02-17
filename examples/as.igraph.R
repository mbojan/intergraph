### using 'as.igraph' on objects of class 'network'

g <- as.igraph(exNetwork)

# compare adjacency matrices
netmat <- as.matrix(exNetwork, "adjacency")
imat <- as.matrix(g, "adjacency")
# drop the dimnames in 'netmat'
dimnames(netmat) <- NULL
# compare
identical( netmat, imat )


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
