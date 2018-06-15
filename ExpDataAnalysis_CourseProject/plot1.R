# Reading data files
MainDF <- readRDS(file = "summarySCC_PM25.rds")
SourceDF <- readRDS("Source_Classification_Code.rds")
 
# Subsetting and summarising the necessary data
PlotData <- with(MainDF, aggregate(Emissions, by = list(year), FUN = sum))

# Creating the plot
png(filename = "plot1.png", width = 480, height = 480)
with(PlotData, plot(x = Group.1, y = x, xlab = "Year", ylab = "Total PM2.5 emission", main = "Total emissions in the US"))
dev.off()
