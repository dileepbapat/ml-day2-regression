training.data.raw <- read.csv('../input/titanic_data.csv',header=T,na.strings=c(""))
#drop cabin etc as there are lot of missing values.
data <- subset(training.data.raw,select=c(2,3,5,6,7,8,10,12))
data$Age[is.na(data$Age)] <- mean(data$Age,na.rm=T)
data <- data[!is.na(data$Embarked),]
train <- data[1:800,]
test <- data[801:889,]

model <- glm(Survived ~.,family=binomial(link='logit'),data=train)

fitted.results <- predict(model,newdata=subset(test,select=c(2,3,4,5,6,7,8)),type='response')
fitted.results <- ifelse(fitted.results > 0.5,1,0)

misClasificError <- mean(fitted.results != test$Survived)
print(paste('Accuracy',1-misClasificError))
#should say something like [1] "Accuracy 0.842696629213483"