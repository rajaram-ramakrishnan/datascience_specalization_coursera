outcome <- read.csv("outcome-of-care-measures.csv",stringsAsFactors = FALSE)

outcome_select <- outcome[,c(2,7,11,17,23)]
colnames(outcome_select) <- c("Hospital_name","state","heart attack",
                              "heart failure","pneumonia")

outcome_select[,"heart attack"] <- suppressWarnings(as.numeric(outcome_select[,"heart attack"]))
outcome_select <- outcome_select[complete.cases(outcome_select[,"heart attack"]),]
ord_data <- outcome_select[order(outcome_select[["state"]],
                                 outcome_select[["heart attack"]],outcome_select[["Hospital_name"]]),
                          c("state","Hospital_name","heart attack")]

ord_data[10000,2]
num <- 3
op <- by(ord_data,ord_data$state,function(x){ 
  if (num==1){
    res <- sapply(x,head,1)
    res <- res[[2]]
  } else if (num==2){
  res <- sapply(x,tail,1)
  res <- res[[2]]
  } else {
   res <- x[10,]
   res <- res[[2]]
  }
  })
names(op)
class(op)






op_df <- data.frame(do.call("cbind", list(op)))
op_df1 <- cbind(op_df,names(op))

names(op_df1) <- c("Hospital_name","state")
row.names(op_df1) <- c(1:nrow(op_df1))


