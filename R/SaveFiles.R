#' Setting saveFiles parameters.
#'
#' @param dir (character): output path name.
#' @param type (character vector): file formats.
#' @param row.names (bool or character): If a character is provided, the column name is used as row names.
#' @export

savefile_set <- function(dir = getwd(),
                         type = c('rds', 'csv', 'txt'),
                         row.names = FALSE,
                         as_name = NULL) {
  .pkg_env$sf_params <- new.env(parent = emptyenv())
  .pkg_env$sf_params$dir       <- dir
  .pkg_env$sf_params$type      <- type
  .pkg_env$sf_params$row.names <- row.names
  .pkg_env$sf_params$as_name   <- as_name

  invisible(NULL)  # 明示的に何も返さない
}

get_sf_params <- function() {
  if (is.null(.pkg_env$sf_params)) {
    stop("savefile_set() が先に呼ばれていません。")
  }
  .pkg_env$sf_params
}

#' Saving an object in various file formats
#'
#' @param type : You can save object as RDS, CSV and tab delimited format. default outputs are RDS and CSV files
#'
#' @import dplyr
#'
#' @examples
#' data(iris)
#'
#' ## Save rds and csv format
#' saveFile(obj=iris, filename='iris')
#'
#' ## Save all format
#' saveFile(obj=iris, filename='iris', type=1:3)
#'
#' @export

saveFiles <- function(obj, filename,
                      dir = getwd(),
                      row.names=FALSE,
                      type=c(1:3, 'rds', 'csv', 'tab')){

  filename <- as.character(substitute(filename))

  if (exists("sf_params", envir = .pkg_env, inherits = FALSE)) {
    params    <- .pkg_env$sf_params
    dir       <- params$dir
    type      <- params$type
    row.names <- params$row.names
    as_name   <- params$as_name
  }

  if(!dir.exists(dir)) dir.create(dir)

  ## Save as RDS if objects class is list type.
  if (is.list(obj)) {
    saveRDS(obj, file = file.path(dir, sprintf('%s.rds', filename)))
    message("Saved as RDS format.")
    return(invisible())
  }


  ## Make a column from row names.
  if (row.names) {
    obj <- obj |> tibble::rownames_to_column(var = as_name)
  }

  ## Save results.
  if (any(type %in% c('rds', 1)))
    saveRDS(obj,      file = file.path(dir, sprintf('%s.rds', filename)))
  if (any(type %in% c('csv', 2)))
    write.csv(obj,    file = file.path(dir, sprintf('%s.csv', filename)), row.names = FALSE)
  if (any(type %in% c('tab', 3)))
    write.table(obj,  file = file.path(dir, sprintf('%s.txt', filename)),
                quote = FALSE, sep = '\t', row.names = FALSE)
}
