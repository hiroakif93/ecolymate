#'Convert to binary matrix.
#' @importFrom Rcpp sourceCpp
#' @param mat mat is matrix.
#' @param th th is threshold.
#' @export
# -- Binarization
binary <- function(mat=NULL, th=0){
  if(is.data.frame(mat)) stop("requiring matrix class")
	Binary(mat, th)

}
