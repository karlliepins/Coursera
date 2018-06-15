library(ggplot2)
library(tidyr)
# Reading data files
MainDF <- readRDS(file = "summarySCC_PM25.rds")
SourceDF <- readRDS("Source_Classification_Code.rds")

# Subsetting and summarising the necessary data
PlotData <- MainDF[MainDF$fips == "24510",]
PlotData <- with(PlotData, aggregate(Emissions, by = list(year, type), FUN = sum))

# Creating the plot
png(filename = "plot3.png", width = 480, height = 480)
ggplot(data = PlotData, aes(Group.1, x, colour = Group.2)) +
        geom_line(aes(group = Group.2)) +
        geom_point() +
        labs(colour = "Legend", x = "Year", y = "Total Emissions", title = "Total Emissions by Type in Baltimore City")
        
dev.off()
