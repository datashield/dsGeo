require(sp)
require(rgdal)

#'
#' @title Wrapper for proj4string() function from sp and rgdal packages
#' @description This function is a wrapper for the proj4string() function from the
#' sp and rgdal packages
#' @details See the proj4string() function from sp package for more details
#' @param x object of class "spatial-class"
#' @param projStr a valid proj4 epsg coordinate system identifier as a string e.g. 29902 for
#' Ireland
#' @return object of class "spatial-class" with the proj4string set to the value passed
#' to the function
#' @author Bishop, T.
#' @export
#' 

proj4stringDS <- function(x,projStr){
  
  newStr <- paste0("+init=epsg:",projStr)
 
  proj4string(x) <- CRS(newStr)
  
  output <- x
  return(output)
  
}