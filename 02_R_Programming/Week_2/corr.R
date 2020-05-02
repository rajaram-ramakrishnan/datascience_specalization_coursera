corr <- function(directory, threshold = 0) {
  ## directory is a character vector of length 1 indicating
  ## the location of CSV files
  
  ## threshold is a numeric vector of length 1 indicating the 
  ## number of completley observed observations (on all variables)
  ## required to complete the correlation between nitrate and sulfate.
  ## default is 0.
  
  ## Return numeric vector of correlations
  ## NOTE: Do not round the result
  drcty <- file.path(getwd(),directory)
  ## Get the list of files in the directory
  files_list <- list.files(drcty)
  
  # call complete function to get the details of nobs
  all_data <- complete(directory)
  
  ## Filter data which is greater than threshold
  threshold_data = subset(all_data, all_data$nobs> threshold)
  corrltn <- c()
  for (i in threshold_data$id) {
    ## Get the file name from the List
    file_name <- file.path(drcty,files_list[i])
    ## Read CSV file and store in data
    data <- read.csv(file_name)
    ## calculate correlation between nitrate and sulfate and build corrlation vector
    corrltn <- c(corrltn,cor(data$nitrate,data$sulfate,use="complete.obs")) 
    
  }
  
  ## return corrlation vector 
  corrltn
}


cr <- corr("specdata",150)
head(cr)
