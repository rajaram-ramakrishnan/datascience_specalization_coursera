setwd("F:/Knowledge/Coursera/Data Science Specalization/Capstone Project")

## Create sample
blogs <- readLines(con = file("./final/en_US/en_US.blogs.txt"),
                   encoding= "UTF-8", skipNul = TRUE, warn = FALSE)
news <- readLines(con = file("./final/en_US/en_US.news.txt"),
                  encoding= "UTF-8", skipNul = TRUE,warn=FALSE)
twitter <- readLines(con = file("./final/en_US/en_US.twitter.txt"),
                     encoding= "UTF-8", skipNul = TRUE,warn=FALSE)


set.seed(20210103)


blogs_sample <- sample(blogs, 200000)
news_sample <- sample(news, 50000)
twitter_sample <- sample(twitter, 200000)

sampleData <- c(blogs_sample,news_sample,twitter_sample)

writeLines(sampleData, "./SampleText.txt")

rm(blogs)
rm(news)
rm(twitter)
rm(blogs_sample)
rm(news_sample)
rm(twitter_sample)
rm(sampleData)

## Data Cleaning steps
SampleCon <- file("./SampleText.txt")
sample <- readLines(SampleCon)
close(sampleCon)

profanity <- read.table("./profanityfilter.txt", header = FALSE)

library(tm)
cleanSample <- Corpus(VectorSource(sample))
rm(sample)

cleanSample <- tm_map(cleanSample, content_transformer(tolower))
cleanSample <- tm_map(cleanSample, content_transformer(removeNumbers))
removeURL <- function(x) gsub("http[[:alnum:]]*", "", x) 
cleanSample <- tm_map(cleanSample, content_transformer(removeURL))
cleanSample <- tm_map(cleanSample, stripWhitespace)
cleanSample <- tm_map(cleanSample, removeWords, stopwords("english"))
cleanSample <- tm_map(cleanSample, removeWords, profanity$V1)
library(SnowballC)
cleanSample <- tm_map(cleanSample, stemDocument)
cleanSample <- tm_map(cleanSample, stripWhitespace)

saveRDS(cleanSample, file = "./finalCorpus.RData")

rm(cleanSample)
Corpus <- readRDS(file = "./finalCorpus.RData")
sampleTDM <- TermDocumentMatrix(Corpus)
saveRDS(sampleTDM, file = "./sampleTDM.RData")

rm(Corpus)

## Ngrams

finalCorpus <- readRDS("./finalCorpus.RData")
finalCorpusDF <-data.frame(text=unlist(sapply(finalCorpus,`[`, "content")), 
                           stringsAsFactors = FALSE)
rm(finalCorpus)

## Building the tokenization function for the n-grams
ngramTokenizer <- function(Corpus, ngramCount) {
  ngramFunction <- RWeka::NGramTokenizer(Corpus, 
                                         RWeka::Weka_control(min = ngramCount, max = ngramCount))
  
  ngramFunction <- data.frame(table(ngramFunction))
  ngramFunction <- ngramFunction[order(ngramFunction$Freq, 
                                       decreasing = TRUE),]
  colnames(ngramFunction) <- c("Word","Frequency")
  ngramFunction
}

unigram <- ngramTokenizer(finalCorpusDF, 1)
saveRDS(unigram, file = "./unigram.txt")
bigram <- ngramTokenizer(finalCorpusDF, 2)
saveRDS(bigram, file = "./bigram.txt")
trigram <- ngramTokenizer(finalCorpusDF, 3)
saveRDS(trigram, file = "./trigram.txt")
quadgram <- ngramTokenizer(finalCorpusDF, 4)
saveRDS(quadgram, file = "./quadgram.txt")
