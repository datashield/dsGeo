
require(sp)

#'
#' @title Wrapper for coordinates() function from sp package
#' @description This function is a wrapper for the coordinates() function from the
#' sp package
#' @details See the coordinates() function from sp package for more details
#' @param x object of class "data.frame" to be converted to a spatial object
#' @param coord spatial coordinates; either a matrix, list, or data frame 
#' with numeric data, or column names, column number or a reference: a formula
#' (in the form of e.g. ~x+y), column numbers (e.g. c(1,2)) or
#' column names (e.g. c("x","y")) specifying which columns
#' in object are the spatial coordinates.
#' If the coordinates are part of object, giving the reference does not
#' duplicate them, giving their value does duplicate them in the resulting structure.
#' @return usually an object of class SpatialPointsDataFrame; if the coordinates
#' set cover the full set of variables in object, an object of class SpatialPoints
#' is returned
#' @author Bishop, T.
#' @export
#' 

coordinatesDS <- function(x,coord){
  
  coordinates(x) <- coord
  output <- x
  return(output)
  
}