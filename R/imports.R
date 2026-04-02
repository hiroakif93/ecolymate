# R/imports.R

#' @importFrom utils write.csv write.table packageVersion data
#' @importFrom ggplot2 theme element_blank element_rect element_line
#'   element_text unit scale_x_continuous scale_y_continuous
#'   scale_x_discrete scale_y_discrete
#' @importFrom tibble rownames_to_column
#' @importFrom parallel makeCluster
#' @importFrom doParallel registerDoParallel
#' @importFrom Rcpp sourceCpp
#' @useDynLib ecolymate, .registration = TRUE
#'
NULL

.pkg_env <- new.env(parent = emptyenv())
utils::globalVariables(c("taxa", "data"))
