context("Testing whether custom 'attrmap' specifications work")

test_that("'na' vertex attribute can be dropped when making network", {
          net <- asNetwork(exIgraph)
          a <- attrmap()
          r <- data.frame(type="vertex", fromcls="network",
                          fromattr="na", tocls="igraph", toattr=NA)
          aa <- cbind(a, r)
          g <- asIgraph(net, attrmap=aa)
          expect_false( "na" %in% igraph::list.vertex.attributes(g))
} )
