
set_style <- function(table, rows=1:length(table$rows), cols=1:length(table$cols), ...) {
  stopifnot(is.SimplePlotTable(table))
  cell_indexes <- which(table$data$row %in% rows & table$data$col %in% cols)
  styles <- list(...)
  for (attribute in names(styles)){
    table$data[cell_indexes, attribute] <- styles[[attribute]]
  }
  table
}
