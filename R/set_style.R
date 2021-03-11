
set_style <- function(table, rows=1:nrow(table), cols=1:ncol(table), ...) {
  stopifnot("SimplePlotTable" %in% class(table))
  cell_indexes <- which(table$data$row %in% rows & table$data$col %in% cols)
  styles <- list(...)
  for (attribute in names(list)){
    table$data[cell_indexes, attribute] <- list$attribute
  }
  table
}
