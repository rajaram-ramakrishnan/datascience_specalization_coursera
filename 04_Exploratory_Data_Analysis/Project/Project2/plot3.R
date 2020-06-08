## Download file and Unzip the zip file contents

data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url=data_url,destfile="NEI.zip")
unzip(zipfile = "NEI.zip")

## Load the Data through readRDS

NEI <- readRDS(file="summarySCC_PM25.rds")
SCC <- readRDS(file="Source_Classification_Code.rds")

## Convert from data.frame to data.table
library(data.table)
NEI <- as.data.table(NEI)
SCC <- as.data.table(SCC)

## Subset Baltimore data
NEI.baltimore <- NEI[fips=="24510",]

## Plot the barplot for various types
png(filename="plot3.png", width=480, height = 480)

## ggplot 
library(ggplot2)
ggplot(NEI.baltimore, aes(x= factor(year), y= Emissions, fill =  type)) +
      geom_col() +
      facet_grid(cols=vars(type))+
      theme(legend.position = "none") +
      labs(x="Year", y= expression("PM"[2.5]*" Emissions")) +
      labs(title = expression("Baltimore City PM"[2.5]*" Emissions- by Type"))
        

dev.off()



