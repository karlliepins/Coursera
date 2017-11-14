pollutantmean <- function(directory, pollutant, id = 1:332) {
        
        id <- formatC(id, width = 3, flag = "0")
        
        alldata <- numeric()
        
        for (x in id) {
                a <- read.csv(paste0("~/Coursera/",directory,"/", x, ".csv"), header = TRUE, sep = ",")
                alldata <- c(alldata, a[complete.cases(a[pollutant]),pollutant])
        }
        mean(alldata)
}

