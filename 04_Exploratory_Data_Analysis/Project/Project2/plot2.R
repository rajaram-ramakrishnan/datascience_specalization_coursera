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

## Calculate Total Emissions per year in Baltimore(fips=="24150")
NEI.baltimore.year <- NEI[fips=="24510", lapply(.SD,sum,na.rm=T), .SDcols = "Emissions", by = year]

## Plot the barplot
png(filename="plot2.png")

## barplot
barplot(NEI.baltimore.year[,Emissions], names.arg = NEI.baltimore.year[,year],
        xlab="Year",ylab="Total Emissions",main="Baltimore PM2.5 Emissions over the Years"
        )

dev.off()



