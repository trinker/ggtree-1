% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/gplot.R
\name{gplot}
\alias{gplot}
\title{gplot}
\usage{
gplot(p, data, low = "green", high = "red", widths = c(0.5, 0.5),
  color = "white", font.size = 14)
}
\arguments{
\item{p}{tree view}

\item{data}{matrix}

\item{low}{low color}

\item{high}{high color}

\item{widths}{widths of sub plot}

\item{color}{color}

\item{font.size}{font size}
}
\value{
list of figure
}
\description{
view tree and associated matrix
}
\examples{
nwk <- system.file("extdata", "sample.nwk", package="ggtree")
tree <- read.tree(nwk)
p <- ggtree(tree)
d <- matrix(abs(rnorm(52)), ncol=4)
rownames(d) <- tree$tip.label
colnames(d) <- paste0("G", 1:4)
gplot(p, d, low="green", high="red")
}
\author{
Guangchuang Yu \url{http://ygc.name}
}

