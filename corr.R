corr <- function(directory, threshold = 0) {
        completeDF <- complete(directory)
        res <- numeric()
        if (length(completeDF[completeDF$nobs>threshold,1]) > 0) {
                listID <- completeDF[completeDF$nobs>threshold,1]
                for (x in listID) {
                        a <- read.csv(paste0("~/Coursera/",
                                             directory,
                                             "/",
                                             formatC(x, width = 3, flag = "0"),
                                             ".csv"),
                                      header = TRUE,
                                      sep = ",")
                        a <- a[complete.cases(a),]
                        res <- c(res, cor(x = a$sulfate, y = a$nitrate))
                }
        }
        res
}


