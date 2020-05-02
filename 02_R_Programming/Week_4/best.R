## This function calculates the best hospital in the state 
## for a outcome specified based on lower mortality rates


best <- function(state,outcome){

  ## Copy of Input Parameters
  in_state <- state
  in_outcome <- outcome
  
  ## Read the file through base read.csv
  outcome <- read.csv("outcome-of-care-measures.csv",stringsAsFactors = FALSE)
  
  ## Check for Validations
  if (! tolower(in_state) %in% tolower(unique(outcome[["State"]]))) {
    stop("State Invalid")
  }
  
  if (! in_outcome %in% c("heart attack","heart failure","pneumonia")){
    stop("Invalid Outcome")
  }
  
  ## chose only the required columns
  outcome_select <- outcome[,c(2,7,11,17,23)]
  colnames(outcome_select) <- c("Hospital_name","state","heart attack",
                                "heart failure","pneumonia")

  
   select_var <- "Hospital_name"
   ## Filter for a state
   outcome_state <- outcome_select[outcome_select$state== in_state,]
   ## Convert the outcome variable to numeric
   outcome_state[,in_outcome] <- as.numeric(outcome_state[,in_outcome])
   ## Remove all NA's
   outcome_state <- outcome_state[complete.cases(outcome_state[,in_outcome]),]
   ## Calculate Min mortality outcome (Best)
   min_val <- min(outcome_state[,in_outcome])
   ## Retrive the record for minimum value
   result_set <- outcome_state[which(outcome_state[in_outcome]==min_val),
                               ][[select_var]]
   ## Order the result and do tieing						   
   result_set[order(result_set)][1]
   
}