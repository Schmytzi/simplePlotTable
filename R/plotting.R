create_geom <- function(long_data){
  mappings <- list(x="col", y="rev_row", label = "text")
  style_attributes <- colnames(long_data)[-(1:3)]
  mappings[style_attributes] <- style_attributes
  ggplot2::geom_text(
    data=long_data,
    mapping=do.call(aes_string, mappings)
  )
}
