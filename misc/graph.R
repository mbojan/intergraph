source("https://bioconductor.org/biocLite.R")
biocLite("graph")


library(graph)
?graph




setClass("foo",
         slots = c(
           x = "numeric",
           y = "numeric"
         ))

o <- new("foo")


bar <- function(x, ... ) UseMethod("bar")

bar.default <- function(x, ...) {
  cat("Default method\n")
}

bar.foo <- function(x, ...) {
  cat("Foo method\n")
}


set.seed(123)
V <- LETTERS[1:4]
edL <- vector("list", length=4)
names(edL) <- V
for(i in 1:4)
  edL[[i]] <- list(edges=5-i, weights=runif(1))
gR <- graphNEL(nodes=V, edgeL=edL)
edges(gR)
edgeWeights(gR)
