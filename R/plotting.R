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
    ggplot2::theme_void()  +
    ggplot2::scale_x_continuous(position="top",
                              labels=table$cols,
                              breaks=1:length(table$cols)) +
    ggplot2::scale_y_continuous(labels=rev(table$rows),
                                breaks=1:length(table$rows))
  if (col_headers) {
    plot <- plot + ggplot2::theme(axis.text.x = ggplot2::element_text(face="bold"))
  }
  if (row_headers) {
    plot <- plot + ggplot2::theme(axis.text.y = ggplot2::element_text(face="bold"))
  }
  plot
}
