# using 'igraph' object
l <- dumpAttr( exIgraph )   # all attributes
identical( dumpAttr(exIgraph, "network"), l$network )
identical( dumpAttr(exIgraph, "vertex"), l$vertex )
identical( dumpAttr(exIgraph, "edge"), l$edge )

# using 'network' object
l <- dumpAttr( exNetwork )   # all attributes
identical( dumpAttr(exNetwork, "network"), l$network )
identical( dumpAttr(exNetwork, "vertex"), l$vertex )
identical( dumpAttr(exNetwork, "edge"), l$edge )
