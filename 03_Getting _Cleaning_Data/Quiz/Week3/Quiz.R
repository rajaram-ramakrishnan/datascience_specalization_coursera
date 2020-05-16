### Getting and cleaning Data QUiz 3 ######
## The American Community Survey distributes downloadable data about 
## United States communities. Download the 2006 microdata survey about 
## housing for the state of Idaho using download.file() from here:
  
##  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

## and load the data into R. The code book, describing the variable names is here:
  
##  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

##Create a logical vector that identifies the households on greater than 10 acres 
## who sold more than $10,000 worth of agriculture products. 

## Assign that logical vector to the variable agricultureLogical. 
## Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.

## which(agricultureLogical)

## What are the first 3 values that result?

ushousing_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(ushousing_url,destfile="ushousing.csv")

ushousing <- read.csv("ushousing.csv",stringsAsFactors = FALSE)
agricultureLogical <- ushousing$ACR==3 & ushousing$AGS ==6
head(which(agricultureLogical),n=3)


## Using the jpeg package read in the following picture of your instructor into R

## https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg

## Use the parameter native=TRUE. What are the 30th and 80th quantiles of 
## the resulting data? (some Linux systems may produce an answer 638 different 
## for the 30th quantile)

library(jpeg)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
              destfile="instructor.jpg",method="curl")

pic <- readJPEG("instructor.jpg",native=TRUE)

quantile(pic,probs=c(0.3,0.8))



## Load the Gross Domestic Product data for the 190 ranked countries in 
## this data set:
  
##  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

## Load the educational data from this data set:
  
##  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

## Match the data based on the country shortcode. How many of the IDs match? 
## Sort the data frame in descending order by GDP rank. What is the 13th country 
## in the resulting data frame?
library(readr)
GDP <- read_csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
                col_names = c("country_code","Rank","Economy","Amount"),
                col_types = "ci_cn",skip=5,quote="\"",n_max=190,trim_ws=TRUE)

education <- read_csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

merge_res <- merge(GDP,education,by.x="country_code",by.y="CountryCode")

nrow(merge_res)
merge_res[order(merge_res$Rank,decreasing=TRUE),"Economy"][13]


## What is the average GDP ranking for the "High income: OECD" and 
## "High income: nonOECD" group? 

merge_res[merge_res$`Income Group`== "High income: OECD","Rank"]
mean(merge_res[merge_res$`Income Group`== "High income: OECD","Rank"])

mean(merge_res[merge_res$`Income Group`== "High income: nonOECD","Rank"])

## Cut the GDP ranking into 5 separate quantile groups. 
## Make a table versus Income.Group. How many countries
## are Lower middle income but among the 38 nations with highest GDP?

breaks <- quantile(merge_res[, "Rank"], probs = seq(0, 1, 0.2), na.rm = TRUE)
merge_res$QuantileGDP <- cut(merge_res$Rank,breaks)

tbl <- table(merge_res$`Income Group`,merge_res$QuantileGDP)


tbl["Lower middle income","(1,38.6]"]
