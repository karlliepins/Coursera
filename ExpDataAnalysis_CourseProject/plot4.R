# Reading data files
MainDF <- readRDS(file = "summarySCC_PM25.rds")
SourceDF <- readRDS("Source_Classification_Code.rds")

# Subsetting and summarising the necessary data
SubSource <- SourceDF[grep("Comb", SourceDF$Short.Name),]
SubSource <- SubSource[grep("Coal", SubSource$Short.Name),]
SubSCC <- unique(SubSource$SCC)

PlotData <- MainDF[MainDF$SCC %in% SubSCC,]
PlotData <- with(PlotData, aggregate(Emissions, by = list(year), FUN = sum))

# Creating the plot
png(filename = "plot4.png", width = 480, height = 480)
with(PlotData, plot(x = Group.1, y = x, xlab = "Year", ylab = "PM2.5 emission", main = "Coal combustion related emissions in the US"))
dev.off()
