#' Add alpha to colors
#'
#' This function takes a vector of colors and an optional alpha value and returns
#' the same vector of colors but with the specified alpha value added to each color.
#'
#' @param col A vector of color names or RGB values.
#' @param alpha The alpha value to be added to each color (default is 1).
#' @return A vector of colors with the same length as the input vector, but with the alpha value added to each color.
#' @examples
#' add.alpha(c("red", "blue"), 0.5)
#' add.alpha(c("#FF0000", "#0000FF"))
#' @export
add.alpha <- function(col, alpha=1) {
  
  if (missing(col)) {
    stop("Please provide a vector of colours.")
  }
  
  rgb_vals <- sapply(col, col2rgb) / 255
  
  result <- apply(rgb_vals, 2, function(x) rgb(x[1], x[2], x[3], alpha=alpha))
  
  return(result)
}
