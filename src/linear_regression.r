install.packages("readr") #install if needed
library(readr)
data <- read_csv("../input/house_data.csv")
mark = nrow(data)*.75
train <- data[1:mark,]
test <- data[mark:nrow(data),]

linearModel <- lm(SalePrice ~  GrLivArea, data=train)
pred <- data.frame(Id = test$Id, SalePrice= predict(linearModel, test))

print(sum((test$SalePrice-pred)**2))

linearModel <- lm(SalePrice ~ OverallQual + GrLivArea + GarageCars + GarageArea + TotalBsmtSF + FullBath + TotRmsAbvGrd + YearBuilt + YearRemodAdd, data=train)
pred <- data.frame(Id = test$Id, SalePrice= predict(linearModel, test))

print(sum((test$SalePrice-pred)**2))

write_csv(pred, "output.csv")
