## set working directory
setwd("F:/Knowledge/Coursera/Data Science Specalization/Capstone Project")

library(readr)
library(data.table)
library(quanteda)

toks <- read_rds("tokens.rds")



bigram<-tokens_ngrams(toks,n=2,concatenator=" ")
bidt<-data.table(token=unname(unlist(bigram)),freq=1)
rm(bigram)
bidt<-bidt[,.(freq=sum(freq)),keyby=token]
bidt[ , c("text","pred") := tstrsplit(token," ",fixed=TRUE)] 
setorder(bidt,text,-freq)
bidt[ , prop := freq/sum(freq)]
setorder(bidt,-prop)
bidt[ , cum_prop := cumsum(prop)]
bidt_final  <- bidt[ cum_prop <= 0.5, ]
bidt_final <- bidt_final[ , c("text","pred")]
setkey(bidt_final,text)
write_rds(bidt_final, "bigram.rds")
rm(bidt)
rm(bidt_final)



trigram<-tokens_ngrams(toks,n=3,concatenator=" ")
tridt<-data.table(token=unname(unlist(trigram)),freq=1)
rm(trigram)
tridt<-tridt[,.(freq=sum(freq)),keyby=token]
tridt[ , c("text1","text2","pred") := tstrsplit(token," ",fixed=TRUE)] 
tridt[ , c("text") := paste(text1,text2)]
tridt[ , c("text1","text2") := NULL ]
setorder(tridt,text,-freq)
tridt[ , prop := freq/sum(freq)]
setorder(tridt,-prop)
tridt[ , cum_prop := cumsum(prop)]
tridt_final  <- tridt[ cum_prop <= 0.5, ]
tridt_final <- tridt_final[ , c("text","pred")]
setkey(tridt_final,text)
write_rds(tridt_final, "trigram.rds")
rm(tridt)
rm(tridt_final)


quadgram<-tokens_ngrams(toks,n=4,concatenator=" ")
quaddt<-data.table(token=unname(unlist(quadgram)),freq=1)
rm(quadgram)
quaddt<-quaddt[,.(freq=sum(freq)),keyby=token]
quaddt[ , c("text1","text2","text3","pred") := tstrsplit(token," ",fixed=TRUE)] 
quaddt[ , c("text") := paste(text1,text2,text3)]
quaddt[ , c("text1","text2","text3") := NULL ]
setorder(quaddt,text,-freq)
quaddt[ , prop := freq/sum(freq)]
setorder(quaddt,-prop)
quaddt[ , cum_prop := cumsum(prop)]
quaddt_final  <- quaddt[ cum_prop <= 0.5, ]
quaddt_final <- quaddt_final[ , c("text","pred")]
setkey(quaddt_final,text)
write_rds(quaddt_final, "quadgram.rds")
rm(quaddt)
rm(quaddt_final)
