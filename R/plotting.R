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
