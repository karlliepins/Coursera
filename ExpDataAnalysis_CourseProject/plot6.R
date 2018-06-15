# Reading data files
MainDF <- readRDS(file = "summarySCC_PM25.rds")
SourceDF <- readRDS("Source_Classification_Code.rds")

# Subsetting and summarising the necessary data
SubSource <- SourceDF[grep("Motor Vehicles", SourceDF$Short.Name),]
SubSCC <- unique(SubSource$SCC)
PlotData <- MainDF[MainDF$fips %in% c("24510","06037"),]
PlotData <- with(PlotData, aggregate(Emissions, by = list(year, fips), FUN = sum))

# Creating the plot
png(filename = "plot6.png", width = 480, height = 480)
ggplot(data = PlotData, aes(Group.1, x, colour = Group.2)) +
        geom_line(aes(group = Group.2)) +
        geom_point() +
        labs(colour = "Legend", x = "Year", y = "Emissions", title = "Emissions from Motor Vehicle Sources")
dev.off()
