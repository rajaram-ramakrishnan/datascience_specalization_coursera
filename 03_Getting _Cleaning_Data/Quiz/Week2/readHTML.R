url <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(url)
close(url)
c(nchar(htmlCode[10]),nchar(htmlCode[20]),nchar(htmlCode[30]),nchar(htmlCode[100]))
