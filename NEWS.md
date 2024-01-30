# intergraph 2.0-4

## Internals

Thank you @krlmlr!

- Changes induced by **igraph** 2.0.0 release: deprecating functions with dots in names (#36, #40).
- Internal S3 methods are properly exported (#38, #39). 
- Don't use `@docType package` (#37)



# intergraph 2.0-3

## User-visible changes

- Per #33, remove `as.matrix.igraph()` as it has been moved to **igraph**. Adjust the tests accordingly.
- Fix `netcompare()` and `compareAttributes()` (#34 and #35).


## Internals

- Fixed #21, #28 related to data frame vs tibble differences.
- Update tests to use **testthat**.
- Use **covr** for test coverage.
- Change email address to Gmail and add ORCID to DESCRIPTION.
- Resave data using `usethis::use_data()`.
- Refactor tests of `attrmap()`, `asIgraph()` and `asNetwork()` (#34)




# intergraph 2.0-2

Small updates due to `igraph` update to 1.0-0.

* Uprgaded included igraph objects in `data` to new data type (see `igraph::upgrade_graph`).
* Fixed tests to use `igraph::identical_graphs`.







# intergraph 2.0-1

## User visible changes

* Package moved from R-Forge to GitHub.

* Custom rules fo attribute copying using `attrmap()` should work now. Argument for supplying custom rules to `asIgraph` and `asNetwork` is renamed from `attrmap` to amap (was triggering "promise already under evaluation" errors".

* Dropped graph/network attribute `layout` that contained a function for Fruchterman-Reingold algorithm. It was triggering warnings when printing `network` objects. Now F-R is default in "igraph" anyway.

* Added 'howto' vignette demonstrating basic usage.


## Internals

* Added more tests.

* Updated `CITATION`. Uses `meta` object if available.








# intergraph 2.0-0

## User visible changes

* Renamed main functions to `asIgraph` and `asNetwork`. It was very hard to provide just methods for `as.igraph` and `as.network` without having to attach both packages at the same time. Having both attached triggers function name conflicts.

## Internals

* Whole package converted to devtools/roxygen2 setup.






# intergraph 1.3-0

First public version of the package. Main functions are:

* A method for generic `as.network` defined in package "network".
* Generic function `as.igraph` with methods.
* Function `asDF` for converting networks to a (list of) data frame(s) for edges and vertices.
* Function `dumpAttr` for dumping all attributes as listed by `list.vertex.attributes`, `list.edge.attributes`, `list.network.attributes`, and `list.graph.attributes`.

