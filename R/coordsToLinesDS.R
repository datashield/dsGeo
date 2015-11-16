#'
#' @title Convert groups of points to lines
#' @description This function converts a SpatialPointsDataFrame object into a
#'  SpatialLines object
#' @details The input object consists of sets of points grouped by an identifier. The
#' function takes each group of points and converts them into a line with an associated
#' identifier
#' @param coords object of class SpatialPointsDataFrame to be converted
#' to a SpatialLinesDataFrame
#' @param group string indicating the name of the column in the data frame that defines
#' the grouping of the sets of points
#' @return  an object of class SpatialLines, each line having an ID taken from the column
#' specified by the group variable
#' @author Bishop, T.
#' @import sp
#' @export
#' 

coordsToLinesDS <- function(coords,group){
  
  #require(sp)
  
  x <- lapply(split(coords, coords[[group]]), 
              function(x,y) Lines(list(Line(coordinates(x))),x[[y]][1L]),y=group)
  
  output <- SpatialLines(x)
  return(output)
  
}