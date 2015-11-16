

#'
#' @title Wrapper for SpatialLinesDataFrame() function from sp package
#' @description This function is a wrapper for the SpatialLinesDataFrame() function from the
#' sp package
#' @details See the SpatialLinesDataFrame() function from sp package for more details. 
#' create objects of class SpatialLinesDataFrame from lists of Lines objects 
#' and data.frames
#' @param lines object of class SpatialLines-class
#' @param data object of class data.frame; the number of rows in data should equal
#'  the number of Lines elements in lines.
#' @return object of class SpatialLinesDataFrame
#' @author Bishop, T.
#' @import sp
#' @export
#' 

SpatialLinesDataFrameDS <- function(lines, data){
  
  #require(sp)
  
  output <- SpatialLinesDataFrame(lines, data)
  return(output)
  
}