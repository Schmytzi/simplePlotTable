prepare_data <- function(data) {
  stopifnot(is.data.frame(data))
  rows <- rownames(data)
  cols <- colnames(data)
  rownames(data) <- 1:nrow(data)
  colnames(data) <- 1:ncol(data)
  data$row <- 1:nrow(data)
  long_data <- tidyr::pivot_longer(data, !row, names_to="col", values_to="text")
  result <- list(data=long_data, cols=cols, rows=rows)
  class(result) <- "SimplePlotTable"
  result
}
