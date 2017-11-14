complete <- function(directory, id = 1:332) {
        
        df <- data.frame(matrix(ncol = 2, nrow = 0))
        
        
        for (x in id) {
                a <- read.csv(paste0("~/Coursera/",directory,"/", formatC(x, width = 3, flag = "0"), ".csv"), header = TRUE, sep = ",")
                b <- nrow(a[complete.cases(a),])
                df <- rbind(df, c(x, b))
        }
        colnames(df) <- c("id", "nobs")
        df
}

