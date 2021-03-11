create_geom <- function(long_data){
  mappings <- list(x="col", y="rev(row)", label = "text")
  style_attributes <- colnames(long_data)[-(1:3)]
  mappings[style_attributes] <- style_attributes
  ggplot2::geom_text(
    data=long_data,
    mapping=do.call(ggplot2::aes_string, mappings)
  )
}


create_plot <- function(table, col_headers = TRUE, row_headers = TRUE) {
  stopifnot(is.SimplePlotTable(table))
  plot <- ggplot2::ggplot() +
    create_geom(table$data) +
    ggplot2::theme_void()
  if (col_headers) {
    plot <<- plot + scale_x_discrete(position="top", labels=table$cols)
  }
  if (row_headers) {
    plot <<- plot + scale_y_discrete(labels = rev(table$rows))
  }
  plot
}
