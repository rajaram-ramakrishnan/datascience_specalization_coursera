## This function retrives the rank of the hospital based on the state and outcome
## from "outcome-of-care-measures.csv"


rankHosp_dplyr <- function(state,outcome,num="best"){
  # Create a copy of Input Parameters
  in_state <- state
  in_outcome <- outcome
  
  library(readr)
  # Read file through readr package
  outcome <- read_csv("outcome-of-care-measures.csv")
  
  # Check for validations
  if (! tolower(in_state) %in% tolower(unique(outcome[["State"]]))) {
    stop("State Invalid")
  }
  
  if (! in_outcome %in% c("heart attack","heart failure","pneumonia")){
    stop("Invalid Outcome")
  }
  
  ## Rename column names
  library(dplyr)
  
  # select only hospital_name, state, heart attack mortality,
  # heart failure mortality and pneumonia mortality rates
  outcome <- outcome %>%
    select(c(2,7,11,17,23))
  
  # Rename the columns
  colnames(outcome) <- c("Hospital_name","state","heart attack",
                         "heart failure","pneumonia")
  
  # convert the outcome variable
  outcome[[in_outcome]] <- as.numeric(outcome[[in_outcome]]) 
  # Remove NA's
  outcome <- outcome[complete.cases(outcome[[in_outcome]]),]
  
  # Filter for a state
  state_outcome <- outcome %>%
    filter(tolower(state) == tolower(in_state))
  
  # Logic to calculate ranking
  rank_hosp <- c()
  if (num == "best") {
    rank_hosp <- 1
  } else if (num == "worst"){
    rank_hosp <- nrow(state_outcome)
  } else {
    rank_hosp <- as.numeric(num)
  } 
  
  ## using dplyr return hospital name based on the lower outcome rate
  select_var <- "Hospital_name"
  state_outcome <- state_outcome %>%
    select(select_var,state,in_outcome) %>%
    arrange_at(c(in_outcome,select_var)) %>%
    select(select_var) %>%
    slice(rank_hosp)
  
  print(state_outcome[[1]])
  
}



