## This function retrives the rank of the hospital based on the state and outcome
## from "outcome-of-care-measures.csv"

rankhospital <- function(state,outcome,num="best"){
  # Create a copy of Input Parameters
  in_state <- state
  in_outcome <- outcome
  
  # Read file through base package
  outcome <- read.csv("outcome-of-care-measures.csv",stringsAsFactors = FALSE)
  
  # Check for validations
  if (! tolower(in_state) %in% tolower(unique(outcome[["State"]]))) {
    stop("State Invalid")
  }
  
  if (! in_outcome %in% c("heart attack","heart failure","pneumonia")){
    stop("Invalid Outcome")
  }
  
  # select only hospital_name, state, heart attack mortality,
  # heart failure mortality and pneumonia mortality rates
  outcome_select <- outcome[,c(2,7,11,17,23)]
  colnames(outcome_select) <- c("Hospital_name","state","heart attack",
                                "heart failure","pneumonia")
  
  ## Extract data for a state
  select_var <- "Hospital_name"
  # Subset for an input state
  outcome_state <- outcome_select[outcome_select$state== in_state,]
  # Convert to Numeric Variable
  outcome_state[,in_outcome] <- as.numeric(outcome_state[,in_outcome])
  # Remove NA's
  outcome_state <- outcome_state[complete.cases(outcome_state[,in_outcome]),]
  # Order based on Outcome and then on hospital names
  ord_data <- outcome_state[order(outcome_state[[in_outcome]],
                                  outcome_state[[select_var]]),
                          c(select_var,in_outcome)]
  
  # Logic for ranking
  rank_hosp <- c()
  if (num == "best") {
    rank_hosp <- 1
  } else if (num == "worst"){
    rank_hosp <- nrow(ord_data)
  } else {
    rank_hosp <- as.numeric(num)
  }
  
  # Display the ranked data
  ord_data[rank_hosp,1]
  
}



