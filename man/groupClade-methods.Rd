% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/beast.R, R/codeml.R, R/codeml_mlc.R, R/ggtree.R, R/hyphy.R, R/jplace.R, R/paml_rst.R, R/phylo.R
\docType{methods}
\name{groupClade}
\alias{groupClade}
\alias{groupClade,beast-method}
\alias{groupClade,codeml-method}
\alias{groupClade,codeml_mlc-method}
\alias{groupClade,gg-method}
\alias{groupClade,ggplot-method}
\alias{groupClade,hyphy-method}
\alias{groupClade,jplace-method}
\alias{groupClade,paml_rst-method}
\alias{groupClade,phylo-method}
\title{groupClade method}
\usage{
groupClade(object, node, group_name = "group")

\S4method{groupClade}{beast}(object, node, group_name = "group")

\S4method{groupClade}{codeml}(object, node, group_name = "group")

\S4method{groupClade}{codeml_mlc}(object, node, group_name = "group")

\S4method{groupClade}{ggplot}(object, node, group_name = "group")

\S4method{groupClade}{gg}(object, node, group_name = "group")

\S4method{groupClade}{hyphy}(object, node, group_name = "group")

\S4method{groupClade}{jplace}(object, node, group_name = "group")

\S4method{groupClade}{paml_rst}(object, node, group_name = "group")

\S4method{groupClade}{phylo}(object, node, group_name = "group")
}
\arguments{
\item{object}{supported objects, including phylo, paml_rst,
codeml_mlc, codeml, jplace, beast, hyphy}

\item{node}{a internal node or a vector of internal nodes}

\item{group_name}{name of the group, 'group' by default}
}
\value{
group index
}
\description{
groupClade method
}

