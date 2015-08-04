require(rgeos)

#'
#' @title Wrapper for gBuffer() function from rgeos package
#' @description This function is a wrapper for the gBuffer() function from the
#' rgeos package
#' @details See the gBuffer() function from rgeos package for more details
#' @param input sp object as defined in package sp
#' @param by_id Logical determining if the function should be applied across subgeometries
#'  (TRUE) or the entire object (FALSE)
#' @param ip_width Distance from original geometry to include in the new geometry.
#'  Negative values are allowed. Either a numeric vector of length 1 when byid is
#'  FALSE; if byid is TRUE: of length 1 replicated to the number of input 
#'  geometries, or of length equal to the number of input geometries
#' @return SpatialPolygons (or a SpatialPolygonsDataFrame if byid=TRUE and 
#' input has a data.frame); if negative width(s) lead the object to disappear,
#' NULL is returned for byid FALSE, and component Polygons objects are dropped if 
#' empty for byid TRUE; the SpatialPolygonsDataFrame is subsetted by row.names or id 
#' if given to retain non-empty geometry rows
#' @author Bishop, T.
#' @export
#' 

gBufferDS <- function(input,by_id=FALSE,ip_width){
  
  temp <- gBuffer(input, byid=by_id, width=ip_width)
  return(temp)
  
}