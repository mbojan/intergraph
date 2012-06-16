try(detach(package:intergraph, unload=TRUE))
try(detach(package:network, unload=TRUE))
library(network, lib="~/lib/R/2.11-dev")
library(intergraph, lib="../../bin")

x <- methods(as.igraph)
str(x)
methods(as.network)

testArguments <- structure(list(
    as.igraph.network = list(exNetwork)
    ), dim=c(1,1), dimnames=list(generic="as.igraph", class="network"))

testMethod <- function(method, class, args=testArguments[[method,class]])
{
  rval <- do.call(method, args)
  class(rval)
}

testMethod("as.igraph", "network")
