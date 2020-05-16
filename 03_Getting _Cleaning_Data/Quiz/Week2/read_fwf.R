## Describe the width of fixed format file
## - reprsents the data to be skipped while loading
width <- c(-1,9,-5,4,-1,3,-5,4,-1,3,-5,4,-1,3,-5,4,-1,3)
## Define column names
colnames <- c("week","nino12sst","nino12ssta",
              "nino3sst","nino3ssta","nino34sst","nino34ssta",
              "nino4sst","nino4ssta")
# Load the data
data <- read.fwf("getdata_wksst8110.for",widths = width,header = FALSE,
                 skip=4,col.names =colnames )
# Calulcate sum of column 4
sum(data[,4])
