require(sp)
require(rgeos)

#'
#' @title Wrapper for \code{over()} function from sp and rgeos package
#' @description This function is a wrapper for the \code{over()} function from the
#' sp and rgeos package.consistent spatial overlay for points, grids and polygons: 
#' at the spatial locations of object x retrieves the indexes or attributes from 
#' spatial object y. \code{over()} can be seen as a left outer join in SQL; 
#' the match is a spatial intersection.
#' @details See the over() function from sp and rgeos package for more details
#' @param x geometry (locations) of the queries
#' @param y layer from which the geometries or attributes are queried
#' @return A vector of length length(x) with the (first) index of y for each geometry 
#' (point, grid cell centre, polygon or lines) in x. If y has attribute data, attribute 
#' data are returned in a data.frame with number of rows equal to length(x)
#' @author Bishop, T.
#' @export
#' 

overDS <- function(x,y){
  
  temp <- over(x,y,fn=length)
  return(temp)
  
}