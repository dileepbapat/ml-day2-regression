library(dplyr)
library(tidyr)
library(rpart)
library(randomForest)
library(ggplot2)
library(gbm)

#### Data preparation ####

# Load data
df <- read.csv("../input/train.csv", stringsAsFactors = F)
row.names(df) <- df$Id
df <- df[,-1]
df[is.na(df)] <- 0
for(i in colnames(df[,sapply(df, is.character)])){
    df[,i] <- as.factor(df[,i])
}

# create a sample vector of test values
test.n <- sample(1:nrow(df), nrow(df)/3, replace = F)

# test dataset
test <- df[test.n,]

# train dataset
train <- df[-test.n,]

rm(test.n, df)

# Evaluation metric function
RMSE <- function(x,y){
    a <- sqrt(sum((log(x)-log(y))^2)/length(y))
    return(a)
}