# Exploratory Data Analysis Project2

### Unzipping and Loading files

This part is common for all 6 questions. 
Files will be downloaded from the url and stored in working directory. File will be unzipped and load in to R using readRDS. 
After that data.frame will be converted to data.table for computation and plotting purpose.

``` R
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

```

### Question 1 

Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

[plot1.R](https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/blob/master/04_Exploratory_Data_Analysis/Project/Project2/plot1.R)

``` R

## Calculate Total Emissions per year
NEI.year <- NEI[, lapply(.SD,sum,na.rm=T), .SDcols = "Emissions", by = year]

## Plot the barplot
png(filename="plot1.png")
## set scientific notation off
options(scipen=999)
## barplot
barplot(NEI.year[,Emissions], names.arg = NEI.year[,year],
        xlab="Year",ylab="Total Emissions",main="PM2.5 Emissions over the Years"
        )

dev.off()

```

<img src="https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/blob/master/04_Exploratory_Data_Analysis/Project/Project2/plot1.png" >

### Question 2 

Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

[plot2.R](https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/blob/master/04_Exploratory_Data_Analysis/Project/Project2/plot2.R)

``` R

## Calculate Total Emissions per year in Baltimore(fips=="24150")
NEI.baltimore.year <- NEI[fips=="24510", lapply(.SD,sum,na.rm=T), .SDcols = "Emissions", by = year]

## Plot the barplot
png(filename="plot2.png")

## barplot
barplot(NEI.baltimore.year[,Emissions], names.arg = NEI.baltimore.year[,year],
        xlab="Year",ylab="Total Emissions",main="Baltimore PM2.5 Emissions over the Years"
        )

dev.off()

```

<img src="https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/blob/master/04_Exploratory_Data_Analysis/Project/Project2/plot2.png" >


### Question 3 

Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

[plot3.R](https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/blob/master/04_Exploratory_Data_Analysis/Project/Project2/plot3.R)

``` R

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

```

<img src="https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/blob/master/04_Exploratory_Data_Analysis/Project/Project2/plot3.png" >


### Question 4 

Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

[plot4.R](https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/blob/master/04_Exploratory_Data_Analysis/Project/Project2/plot4.R)

``` R

## Filter for Coal Combustion

comb <- grepl("Comb",SCC[, EI.Sector],ignore.case = TRUE)
coal <- grepl("Coal",SCC[, EI.Sector],ignore.case = TRUE)

## List of SCC with Combustion Coal
SCC.comb.coal <- SCC[comb&coal,]
setkeyv(SCC.comb.coal,"SCC")
setkeyv(NEI,"SCC")
# Subset Join between NEI and SCC
NEI.comb.coal <- NEI[SCC.comb.coal,nomatch=0, .(fips,SCC,Pollutant,Emissions,type,year)]


## Plot the barplot 
png(filename="plot4.png", width=480, height = 480)

## ggplot 
library(ggplot2)
options(scipen=999)
ggplot(NEI.comb.coal, aes(x= factor(year), y= Emissions)) +
  geom_col(fill="#2353d9") +
  labs(x="Year", y= expression("PM"[2.5]*" Emissions")) +
  labs(title = expression("PM"[2.5]*" Emissions- Coal Combustion Source across US from 1999-2008"))


dev.off()

```
<img src="https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/blob/master/04_Exploratory_Data_Analysis/Project/Project2/plot4.png" >


### Question 5 

How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

[plot5.R](https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/blob/master/04_Exploratory_Data_Analysis/Project/Project2/plot5.R)

``` R

## Filter for Vehicle Sources

vehicles <- grepl("vehicle",SCC[, SCC.Level.Two],ignore.case = TRUE)


## List of SCC with Vehicles
SCC.vehicles <- SCC[vehicles,]
setkeyv(SCC.vehicles,"SCC")
setkeyv(NEI,"SCC")
# Subset Join between NEI and SCC
NEI.vehicles <- NEI[SCC.vehicles,nomatch=0, .(fips,SCC,Pollutant,Emissions,type,year)]
# subset vehicles data for Baltimore
NEI.baltimore.vehicles <- NEI.vehicles[fips=="24510",]

## Plot the barplot 
png(filename="plot5.png", width=480, height = 480)

## ggplot 
library(ggplot2)

ggplot(NEI.baltimore.vehicles, aes(x= factor(year), y= Emissions)) +
  geom_col(fill="#f50c6d") +
  labs(x="Year", y= expression("PM"[2.5]*" Emissions")) +
  labs(title = expression("PM"[2.5]*" Emissions- Vehicles Source across Baltimore from 1999-2008"))


dev.off()

```
<img src="https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/blob/master/04_Exploratory_Data_Analysis/Project/Project2/plot5.png" >

### Question 6 

Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037). Which city has seen greater changes over time in motor vehicle emissions?

[plot6.R](https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/blob/master/04_Exploratory_Data_Analysis/Project/Project2/plot6.R)

``` R

## Filter for Vehicle Sources

vehicles <- grepl("vehicle",SCC[, SCC.Level.Two],ignore.case = TRUE)


## List of SCC with Vehicles
SCC.vehicles <- SCC[vehicles,]
setkeyv(SCC.vehicles,"SCC")
setkeyv(NEI,"SCC")
# Subset Join between NEI and SCC
NEI.vehicles <- NEI[SCC.vehicles,nomatch=0, .(fips,SCC,Pollutant,Emissions,type,year)]
# subset vehicles data for Baltimore
NEI.baltimore.vehicles <- NEI.vehicles[fips=="24510",][, city := "Baltimore"]
# subset vehicles data for Los Angeles
NEI.losangeles.vehicles <- NEI.vehicles[fips=="06037",][, city := "Los Angeles"]

NEI.both.vehicles <- rbind(NEI.baltimore.vehicles,NEI.losangeles.vehicles)
## Plot the barplot 
png(filename="plot6.png", width=480, height = 480)

## ggplot 
library(ggplot2)

ggplot(NEI.both.vehicles, aes(x= factor(year), y= Emissions)) +
  geom_col(aes(fill=year)) +
  facet_grid(cols=vars(city)) +
  labs(x="Year", y= expression("PM"[2.5]*" Emissions")) +
  labs(title = expression("PM"[2.5]*" Emissions- Vehicles Source across Baltimore and LosAngeles"))


dev.off()

```

<img src="https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/blob/master/04_Exploratory_Data_Analysis/Project/Project2/plot6.png" >


