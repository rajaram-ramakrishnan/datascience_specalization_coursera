data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
local_file <- file.path(getwd(),"ss06pid.csv")
download.file(data_url,local_file)

acs <- read.csv(local_file)

library(sqldf)
query1 <- sqldf("select pwgtp1 from acs where AGEP < 50")


## Unique and distinct

# Unique from R
uni_agep <- unique(acs$AGEP)

# Distinct from SQL
dis_agep <- sqldf("select distinct AGEP from acs")

# convert df to vec
dis_agep_vec <- dis_agep[["AGEP"]]

# check both are identical
identical(uni_agep,dis_agep_vec)
