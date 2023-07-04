# From 'network' objects --------------------------------------------------

test_that("asDF(exNetwork) returns data frames with proper no of rows", {
  expect_silent(
    l <- asDF(exNetwork)
  )
  # Created edgelist has appropriate number of edges
  expect_equal(nrow(l$edges), network::network.edgecount(exNetwork))
  # Created vertex data frame has correct number of vertices
  expect_equal(nrow(l$vertexes), network::network.size(exNetwork))
})

test_that("asDF(exNetwork2) returns data frames with proper no of rows", {
  expect_silent(
    l <- asDF(exNetwork2)
  )
  # Created edgelist has appropriate number of edges
  expect_equal( nrow(l$edges), network::network.edgecount(exNetwork))
  # Created vertex data frame has correct number of vertices
  expect_equal( nrow(l$vertexes), network::network.size(exNetwork))
})



# From 'igraph' objects ---------------------------------------------------

test_that("asDF(exIgraph) returns data frames with proper no of rows", {
  expect_silent(
    l <- asDF(exIgraph)
  )
  # Created edgelist has appropriate number of edges
  expect_equal(nrow(l$edges), igraph::ecount(exIgraph))
  # Created vertex data frame has correct number of vertices
  expect_equal(nrow(l$vertexes), igraph::vcount(exIgraph))
})

test_that("asDF(exIgraph2) returns data frames with proper no of rows", {
  expect_silent(
    l <- asDF(exIgraph2)
  )
  # Created edgelist has appropriate number of edges
  expect_equal( nrow(l$edges), igraph::ecount(exIgraph2))
  # Created vertex data frame has correct number of vertices
  expect_equal( nrow(l$vertexes), igraph::vcount(exIgraph2))
})

