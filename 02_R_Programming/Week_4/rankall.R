## This function retrives the rank of the hospital across all states based on
## outcome from "outcome-of-care-measures.csv"

rankall <- function(outcome,num="best"){
  # Create a copy of Input Parameters
  in_outcome <- outcome
  
  # Read file through base package
  outcome <- read.csv("outcome-of-care-measures.csv",stringsAsFactors = FALSE)
  
  # Check for validations
  if (! in_outcome %in% c("heart attack","heart failure","pneumonia")){
    stop("Invalid Outcome")
  }
  
  # select only hospital_name, state, heart attack mortality,
  # heart failure mortality and pneumonia mortality rates
  outcome_select <- outcome[,c(2,7,11,17,23)]
  colnames(outcome_select) <- c("Hospital_name","state","heart attack",
                                "heart failure","pneumonia")
  
 # Convert to Numeric Variable
  outcome_select[,in_outcome] <- suppressWarnings(as.numeric(outcome_select
                                                             [,in_outcome]))
  
  # Remove NA's
  outcome_select <- outcome_select[complete.cases(outcome_select[,in_outcome]),]
  
  select_var <- "Hospital_name"
  # Order based on Outcome and then on hospital names
  ord_data <- outcome_select[order(outcome_select[["state"]],
                                   outcome_select[[in_outcome]],
                                   outcome_select[[select_var]]),
                            c("state",select_var,in_outcome)]
  
  # Logic for ranking
  rank_hosp <- c()
  if (num == "best") {
    rank_hosp <- 1
  } else if (num == "worst"){
    rank_hosp <- 2
  } else {
    rank_hosp <- as.numeric(num)
  }
  
  # Using by function produce the output based on state
  op <- by(ord_data,ord_data$state,function(x){ 
    if (rank_hosp==1){
      res <- sapply(x,head,1)
      res <- res[[2]]
    } else if (rank_hosp==2){
      res <- sapply(x,tail,1)
      res <- res[[2]]
    } else {
      res <- x[rank_hosp,]
      res <- res[[2]]
    }
  })
  # Convert By object to Data Frame
  ## Add Hospital Names
  op_int_df <- data.frame(do.call("cbind", list(op)))
  ## Add State names to DF
  rankall_df <- cbind(op_int_df,names(op))
  
  # Set Column Names
  names(rankall_df) <- c("Hospital_name","state")
  # Set rownames
  row.names(rankall_df) <- c(1:nrow(rankall_df))
  
  rankall_df
  
}



