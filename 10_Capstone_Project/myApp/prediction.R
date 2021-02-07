
## Library
library(readr)
library(tm)
library(dplyr)
library(data.table)
library(stringr)

## read bigram, trigram and quadgram data

bidt   <- read_rds("bigram.rds")
bidt <- as.data.table(bidt)
tridt  <- read_rds("trigram.rds")
tridt <- as.data.table(tridt)
quaddt <- read_rds("quadgram.rds") 
quaddt <- as.data.table(quaddt)

setkey(bidt, text)
setkey(tridt, text)
setkey(quaddt, text)

## n-gram function definitions

bigram <- function(words) {
  out <- bidt[text==words,pred][1:3]
  ifelse(is.na(out),"?",return(out))
}


removefirstword<-function(sent){
  return(paste(unlist(str_split(sent," "))[-1],collapse=" "))
}

trigram <- function(words) {
  out <- tridt[text==words,pred][1:3]
  ifelse(is.na(out),bigram(removefirstword(words)),return(out))
}

quadgram <- function(words) {
  words <- paste(tail(unlist(str_split(words," ")),3),collapse = " ")
  out <- quaddt[text==words,pred][1:3]
  ifelse(is.na(out),trigram(removefirstword(words)),return(out))
}


ngrams <- function(input){
  input <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", input, 
                 ignore.case = TRUE, perl = TRUE)
  input <- gsub("\\S+[@]\\S+", "", input, 
                     ignore.case = FALSE, perl = TRUE)
  input <- gsub("[0-9]+(st|nd|rd|th)", "", input, 
                     ignore.case = FALSE, perl = TRUE)
  input <- gsub("[^[:alpha:][:space:]]","", input,
                     ignore.case = FALSE, perl = TRUE)
  input <- gsub("^\\s+|\\s+$", "", input)
  input <- stripWhitespace(input)
  input  <- tolower(input)
  profanitydata <- "profanityfilter.txt"
  profanity <-read_lines(file = profanitydata)
  input <- removeWords(input, profanity)
  
  count<-str_count(input,boundary("word"))
  
#  out <- ifelse(count==0,"Please Enter Text",
#                 ifelse(count == 1, bigram(input), 
#                         ifelse (count == 2, trigram(input), 
#                               quadgram(input))))
  
    if(count==0) {
      return("Please Enter Text")
    } else if(count==1){
      return(bigram(input))
    } else if(count==2){
      return(trigram(input))
    } else {
      return(quadgram(input))
    }
    
  
  # return(out)
  
}





