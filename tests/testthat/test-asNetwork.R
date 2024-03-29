# From data.frames --------------------------------------------------------

test_that("Disassembling directed network to d.f. and assembling back to network works", {
  l <- asDF(exNetwork)
  g <- asNetwork( l$edges, vertices=l$vertexes)
  expect_identical(g, exNetwork)
} )

test_that("Disassembling undirected network to d.f. and assembling back to network works", {
  l <- asDF(exNetwork2)
  g <- asNetwork( l$edges, vertices=l$vertexes, directed=FALSE)
  expect_identical(g, exNetwork2)
} )

test_that("Disassembling directed igraph to d.f. and assembling back to network: edgecount", {
  l <- asDF(exIgraph)
  g <- asNetwork(l$edges, vertices=l$vertexes)
  expect_equal( network::network.edgecount(g), nrow(l$edges))
} )

test_that("Disassembling directed igraph to d.f. and assembling back to network: vcount", {
  l <- asDF(exIgraph)
  g <- asNetwork(l$edges, vertices=l$vertexes)
  expect_equal( network::network.size(g), nrow(l$vertexes))
} )

test_that("Disassembling undirected igraph to d.f. and assembling back to network: edgecount", {
  l <- asDF(exIgraph2)
  g <- asNetwork(l$edges, vertices=l$vertexes, directed=FALSE)
  expect_equal( network::network.edgecount(g), nrow(l$edges))
} )

test_that("Disassembling undirected igraph to d.f. and assembling back to network: vcount", {
  l <- asDF(exIgraph2)
  g <- asNetwork(l$edges, vertices=l$vertexes, directed=FALSE)
  expect_equal( network::network.size(g), nrow(l$vertexes))
} )




# From igraphs ------------------------------------------------------------

test_that("Directed igraphs via netcompare", {
  res <- netcompare( asNetwork(exIgraph), exIgraph, test=TRUE )
  expect_true(res)
} )

test_that("Undirected igraphs via netcompare", {
  res2 <- netcompare( asNetwork(exIgraph2), exIgraph2, test=TRUE )
  expect_true(res2)
} )

test_that("NAs in igraph vertex labels are copied (bug 1926)", {
  # network with NA on edge attribute
  g <- igraph::graph( c(0,1, 1,2, 2,3, 3,4, 4,2)+1, directed=TRUE)
  igraph::E(g)$label <- c(1,2,3,NA,4)
  # convert to 'network'
  net <- asNetwork(g)
  # warning that NA is converted to "NA"?
  expect_true( is.na( network::get.edge.attribute(net, "label")[4] ) )
} )



# From tibbles ------------------------------------------------------------

test_that("Network is created from edgelist as tibble", {
  edb <- tibble::tibble(
    from = 1:4,
    to = 2:5
  )
  expect_silent(
    net <- asNetwork(edb)
    )
  expect_equal( network::network.size(net), 5)
  expect_equal( network::network.edgecount(net), 4)
})

test_that("Network is created from tibbles", {
  edb <- tibble::tibble(
    from = 1:4,
    to = 2:5
  )
  vdb <- tibble::tibble(
    id = 1:5,
    ch = letters[1:5],
    stringsAsFactors = FALSE
  )
  expect_silent( net <- asNetwork(edb, vertices=vdb))
})
