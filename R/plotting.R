#' Create a table's text geom
#'
#' @param table The table object
#'
#' @return A ggplot text geom representing the data
#'
#' @export
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
#' @param object The SimplePlotTable to plot
#' @param ... Required to override [ggplot2::autoplot()], ignored for now.
#'
#' @return A ggplot object containing the table
#'
#' @details You can apply all functions to the result that you would use if ordinary plots from ggplot.
#'   The column and row headers are drawn as labels on the x and y axis, respectively.
#'   You can change their appearance using [ggplot2::theme()].
#'
#' @export
#'
#' @importFrom ggplot2 autoplot
#'
#' @examples
#' table <- new_SimplePlotTable(mtcars)
#' autoplot(table)
autoplot.SimplePlotTable <- function(object, ...) {
  stopifnot(is.SimplePlotTable(object))
  plot <- ggplot2::ggplot() +
    create_geom(object) +
    ggplot2::theme_void()  +
    ggplot2::scale_x_continuous(position="top",
                              labels=object$cols,
                              breaks=1:length(object$cols)) +
    ggplot2::scale_y_continuous(labels=rev(object$rows),
                                breaks=1:length(object$rows)) +
    ggplot2::scale_continuous_identity(c("size", "alpha", "angle")) +
    ggplot2::scale_discrete_identity(c("colour", "fontface", "family"))
  if (!is.null(object$cols)) {
    text_element <- do.call(ggplot2::element_text, object$colstyle)
    plot <- plot + ggplot2::theme(axis.text.x = text_element)
  }
  if (!is.null(object$rows)) {
    text_element <- do.call(ggplot2::element_text, object$rowstyle)
    plot <- plot + ggplot2::theme(axis.text.y = text_element)
  }
  plot
}

#' @export
ggplot2::autoplot
