library(magrittr)
library(ggplot2)
library(tidyr)

prepare_data <- function(data) {
  stopifnot(is.data.frame(data))
  rows <- rownames(data)
  cols <- colnames(data)
  rownames(data) <- 1:nrow(data)
  colnames(data) <- 1:ncol(data)
  data$y <- 1:nrow(data)
  long_data <- tidyr::pivot_longer(data, !y, names_to="x", values_to="text")
  long_data$fontface <- "plain"
  long_data$family <- "sans"
  long_data$size <- 12 / ggplot2::.pt
  long_data$hjust <- .5
  long_data$vjust <- .5
  list(data=long_data, cols=cols, rows=rows)
}

create_geom <- function(long_data){
  ggplot2::geom_text(
    data=long_data,
    mapping=aes(
      x = x,
      y = y,
      label = text,
      fontface = fontface,
      family = family,
      size = size,
      hjust = hjust,
      vjust = vjust)
  )
}
