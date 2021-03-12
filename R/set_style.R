
#' Change the appearance of cells in a table
#'
#' Allows you to set the visual appearance of single cells or ranges in a table
#'
#' @param table The SimplePlotTable to change
#' @param rows The indexes of rows which should be styled, defaults to all rows
#' @param cols The indexes of columns which should be styled, defaults to all columns
#' @param ... The properties to change. Argument names must be aesthetics accepted by [ggplot2::geom_text()].
#'
#' @details
#' This function allows for styling of cells in a SimplePlotTable.
#' The cells to be changed are identified by \code{rows} and \code{cols}.
#' Every cell that is in any of the rows and any of the columns specified is changed.
#'
#' @return A SimplePlotTable with changed styling.
#' @export
#'
#' @examples
#' # Make all cells blue
#' table <- set_style(table, col="blue")
#'
#' # Make the second column italic
#' table <- set_style(table, cols=2, fontface="italic")
#'
#' # Make rows 2 through 4 diagonal and typeset in Times New Roman
#' table <- set_style(table, rows=2:4, family="Times New Roman", angle=45)
#'
#' # Make the range of cells spanning from (2,2) to (5,8) bold
#' table <- set_style(table, rows=2:8, cols=2:5, fontface="bold")
set_style <- function(table, rows=1:table$nrow, cols=1:table$ncol, ...) {
  stopifnot(is.SimplePlotTable(table))
  cell_indexes <- which(table$data$row %in% rows & table$data$column %in% cols)
  styles <- list(...)
  for (attribute in names(styles)){
    table$style[cell_indexes, attribute] <- styles[[attribute]]
  }
  table
}

#' Set the appearance of the column headers
#'
#' @param table The table to modify
#' @param ... Styling options for the text, passed to [ggplot2::element_text()]
#'
#' @return The modified table
#' @export
#'
#' @examples
#' # Print column headers in bold
#' table <- set_column_header_style(table, face="bold")
#'
#' # Set headers to flush right
#' table <- set_column_header-style(table, hjust=1)
set_column_header_style <- function(table, ...){
  table$colstyle <- list(...)
}

#' Set the appearance of the row headers
#'
#' @param table The table to modify
#' @param ... Styling options for the text, passed to [ggplot2::element_text()]
#'
#' @return The modified table
#' @export
#'
#' @examples
#' # Print row headers in bold
#' table <- set_row_header_style(table, face="bold")
#'
#' # Set headers to flush right
#' table <- set_row_header-style(table, hjust=1)
set_row_header_style <- function(table, ...){
  table$rowstyle <- list(...)
}
