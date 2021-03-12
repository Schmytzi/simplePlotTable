#' Adds default styles to long data
#'
#' @param long_data The data to add the styles to
#'
#' @return Modified data.frame with data and styles
add_defaults <- function(long_data){
  defaults <- geom_text()$geom$default_aes
  # The default aes is a list with class uneval.
  # We have to remove the class or else R complains about impossible coercion.
  class(defaults) <- NULL
  data.frame(long_data, defaults)
}
