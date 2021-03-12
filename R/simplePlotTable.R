
#' Construct a new SimplePlotTable
#'
#' @param data The data.frame that should be displayed
#' @param col_names The column headers to display, defaults to data's colnames
#' @param row_names The row headers to display, defaults to data's rownames
#'
#' @return A new SimplePlotTaböe
#' @export
#'
#' @importFrom magrittr %>%
#'
#' @examples
#' new_SimplePlotTable(mtcars)
#'
#' new_SimplePlotTable(mtcars[, c("mpg", "cyl)], col_names=c("Miles/gallon", "Cylinders))
new_SimplePlotTable <- function(data, col_names = colnames(data), row_names = rownames(data)){
  stopifnot(is.data.frame(data))
  stopifnot(is.null(col_names) || length(col_names) == ncol(data))
  stopifnot(is.null(row_names) || length(row_names) == nrow(data))
  table <- list(data= prepare_data(data),
                cols = col_names,
                rows = row_names,
                ncol = ncal(data),
                nrow = nrow(data))
  class(table) <- "SimplePlotTable"
  table
}

#' Checks if the argument is a SimplePlotTable
#'
#' @param table The argument to check
#'
#' @return `TRUE` if the argument is a SimplePlotTable
#' @export
is.SimplePlotTable <- function(table) {
  "SimplePlotTable" %in% class(table)
}
