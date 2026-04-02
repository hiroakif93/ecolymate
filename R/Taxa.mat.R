#' Aggregate an abundance matrix to another taxonomic level
#'
#' @description
#' This function aggregates abundances to a specified taxonomic level, similar to `aggregate()`.
#'
#' @param data An abundance table in which columns represent ASVs/OTUs.
#' @param taxa A taxonomy table containing taxonomic information for each ASV/OTU.
#' @param taxaLabel A taxonomic level to which the abundance table should be aggregated.
#' @param func A function used for aggregation. The default is `sum()`.
#'
#' @examples
#' # Aggregate an OTU table to the Family level
#' library(microbiome)
#' data(atlas1006)
#'
#' data <- as.data.frame(t(otu_table(atlas1006)))
#' taxa <- tax_table(atlas1006)
#' taxaLabel <- "Family"
#' a <- Taxa.mat(data, taxa, taxaLabel)
#'
#' @export


Taxa.mat <- function(data, taxa, taxaLabel, func=function(x){sum(x)}){

    colnames(data) <- taxa[colnames(data), taxaLabel]

    summary <- do.call(cbind,
                       lapply(unique(colnames(data)),
                              function(a){ num <- which(colnames(data)==a)
                              apply(as.matrix(data[,num]), 1, func)}) )

    colnames(summary) <- unique(colnames(data))
    rownames(summary) <- rownames(data)
    summary
}
