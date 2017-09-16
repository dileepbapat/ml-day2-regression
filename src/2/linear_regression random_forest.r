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

#### R, Random Forests, function randomForest(), method "anova" ####
model <- randomForest(SalePrice ~., data = train, method = "anova",
                      ntree = 300,
                      mtry = 26,
                      replace = F,
                      nodesize = 1,
                      importance = T)
predict <- predict(model, test)

# RMSE
RMSE2 <- RMSE(predict, test$SalePrice)
RMSE2 <- round(RMSE2, digits = 3)
plot2 <- predict-test$SalePrice