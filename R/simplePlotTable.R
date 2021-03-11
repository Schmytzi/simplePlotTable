
create_table <- function(data, col_names = colnames(data), row_names = rownames(data)){
  stopifnot(is.data.frame(data))
  stopifnot(is.null(col_names) || length(col_names) == ncol(data))
  stopifnot(is.null(row_names) || length(row_names) == nrow(data))

  table <- prepare_data(data)
  table$cols <- col_names
  table$rows <- row_names
  table
}

is.SimplePlotTable <- function(table) {
  "SimplePlotTable" %in% class(table)
}
