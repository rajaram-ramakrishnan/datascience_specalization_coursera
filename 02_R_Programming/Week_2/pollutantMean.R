pollutantMean <- function(directory, pollutant, id = 1:332) {
  ## directory is a character vector of length 1 indicating
  ## the location of CSV files
  
  ## pollutant is a character vector of length 1 indicating 
  ## the name of the pollutant for which we calculate the mean
  ## either sulfate or nitrate
  
  ## id is the integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of pollutant across all monitors list
  ## in the id vector (ignoring NA values)
  
  ## NOTE : Do not round the result!
  
  drcty <- file.path(getwd(),directory)
  # Get the list of files in the directory
  files_list <- list.files(drcty)
  
  pollutant_vector <- c()
  for (i in id) {
    ## Get the file name from the List
    file_name <- file.path(drcty,files_list[i])
    ## Read CSV file and store in data
    data <- read.csv(file_name)
    ## Consider only the non NA values from the data frame
    pollutant_data <- data[!is.na(data[pollutant]),pollutant]
    ## Build the vector with pollutant values
    pollutant_vector <- c(pollutant_vector,pollutant_data)
    #final_data <- rbind(final_data,data)
  }
  
  #pollutant_data <- final_data[[pollutant]]
  #mean(pollutant_data,na.rm=TRUE)
  ## Caluclate mean
  final_pollutant <- mean(pollutant_vector)
  ## Print the mean
  print(final_pollutant)
}


pollutantMean("specdata","nitrate")
