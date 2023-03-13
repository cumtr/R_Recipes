#' Calculate the mean of each group of n elements in a vector,
#' with an optional step size
#'
#' @param vecteur a numeric vector
#' @param n a positive odd integer indicating the number of elements to consider
#' for each group. The number has to be odd for computing reasons
#' (could be improved in the future)
#' @param slide an integer indicating the number of elements to slide the window
#' forward at each iteration (default 1)
#'
#' @return a numeric vector containing the means of each group of n elements
#'
#' @examples
#' mean_groups(1:10, 3, 1)
#'
#' @export
SlidingMean <- function(vecteur, n, slide=1) {
  # Check if number is odd
  if((n %% 2) == 0) {
    print(paste(num,"is Even, please provide an odd number"))
    break
  }
  
  if(n > 1) {
    WinSizeSide = ((n-1)/2)
  }
  else {
    WinSizeSide = n
  }
  
  # Create a vector full of 0 for the means
  means <- rep(0,length(vecteur))
  
  # Loop through all groups of n elements and calculate the mean
  for (i in seq(from=WinSizeSide+1, to=length(vecteur)-n+WinSizeSide, by=slide)) {
    means[i] <- mean(vecteur[(i-WinSizeSide):(i+WinSizeSide)])
  }
  
  # Return the vector of means
  return(means)
}
