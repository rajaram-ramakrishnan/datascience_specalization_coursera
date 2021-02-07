## set working directory
setwd("F:/Knowledge/Coursera/Data Science Specalization/Capstone Project")

## Download the data
if (!file.exists("Coursera-SwiftKey.zip")){
  download.file(url = "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip", destfile = "Coursera-SwiftKey.zip")
  unzip("Coursera-SwiftKey.zip")
}

## Load the data

blogsData <- "./final/en_US/en_US.blogs.txt"
newsData <- "./final/en_US/en_US.news.txt"
twitterData <- "./final/en_US/en_US.twitter.txt"

library(readr)
library(tm)
library(quanteda)

blogs <- read_lines(file = blogsData)
news <-  read_lines(file = newsData)
twitter <- read_lines(file = twitterData)

## sampling
sampleSize <- 0.20

blogs<-sample(blogs,sampleSize*length(blogs))
news<-sample(news,sampleSize*length(news))
twitter<-sample(twitter,sampleSize*length(twitter))

sampleData <- c(blogs,news,twitter)
rm(list=c("blogs","news","twitter"))

## Data cleaning

sampleData <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", sampleData, 
                   ignore.case = TRUE, perl = TRUE)
sampleData <- gsub("\\S+[@]\\S+", "", sampleData, 
                   ignore.case = FALSE, perl = TRUE)
sampleData <- gsub("[0-9]+(st|nd|rd|th)", "", sampleData, 
                   ignore.case = FALSE, perl = TRUE)
sampleData <- gsub("[^[:alpha:][:space:]]","", sampleData,
                   ignore.case = FALSE, perl = TRUE)
sampleData <- gsub("^\\s+|\\s+$", "", sampleData)
sampleData <- stripWhitespace(sampleData)
sampleData  <- tolower(sampleData)
profanitydata <- "profanityfilter.txt"
profanity <-read_lines(file = profanitydata)
sampleData <- removeWords(sampleData, profanity)

## Build Corpus

mycorpus<-corpus(sampleData)
rm(sampleData)

toks <- tokens(mycorpus)

write_rds(toks,file="tokens.rds")
rm(mycorpus)
rm(toks)
