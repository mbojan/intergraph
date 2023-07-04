test_that("Conversion for exNetwork is OK tested with netcompare", {
  # directed network
  res <- netcompare( asIgraph(exNetwork), exNetwork, test=TRUE )
  expect_true(res)
} )

test_that("Conversion for exNetwork2 is OK tested with netcompare", {
  # undirected network
  res2 <- netcompare( asIgraph(exNetwork2), exNetwork2, test=TRUE )
  expect_true(res2)
} )

test_that("Conversion of bipartite networks is not yet supported", {
  ### bipartite network (not yet supported)
  m <- matrix(0, ncol=2, nrow=3)
  m[1,1] <- m[2,1] <- m[1,2] <- m[3,2] <- 1
  net <- network::network(t(m), bipartite=TRUE, directed=FALSE)
  expect_error(asIgraph(net))
} )
