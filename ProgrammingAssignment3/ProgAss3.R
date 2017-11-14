library(dplyr)
library(tidyr)

best <- function(stateCode, outcomeName){
        outcomeDF <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        outcomes <- c("heart attack"=11, "heart failure"=17, pneumonia=23)
        
        if (!(outcomeName %in% names(outcomes))) {
                stop("invalid outcome")
        }

        outcomeDF <- select(outcomeDF, c(2,7,outcomes[outcomeName]))
        names(outcomeDF) <- c("Name", "State", "Condition")
        if (!(stateCode %in% outcomeDF$State)) {
                stop("invalid state")
        }
        outcomeDF$Condition <- as.numeric(outcomeDF$Condition)
        
        res <- outcomeDF %>%
                filter(State == stateCode) %>% 
                filter(Condition == min(Condition, na.rm = TRUE))
        
        res[order(res$Name),][1,1]
                
                
}

rankhospital <- function(stateCode, outcomeName, ranking){
        
        outcomeDF <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        outcomes <- c("heart attack"=11, "heart failure"=17, pneumonia=23)
        
        if (!(outcomeName %in% names(outcomes))) {
                stop("invalid outcome")
        }
        
        outcomeDF <- select(outcomeDF, c(2,7,outcomes[outcomeName]))
        names(outcomeDF) <- c("Name", "State", "Condition")
        if (!(stateCode %in% outcomeDF$State)) {
                stop("invalid state")
        }
        outcomeDF$Condition <- as.numeric(outcomeDF$Condition)
        
        outcomeDF <- filter(outcomeDF, State == stateCode)
        outcomeDF <- outcomeDF[order(outcomeDF$Condition, outcomeDF$Name, na.last = NA),]
        if(ranking == "best"){
                result <- outcomeDF[1,1]
        } else if (ranking == "worst"){
                result <- outcomeDF[length(outcomeDF$Name),1]
        } else if (between(ranking,1,length(outcomeDF$Name))){
                result <- outcomeDF[ranking,1]
        } else if (!between(ranking,1,length(outcomeDF$Name))){
                result <- NA
        }
        
        return(result)
}

rankall <- function(outcomeName, ranking){
        outcomeDF <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        outcomes <- c("heart attack"=11, "heart failure"=17, pneumonia=23)
        
        if (!(outcomeName %in% names(outcomes))) {
                stop("invalid outcome")
        }
        
        outcomeDF <- select(outcomeDF, c(2,7,outcomes[outcomeName]))
        names(outcomeDF) <- c("Name", "State", "Condition")
        
        outcomeDF$Condition <- as.numeric(outcomeDF$Condition)
        outcomeDF <- outcomeDF[order(outcomeDF$State, outcomeDF$Condition, outcomeDF$Name, na.last = NA),]
        list_of_states <- split(outcomeDF, outcomeDF$State)
        list_results <- lapply(X = list_of_states, FUN = function(x){
                if(ranking == "best"){
                        result <- x[1,1]
                } else if (ranking == "worst"){
                        result <- x[length(x$Name),1]
                } else if (between(ranking,1,length(x$Name))){
                        result <- x[ranking,1]
                } else if (!between(ranking,1,length(x$Name))){
                        result <- NA
                }
                
                return(result)
        })
        resultDF <- data.frame(hospital = unlist(list_results), state = names(list_results))
}