
create_table <- function(data, col_names = colnames(data), row_names = rownames(data)){
  stopifnot(is.data.frame(data))
  colnames(data) <- col_names
  rownames(data) <- row_names
  table <- prepare_data(data)
}


is.SimplePlotTable <- function(table) {
  "SimplePlotTable" %in% class(table)
}
