prepare_data <- function(data) {
  stopifnot(is.data.frame(data))
  rownames(data) <- 1:nrow(data)
  colnames(data) <- 1:ncol(data)
  data$row <- 1:nrow(data)
  long_data <- tidyr::pivot_longer(data, !row, names_to="col", values_to="text")
  long_data$col <- as.integer(long_data$col)
  long_data
}
