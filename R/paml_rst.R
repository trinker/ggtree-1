##' read rst and mlb file from baseml output
##'
##'
##' @title read.baseml
##' @param rstfile rst file
##' @param mlbfile mlb file
##' @return A \code{paml_rst} object
##' @export
##' @author Guangchuang Yu \url{http://ygc.name}
##' @examples
##' rstfile <- system.file("extdata/PAML_Baseml", "rst", package="ggtree")
##' mlbfile <- system.file("extdata/PAML_Baseml", "mlb", package="ggtree")
##' read.baseml(rstfile, mlbfile)
read.baseml <- function(rstfile, mlbfile) {
    res <- read.paml_rst(rstfile)
    ## res@tip_seq <- read.tip_seq_mlb(mlbfile)
    set.paml_rst_(res)
}

##' read rst file from paml output
##'
##' 
##' @importFrom Biostrings readBStringSet
##' @importFrom Biostrings toString
##' @title read.paml_rst
##' @param rstfile rst file
##' @return A \code{paml_rst} object
##' @export
##' @author Guangchuang Yu \url{http://ygc.name}
##' @examples
##' rstfile <- system.file("extdata/PAML_Baseml", "rst", package="ggtree")
##' read.paml_rst(rstfile)
read.paml_rst <- function(rstfile) {
    ms <- read.ancseq_paml_rst(rstfile, by="Marginal")
    phylo <- read.phylo_paml_rst(rstfile)
    ## class(phylo) <- "list"
    type <- get_seqtype(ms)
    fields <- c("marginal_subs", "joint_subs")
    if (type == "NT") {
        fields <- c(fields, "marginal_AA_subs", "joint_AA_subs")
    }
    res <- new("paml_rst",
               fields          = fields,
               treetext        = read.treetext_paml_rst(rstfile),
               phylo           = phylo, 
               seq_type        = type,
               marginal_ancseq = ms,
               joint_ancseq    = read.ancseq_paml_rst(rstfile, by = "Joint"),
               rstfile = rstfile
               )
    ## if (!is.null(tip.fasfile)) {
    ##     seqs <- readBStringSet(tip.fasfile)
    ##     tip_seq <- sapply(seq_along(seqs), function(i) {
    ##         toString(seqs[i])
    ##     })
    ##     res@tip_seq <- tip_seq
    ##     res@tip.fasfile <- tip.fasfile
    ## }
    res@tip_seq <- ms[names(ms) %in% phylo$tip.label]
    
    set.paml_rst_(res)
}


##' @rdname gzoom-methods
##' @exportMethod gzoom
setMethod("gzoom", signature(object="paml_rst"),
          function(object, focus, subtree=FALSE, widths=c(.3, .7)) {
              gzoom.phylo(get.tree(object), focus, subtree, widths)
          })

##' @rdname groupOTU-methods
##' @exportMethod groupOTU
setMethod("groupOTU", signature(object="paml_rst"),
          function(object, focus, group_name="group") {
              groupOTU_(object, focus, group_name)
          }
          )

##' @rdname groupClade-methods
##' @exportMethod groupClade
setMethod("groupClade", signature(object="paml_rst"),
          function(object, node, group_name="group") {
              groupClade_(object, node, group_name)
          }
          )

##' @rdname scale_color-methods
##' @exportMethod scale_color
setMethod("scale_color", signature(object="paml_rst"),
          function(object, by, ...) {
              scale_color_(object, by, ...)
          })

##' @rdname get.tipseq-methods
##' @exportMethod get.tipseq
setMethod("get.tipseq", signature(object="paml_rst"),
          function(object, ...) {
              if (length(object@tip_seq) == 0) {
                  warning("tip sequence not available...\n")
              } else {
                  object@tip_seq
              }
          })

##' @rdname show-methods
##' @exportMethod show
setMethod("show", signature(object = "paml_rst"),
          function(object) {
              cat("'paml_rst' S4 object that stored information of\n\t",
                  paste0("'", object@rstfile, "'.\n\n"))
              ## if (length(object@tip.fasfile) != 0) {
              ##     cat(paste0(" and \n\t'", object@tip.fasfile, "'.\n\n"))
              ## } else {
              ##     cat(".\n\n")
              ## }
              fields <- get.fields(object)

              if (nrow(object@marginal_subs) == 0) {
                  fields <- fields[fields != "marginal_subs"]
                  fields <- fields[fields != "marginal_AA_subs"]
              }
              if (nrow(object@joint_subs) == 0) {
                  fields <- fields[fields != "joint_subs"]
                  fields <- fields[fields != "joint_AA_subs"]
              }
              
              cat("...@ tree:")
              print.phylo(get.tree(object))                  
              cat("\nwith the following features available:\n")
              cat("\t", paste0("'",
                               paste(fields, collapse="',\t'"),
                               "'."),
                  "\n")
          })

##' @rdname get.fields-methods
##' @exportMethod get.fields
setMethod("get.fields", signature(object = "paml_rst"),
          function(object) {
              if (length(object@tip_seq) == 0) {
                  warning("tip sequence not available...\n")
              } else {
                  get.fields.tree(object) 
              }
          }
          )

##' @rdname get.tree-methods
##' @exportMethod get.tree
setMethod("get.tree", signature(object = "paml_rst"),
          function(object) {
              object@phylo
          }
          )

##' @rdname plot-methods
##' @exportMethod plot
setMethod("plot", signature(x = "paml_rst"),
          function(x, layout        = "rectangular",
                   show.tip.label   = TRUE,
                   tip.label.size   = 4,
                   tip.label.hjust  = -0.1,
                   position         = "branch",
                   annotation       = "marginal_subs",
                   annotation.color = "black",
                   annotation.size  = 3,
                   ...) {
              plot.subs(x, layout, show.tip.label,
                        tip.label.size,
                        tip.label.hjust,
                        position, annotation,
                        annotation.color,
                        annotation.size, ...)
          })


##' @rdname get.subs-methods
##' @exportMethod get.subs
setMethod("get.subs", signature(object = "paml_rst"),
          function(object, type, ...) {
              get.subs_paml_rst(object, type)
          }
          )



