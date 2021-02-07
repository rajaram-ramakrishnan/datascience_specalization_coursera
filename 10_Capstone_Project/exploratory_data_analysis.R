setwd("F:/Knowledge/Coursera/Data Science Specalization/Capstone Project")

# Download and Import data
if (!file.exists("Coursera-SwiftKey.zip")){
  download.file(url = "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip", destfile = "Coursera-SwiftKey.zip")
  unzip("Coursera-SwiftKey.zip")
}

blogs <- readLines(con = file("./final/en_US/en_US.blogs.txt"),
                     encoding= "UTF-8", skipNul = TRUE, warn = FALSE)
news <- readLines(con = file("./final/en_US/en_US.news.txt"),
                   encoding= "UTF-8", skipNul = TRUE,warn=FALSE)
twitter <- readLines(con = file("./final/en_US/en_US.twitter.txt"),
                  encoding= "UTF-8", skipNul = TRUE,warn=FALSE)

# Generate file_stats
library(stringi)
file_stats <- data.frame(
                FileName = c("Blogs","News","Twitter"),
                FileSize = sapply(list(blogs,news,twitter), function(x){format(object.size(x),"MB")}),
                           t(rbind(sapply(list(blogs,news,twitter),stri_stats_general),
                           Words = sapply(list(blogs,news,twitter),stri_stats_latex)[4,]
                                  )
                             )
                        )


set.seed(20210103)
sampleSize <- 0.01

blogs_sample <- sample(blogs, length(blogs) * sampleSize)
news_sample <- sample(news, length(news) * sampleSize)
twitter_sample <- sample(twitter, length(twitter) * sampleSize)

sampleData <- c(blogs_sample,news_sample,twitter_sample)

# Generate sample stats 


samplefile_stats <- data.frame(
  FileName = c("Blogs","News","Twitter","Sample"),
  FileSize = sapply(list(blogs_sample,news_sample,twitter_sample,sampleData), function(x){format(object.size(x),"MB")}),
  t(rbind(sapply(list(blogs_sample,news_sample,twitter_sample,sampleData),stri_stats_general),
          Words = sapply(list(blogs_sample,news_sample,twitter_sample,sampleData),stri_stats_latex)[4,]
  )
  )
)


library(tm)
library(pryr)

sample_corpus <- VCorpus(VectorSource(sampleData))
object_size(sample_corpus)

sample_corpus <- tm_map(sample_corpus,content_transformer(tolower)) # convert to lower case
sample_corpus <- tm_map(sample_corpus,removePunctuation)
sample_corpus <- tm_map(sample_corpus,removeNumbers)
sample_corpus <- tm_map(sample_corpus,stripWhitespace)
sample_corpus <- tm_map(sample_corpus,PlainTextDocument)

library(RWeka)
unigram <- function(x) { NGramTokenizer(x, Weka_control(min=1, max=1))}
bigram <- function(x) { NGramTokenizer(x, Weka_control(min=2, max=2))}
trigram <- function(x) { NGramTokenizer(x, Weka_control(min=3, max=3))}
quadgram <- function(x) { NGramTokenizer(x, Weka_control(min=4, max=4))}

uni_mat <- TermDocumentMatrix(sample_corpus, control = list(tokenize = unigram))
bi_mat <- TermDocumentMatrix(sample_corpus, control = list(tokenize= bigram))
tri_mat <- TermDocumentMatrix(sample_corpus, control = list(tokenize= trigram))
quad_mat <- TermDocumentMatrix(sample_corpus, control = list(tokenize= quadgram))

## Frequencies

uni_ft <- findFreqTerms(uni_mat,lowfreq=30)
uniFreq <- rowSums(as.matrix(uni_mat[uni_ft,]))
uniFreq <- data.frame(word = names(uniFreq), frequency = uniFreq)

bi_ft <- findFreqTerms(bi_mat, lowfreq=25)
biFreq <- rowSums(as.matrix(bi_mat[bi_ft,]))
biFreq <- data.frame(word = names(biFreq), frequency = biFreq)


tri_ft <- findFreqTerms(tri_mat, lowfreq=20)
triFreq <- rowSums(as.matrix(tri_mat[tri_ft,]))
triFreq <- data.frame(word = names(triFreq), frequency = triFreq)

quad_ft <- findFreqTerms(quad_mat, lowfreq=20)
quadFreq <- rowSums(as.matrix(quad_mat[quad_ft,]))
quadFreq <- data.frame(word = names(quadFreq), frequency = quadFreq)


library(dplyr)
uniFreqDesc <- arrange(uniFreq,desc(frequency))
biFreqDesc <- arrange(biFreq,desc(frequency))
triFreqDesc <- arrange(triFreq,desc(frequency))
quadFreqDesc <- arrange(quadFreq,desc(frequency))

## Visualization
library(ggplot2)

uniBar <- ggplot(data=uniFreqDesc[1:20,], aes(x=reorder(word,-frequency), y = frequency))+
          geom_bar(stat = "identity", fill="orange")+
          xlab("Words")+
          ylab("Frequency")+
          ggtitle("Top 20 Unigrams")+
          theme(plot.title = element_text(hjust = 0.5))+
          theme(axis.text.x=element_text(angle=45, hjust=1))


biBar <- ggplot(data=biFreqDesc[1:20,], aes(x=reorder(word,-frequency), y = frequency))+
  geom_bar(stat = "identity", fill="green")+
  xlab("Words")+
  ylab("Frequency")+
  ggtitle("Top 20 Bigrams")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme(axis.text.x=element_text(angle=45, hjust=1))

triBar <- ggplot(data=triFreqDesc[1:20,], aes(x=reorder(word,-frequency), y = frequency))+
  geom_bar(stat = "identity", fill="blue")+
  xlab("Words")+
  ylab("Frequency")+
  ggtitle("Top 20 Trigrams")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme(axis.text.x=element_text(angle=45, hjust=1))

quadBar <- ggplot(data=quadFreqDesc[1:20,], aes(x=reorder(word,-frequency), y = frequency))+
  geom_bar(stat = "identity", fill="blue")+
  xlab("Words")+
  ylab("Frequency")+
  ggtitle("Top 20 Quadgrams")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme(axis.text.x=element_text(angle=45, hjust=1))

library(wordcloud)

uniCloud <- wordcloud(uniFreq$word, uniFreq$frequency, scale = c(4, 0.5), 
                      max.words = 100, random.order = FALSE, rot.per = 0.25, 
                      use.r.layout = FALSE, colors = brewer.pal(8, "Dark2"))


biCloud <- wordcloud(biFreq$word, biFreq$frequency, scale = c(4, 0.5), 
                      max.words = 100, random.order = FALSE, rot.per = 0.25, 
                      use.r.layout = FALSE, colors = brewer.pal(8, "Dark2"))


triCloud <- wordcloud(triFreq$word, triFreq$frequency, scale = c(2, 0.5), 
                     max.words = 100, random.order = FALSE, rot.per = 0.25, 
                     use.r.layout = FALSE, colors = brewer.pal(8, "Dark2"))
