#' Create a table's text geom
#'
#' @param table The table object
#'
#' @return A ggplot text geom representing the data
#'
#' @export
#' @examples
#' create_geom(table)
create_geom <- function(table){
  stopifnot(is.SimplePlotTable(table))
  mappings <- list(x="column", y="rev(row)", label = "text")
  style_attributes <- colnames(table$style)[-(1:2)]
  mappings[style_attributes] <- style_attributes
  ggplot2::geom_text(
    data=merge(table$data, table$style, by=c("row", "column")),
    mapping=do.call(ggplot2::aes_string, mappings)
  )
}


#' Plot a SimplePlotTable
#'
#' Creates a plot from the given SimplePlotTable using void theme.
#' You can hide headers if desired.
#'
#' @param table The SimplePlotTable to plot
#' @param col_headers Logical indicating whether column headers should be shown (default: TRUE)
#' @param row_headers Logical indicating whether row headers should be shown (default: TRUE)
#'
#' @return A ggplot object containing the table
#'
#' @details You can apply all functions to the result that you would use if ordinary plots from ggplot.
#'   The column and row headers are drawn as labels on the x and y axis, respectively.
#'   You can change their appearance using [ggplot2::theme()].
#'
#' @export
#'
#'
#' @examples
#' # Plot with all headers
#' create_plot(table)
#'
#' # Plot column headers only
#' create_plot(table, T, F)
#'
#' # Plot without headers
#' create_plot(table, F, F)
autoplot.SimplePlotTable <- function(table) {
  stopifnot(is.SimplePlotTable(table))
  plot <- ggplot2::ggplot() +
    create_geom(table) +
    ggplot2::theme_void()  +
    ggplot2::scale_x_continuous(position="top",
                              labels=table$cols,
                              breaks=1:length(table$cols)) +
    ggplot2::scale_y_continuous(labels=rev(table$rows),
                                breaks=1:length(table$rows))
  if (!is.null(table$cols)) {
    text_element <- do.call(ggplot2::element_text, table$colstyle)
    plot <- plot + ggplot2::theme(axis.text.x = text_element)
  }
  if (!is.null(table$rows)) {
    text_element <- do.call(ggplot2::element_text, table$rowstyle)
    plot <- plot + ggplot2::theme(axis.text.y = text_element)
  }
  plot
}
