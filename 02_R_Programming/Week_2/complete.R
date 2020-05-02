complete <- function(directory, id = 1:332) {
  ## directory is a character vector of length 1 indicating
  ## the location of CSV files
  
  ## id is the integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of form :
  ## id    nobs
  ##  1    117
  ##  2    1041
  ##  ...
  ## Where id is monitor ID number and nobs is number of complete cases
  
  
  drcty <- file.path(getwd(),directory)
  ## Get the list of files in the directory
  files_list <- list.files(drcty)
  
  id_v <- c()
  nobs_v <- c()
  
  for (i in id) {
    ## Get the file name from the List
    file_name <- file.path(drcty,files_list[i])
    ## Read CSV file and store in data
    data <- read.csv(file_name)
    ## Store id in id vector
    id_v <- c(id_v, i)
    ## Store completed cases in nobs vector
    nobs_v <- c(nobs_v,sum(complete.cases(data)))
    
  }
  
  # Build a data frame
  res <- data.frame(id =id_v, nobs = nobs_v )
  res
  
}


cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))