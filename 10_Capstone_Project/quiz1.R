size <- file.info("./final/en_US/en_US.blogs.txt")
kb <- size$size/1024
mb <- kb/1024

twitter <- readLines(con = file("./final/en_US/en_US.twitter.txt"),
                     encoding= "UTF-8", skipNul = TRUE)
length(twitter)


blogs<-file("./final/en_US/en_US.blogs.txt","r")
blogs_lines<-readLines(blogs)
close(blogs)
summary(nchar(blogs_lines))


news<-file("./final/en_US/en_US.news.txt","r")
news_lines<-readLines(news)
close(news)
summary(nchar(news_lines))

twitter<-file("./final/en_US/en_US.twitter.txt","r")
twitter_lines<-readLines(twitter)
close(twitter)
summary(nchar(twitter_lines))


love<-length(grep("love", twitter_lines))
hate<-length(grep("hate", twitter_lines))
love/hate

grep("biostats", twitter_lines, value = T)

grep("A computer once beat me at chess, but it was no match for me at kickboxing", twitter_lines)
