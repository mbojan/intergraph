test_that("netcompare just works",{
  expect_no_condition(
    r <- netcompare(exIgraph, exIgraph)
  )
  expect_no_condition(print(r))
})





# compareAlist ------------------------------------------------------------

test_that("compareAlist returns NA when intersection of names sets is empty", {
  l1 <- list(a=2, b=1:5, c=1:5, d=3)
  l2 <- list(B=1:5, C=5:1)
  expect_identical(compareAlist(l1, l2), as.character(NA))
} )
