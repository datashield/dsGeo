#' 
#' @title function to indicate when an individual is moving between two locations
#' @description This function is used to determine whether an individual is moving between
#' two locations, for example when commuting between home and work.
#' @details Several assumptions are made about the nature of the data being examined.
#'  It is assumed that some groundwork has been done to provide a set of flags
#'  to indicate when the individual is at either of the locations. This data is grouped per
#'   individual, the groupings are defined by an identifier column. It is most likely that
#'   the input data will be a SpatialPointsDataFrame. The points making up an individual's
#'  journey should be temporally ordered. The function is able to detect when the individual
#'   leaves one location and arrives at the other and vice versa. Journeys that start and
#'   arrive at the same location are not counted.
#' @param input name of the object (usually SpatialPointsDataFrame) which contains the 
#' points of the individuals' journeys and the two locations of interest
#' @param id_col name of the column in the data frame that identifies which points belong to
#' each individual
#' @param loc1_col name of the column in the data frame that indicates when the individual
#' is at the first location
#' @param loc2_col name of the column in the data frame that indicates when the individual
#' is at the second location
#' @return a logical vector, with TRUE indicating that the individual was travelling
#' between the two locations
#' @author Bishop, T.
#' @export

commuteDS <- function(input,id_col,loc1_col,loc2_col){  
  output <- lapply(split(input, input[[id_col]]), function(x){
    
    size<-nrow(x)
    js <- matrix(nrow=size,ncol=4)
    comm_ind <- numeric(size)
    for (i in 1:size){
      j=size+1-i
      
      if(i==1){
        js[i,1] <- x[[loc1_col]][i]
        js[i,3] <- x[[loc2_col]][i]
      }
      
      else {
        if((x[[loc1_col]][i]!=x[[loc1_col]][i-1]||js[i-1,1]==1)&&x[[loc2_col]][i]==0){
          js[i,1] <- 1
        }
        else{
          js[i,1] <- 0
        }
        
        if((x[[loc2_col]][i]!=x[[loc2_col]][i-1]||js[i-1,3]==1)&&x[[loc1_col]][i]==0){
          js[i,3] <- 1
        }
        else{
          js[i,3] <- 0
        }
        
      }      
      
      
      if(j==size){
        js[j,4] <- x[[loc1_col]][j]
        js[j,2] <- x[[loc2_col]][j]
      }
      
      else {
        if((x[[loc1_col]][j]!=x[[loc1_col]][j+1]||js[j+1,4]==1)&&x[[loc2_col]][j]==0){
          js[j,4] <- 1
        }
        else{
          js[j,4] <- 0
        }
        
        if((x[[loc2_col]][j]!=x[[loc2_col]][j+1]||js[j+1,2]==1)&&x[[loc1_col]][j]==0){
          js[j,2] <- 1
        }
        else{
          js[j,2] <- 0
        }      
        
      }   
    }
    
    for (i in 1:size){
      comm_ind[i] <- (js[i,1]&&js[i,2])||(js[i,3]&&js[i,4])
    }
    
    return(comm_ind)
  })
  
  new_comm <-unlist(output,use.names=F)
  return(new_comm)
}