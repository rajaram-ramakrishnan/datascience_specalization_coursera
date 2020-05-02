## This function calculates the best hospital in the state 
## for a outcome specified based on lower mortality rates

best_dplyr <- function(state,outcome){
## Copy of Input Parameters
  in_state <- state
  in_outcome <- outcome
  
  ## Read the file through base readr package
  library(readr)
  outcome <- read_csv("outcome-of-care-measures.csv")
  
  # Check for validations
  if (! tolower(in_state) %in% tolower(unique(outcome[["State"]]))) {
    stop("State Invalid")
  }
  
  if (! in_outcome %in% c("heart attack","heart failure","pneumonia")){
    stop("Invalid Outcome")
  }
  
  ## select only the columns we require
  library(dplyr)
  library(stringr)
  outcome <- outcome %>%
    select(c(2,7,11,17,23))
  ## Rename the columns 
  colnames(outcome) <- c("Hospital_name","state","heart attack","heart failure","pneumonia")
  
  ## Convert outcome variable to numeric
  outcome[[in_outcome]] <- as.numeric(outcome[[in_outcome]]) 
  ## Remove NA's based on outcome
  outcome <- outcome[complete.cases(outcome[[in_outcome]]),]
  
  ## Dplyr to select the best hospital
  state_outcome <- outcome %>%
  ## Filter for a state
    filter(tolower(state) == tolower(in_state)) %>%
    ## select variables
    select(Hospital_name,state,in_outcome) %>%
	## sort by outcome and then Hospital name
    arrange_at(c(in_outcome,"Hospital_name")) %>%
	## Select List of Hospitals
    select(Hospital_name) %>%
	## Chose the Best
    slice(1)
  
  ## Return
  print(state_outcome[[1]])
  
}



